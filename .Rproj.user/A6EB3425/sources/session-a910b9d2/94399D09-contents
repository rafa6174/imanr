#' Identify the racial complex of a native corn from Mexico
#'
#' @param data A dataset that contains qualitative and quantitative characteristics of a corn or series of corns.
#'  The selected characteristics are related to colors, some measurements and the locations in which
#'  the corn was grown. A template for what has to be filled will be included in the GitHub page of the project.
#'
#' @return \code{findraciacomplex()}
#' returns a racial complex classification for the dataset or single observation that the user entered
#' @author Rafael Nieves-Alvarez (\email{rafles091@@gmail.com}), Arturo Sanchez-Porras,
#'  Aline Romero-Natale, Otilio Arturo Acevedo-Sandoval
#' @references James, G., Witten, D., Hastie, T., & Tibshirani, R. (2013).
#' An introduction to statistical learning: With applications in R (1a ed.). Springer.\\
#' Kuhn, M., & Johnson, K. (2013). Applied predictive modeling (1a ed.). Springer.\\
#' Monroy, L. G. D. (2007). Estadística Multivariada: Inferencia y Métodos. Univ. Nacional.
#' @seealso
#' [impute_data()]
#' @aliases findracialcomplex
#' @export
#' @importFrom stats predict
#'
#' @examples
#' findracialcomplex(data20)
find_racial_complex <- function(data){
  # Load required data
  load("./data/Modelo_RF_8083.RData")
  load("./data/PreProcess.rds")

  # Preprocess the data and then run it through the Random Forest model
  processed.data <- predict(preProcValues, data)
  prediction <- predict(fit_RF, processed.data)

  return(prediction)
}
