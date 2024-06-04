#' Impute the data implementing random forest for native corn data.
#'
#' Impute and prepare a dataframe to apply the \code{find_racialcomplex()} function,
#' in case the dataframe has missing values. The imputation is done with random
#' forests. The database must have the same variables as those in \code{bdMaiz.rds}
#' in this same package.
#'
#' @param data An incomplete dataset that contains qualitative and quantitative
#' characteristics of a corn or series of corns. The selected characteristics
#' are related to colors, some measurements, and the locations in which the corn
#'  was grown. A template for what has to be filled will be included on the
#'  GitHub page of the project.
#' @param useParallel Logical. Perform the analysis in parallel? Defaults to FALSE.
#'
#' @return \code{impute_data()}returns an imputed dataset that can be used with
#'  \code{find_racialcomplex()}.
#'
#' @author Rafael Nieves-Alvarez (\email{nievesalvarez1618@@gmail.com}), Arturo Sanchez-Porras,
#'  Aline Romero-Natale, Otilio Arturo Acevedo-Sandoval
#' @references Báez Vergara, K. J. Estimación de datos faltantes a través de
#' redes neuronales, una comparación con métodos simples y múltiples (Doctoral
#' dissertation, Universidad Santo Tomás).
#' @seealso
#' [find_racialcomplex()]
#' @export
#' @import parallel
#' @import doSNOW
#' @import missForest
#' @importFrom dplyr bind_rows
#'
#'
#' @examples
#' \donttest{
#' impute_data(data24)
#' }

impute_data <- function(data, useParallel = FALSE){
  # data is bound to the original dataset and then imputed
  if(useParallel){
    # If parallel computing is allowed the function will work faster
    cl <- parallel::makeCluster(parallel::detectCores() - 2)
    doSNOW::registerDoSNOW(cl)

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
  revised.data[,"Di\u00E1metro.longitud.de.la.mazorca_recalculado"] <- revised.data[,"Diametro.de.mazorca"] / revised.data[,"Longitud.de.mazorca"]

  return(revised.data)
}
