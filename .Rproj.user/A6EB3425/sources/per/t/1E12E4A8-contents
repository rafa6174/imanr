# Impute the data
#' Title
#'
#' @param data
#' @param useParallel
#'
#' @return
#' @export
#'
#' @examples
impute_data <- function(data, useParallel = TRUE){
  # Load the original dataset so that input data can be imputed with these parameters
  load("./data/bdMaiz.rds")

  # data is bound to the original dataset and then imputed
  if(useParallel){
    # If parallel computing is allowed the function will work faster
    cl <- parallel::makeCluster(parallel::detectCores() - 2)
    doSNOW::registerDoSNOW(cl)

    progress <- function(n) setTxtProgressBar(pb, n)
    opts <- list(progress=progress)

    parallel::clusterExport(cl, list("missForest"))

    imp.data <- bind_rows(bdMaiz[, c(4:64)], data) |>
      missForest::missForest(parallelize = "forests", verbose = TRUE)
  } else {
    imp.data <- bind_rows(bdMaiz[, c(4:64)], data) |>
      missForest::missForest(verbose = TRUE)
  }

  # Data is cropped from the imputation dataset and then some variables are mutated
  revised.data <- imp.data$ximp[c(18568:(18567+dim(data)[1])),]
  revised.data[,"Hileras.por.mazorca"] <- round(revised.data[, "Hileras.por.mazorca"])
  revised.data[,"Diámetro.longitud.de.la.mazorca_recalculado"] <- revised.data[,"Diametro.de.mazorca"] / revised.data[,"Longitud.de.mazorca"]

  return(revised.data)
}
