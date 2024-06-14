## code to prepare `sysdata` dataset goes here

# Code to prepare the PreProcess values for the Random Forest model ----
# get the data
bdMaiz <- readr::read_csv("~/Documentos/R/ICRaMaN/data/maices_clasificados.csv") |>
  dplyr::select(c(1:60, 69:73, 75:79, 82:87)) |>
  dplyr::select(c(1:63, 67)) |>
  dplyr::mutate(Altitud = ifelse(Altitud == 9999, NA, Altitud)) |>
  as.data.frame()

bdMaiz[,2]<-as.factor(bdMaiz[,2])
bdMaiz[,3]<-as.factor(bdMaiz[,3])

# set a seed and then split the data
set.seed(42)
inTraining <- caret::createDataPartition(bdMaiz$Complejo.racial, p = 0.70, list = FALSE)
training <- bdMaiz[inTraining, c(3:64)] |> as.data.frame()
testing <- bdMaiz[-inTraining, c(3:64)] |> as.data.frame()


# Prepare the preProcess values
# We selected centering, scaling, and process zero variance data,
# imputation is not done because we prepared a different function for that
PreProcess <- caret::preProcess(training,
                                method = c("center", "scale", "zv"))

trainTransformed <- predict(PreProcess, training) |> imanr::impute_data(useParallel = TRUE)
testTransformed <- predict(PreProcess, testing) |> imanr::impute_data(useParallel = TRUE)

trainTransformed <- imanr::impute_data(training, useParallel = TRUE)
testTransformed <- imanr::impute_data(testing, useParallel = TRUE)

# Train the model, waiting for the best to happen ----
set.seed(42)

fitControl <- caret::trainControl(method = "cv",  # Cross validation
                           number = 10,    # Number of folds in the cross validation
                           savePredictions = "final"
)

grid <- expand.grid(.mtry = c(2, 4, 6, 8, 10),  # Number of considered variables for each division
                    .splitrule = "gini",
                    .min.node.size = c(1)  # Minimun node size
)

Model_RF_8083 <- caret::train(as.factor(Complejo.racial) ~.,
                data = trainTransformed,
                method = "ranger",
                # preProcess = c("center", "scale", "zv"),
                trControl = fitControl,
                tuneGrid = grid,
                verbose = TRUE)

print(Model_RF_8083)
plot(Model_RF_8083)

# Testing the model
p_RF <- predict(Model_RF_8083, newdata = testTransformed)
confMat_RF <- caret::confusionMatrix(p_RF, as.factor(testTransformed$Complejo.racial))
confMat_RF$overall["Accuracy"]

# Save the model
# save(Model_RF_8083, file = "./R/Model_RF_8083.rda")

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
data24_imputed <- impute_data(data24, useParallel = TRUE)

usethis::use_data(PreProcess, Model_RF_8083, bdMaiz, data24_imputed,
                  internal = TRUE,
                  overwrite = TRUE,
                  compress = "xz")

