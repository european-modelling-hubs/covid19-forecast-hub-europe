weighted_mean <- function(x, weights) {
  return(sum(x * weights) / sum(weights))
}

weighted_median <- function(x, weights) {
  return(cNORM::weighted.quantile(x, probs = 0.5, weights = weights))
}

#' Compute weighted mean/median
#'
#' @param ... values to average
#' @param average Method to average. One of `"mean"` or `"median"`
#'
weighted_average <- function(..., average = c("mean", "median")) {

  average <- match.arg(average)

  if (average == "mean") {
    return(weighted_mean(...))
  } else if (average == "median") {
    return(weighted_median(...))
  }

}
