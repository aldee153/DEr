#' @title CustomerType
#'
#' @description This function allows you calculate logloss on a dataset.
#' @param
#' @keywords logloss
#' @export
#' @examples
#' LogLoss()

LogLoss <- function(pred, res){
  (-1/length(pred)) * sum(res * log(pred) + (1-res)*log(1-pred))
}