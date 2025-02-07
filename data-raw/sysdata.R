## code to prepare `sysdata` dataset goes here

# Code to prepare the PreProcess values for the Boosted Ensemble model ----
library(dplyr)
library(tidymodels)
# get the data
bdMaiz <- readr::read_csv("~/Documentos/R/ICRaMaN/data/maices_clasificados.csv") |>
  dplyr::select(c(1:60, 69:73, 75:79, 82:87)) |>
  dplyr::select(c(1:63, 67)) |>
  dplyr::mutate(Altitud = ifelse(Altitud == 9999, NA, Altitud)) |>
  dplyr::select(-c(1:2)) |>
  dplyr::mutate(Complejo.racial = as.factor(Complejo.racial)) |>
  as.data.frame()

# Imputing missing values
na_columns <- colnames(bdMaiz)[colSums(is.na(bdMaiz)) > 0]
no_na_columns <- colnames(bdMaiz)[colSums(is.na(bdMaiz)) == 0]
datos_imputados <- bdMaiz
predictores <- bdMaiz |> select(-all_of(na_columns))
faltantes <- bdMaiz |> select(all_of(na_columns))

for(col in na_columns){
  temp_data <- bdMaiz |>
    filter(!is.na(.data[[col]])) |>
    select(col, no_na_columns)
  pred <- temp_data |> select(-all_of(col))
  target <- temp_data[[col]]

  modelo <- rand_forest() |>
    set_engine("ranger") |>
    set_mode("regression")

  workflow <- workflow() |>
    add_model(modelo) |>
    add_formula(as.formula(paste(col, "~ ."))) |>
    fit(data = temp_data)

  bdMaiz[is.na(bdMaiz[[col]]), col] <- predict(workflow, bdMaiz[is.na(bdMaiz[[col]]), ])
}

# set a seed and then split the data
set.seed(42)
maiz_split <- rsample::initial_split(bdMaiz,
                                     prop = 0.75,
                                     strata="Complejo.racial")
maiz_train <- rsample::training(maiz_split)
maiz_test <- rsample::testing(maiz_split)

# k-fold cross-validation
maiz_folds <- rsample::vfold_cv(maiz_train, v = 5)


# Tuning a Boosted Ensemble model
library(tidymodels)
library(yardstick)

boosted_untuned <- boost_tree(trees = 500,
                              learn_rate = tune(),
                              tree_depth= tune(),
                              sample_size= tune()) |>
  set_engine("xgboost") |>
  set_mode("classification")


boosted_params <- hardhat::extract_parameter_set_dials(boosted_untuned)

boosted_grid <- grid_random(parameters(boosted_untuned),
                            size = 8)

boosted_tuned <- tune_grid(boosted_untuned,
                           Complejo.racial ~ .,
                           resamples = maiz_folds,
                           grid = boosted_grid,
                           metrics = metric_set(bal_accuracy, f_meas))

collect_metrics(boosted_tuned, summarize=TRUE)
autoplot(boosted_tuned)

boosted_final <- select_best(boosted_tuned, metric = "bal_accuracy")
boosted_final

boosted_best <- finalize_model(boosted_untuned,
                               boosted_final)
boosted_best

BE_model <- boosted_best |>
  fit(Complejo.racial ~ .,,
      data = maiz_train)

print(BE_model)


# Make slices of data for testing and using in examples ----
data31 <- bdMaiz[c(120:151), c(4:64)]

data24 <- bdMaiz[c(164:187), c(4:64)]

# Prepare the database that will be used as basis for impute_data ----
# Create a list that separates each racial complex into its own dataframe
complejos <- unique(bdMaiz$Complejo.racial)
listacomplejos <- list()
for(i in complejos){
  listacomplejos[[i]] <- filter(bdMaiz, Complejo.racial == i) |>
    #select(c(4:64)) |>
    arrange(Longitud.de.mazorca)
}

# Fill the empty data for Chapalote. We will impute this as it doesn't have a lot of observations
chaps_imputado <- missForest::missForest(listacomplejos$Chapalote)

# Clean the table from the most abundant type of NA, then impute for still missing data
bdMaiz_imputado <- bdMaiz |>
  filter(!is.na(Diámetro.longitud.de.la.mazorca_recalculado)) |>
  filter(Complejo.racial != "Chapalote") |>
  missForest::missForest()

# Merge both dataframes and save as the final data to be used in impute_data()
bdMaiz <- bind_rows(bdMaiz_imputado$ximp, chaps_imputado$ximp) |>
  arrange(Complejo.racial, Raza.primaria)

# Calculate the imputation of data24, so that it can be used in the tests ----
data24_imputed <- imanr::impute_data(data24, useParallel = TRUE)

usethis::use_data(BE_model, bdMaiz, data24_imputed,
                  internal = TRUE,
                  overwrite = TRUE,
                  compress = "xz")

