#' Identify the Racial Complex of native corn from Mexico
#'
#' @param data A dataset that contains qualitative and quantitative characteristics
#' of a corn ear or series of ears. The selected characteristics are related
#'  to colors, some measurements and the locations in which the corn was grown.
#'  A template for what has to be filled will be included on the GitHub page of
#'  the project.
#'
#' @return \code{findraciacomplex()}
#' returns a racial complex classification for the dataset or single observation that the user entered
#' @author Rafael Nieves-Alvarez (\email{nievesalvarez1618@@gmail.com}), Arturo Sanchez-Porras,
#'  Aline Romero-Natale, Otilio Arturo Acevedo-Sandoval
#' @references James, G., Witten, D., Hastie, T., & Tibshirani, R. (2013).
#' An introduction to statistical learning: With applications in R (1st ed.). Springer.\\
#' Kuhn, M., & Johnson, K. (2013). Applied predictive modeling (1st ed.). Springer.\\
#' Monroy, L. G. D. (2007). Estadística Multivariada: Inferencia y Métodos. Univ. Nacional.
#' @seealso
#' [impute_data()]
#' @aliases findracialcomplex
#' @export
#' @importFrom stats predict
#' @import caret
#' @import ranger
#'
#' @examples
#' df <- find_racial_complex(data31)
#' df

find_racial_complex <- function(data){

  # Run data through the Random Forest model
  prediction <- predict(Model_RF_8083, data)

  return(prediction)
}
