#' Build quantile baseline based on [covidModels::fit_quantile_baseline()]
#'
#' @param inc_obs Observed number of incident cases
#' @param quantiles Vector of numeric values determining which quantiles will
#' be returned in the prediction
#' @param horizon Integer value determining the time horizon until which the
#' predictions will be made
#'
#' @importFrom stats predict
#'
#' @export
build_baseline <- function(inc_obs, quantiles, horizon) {
  baseline_fit <- covidModels::fit_quantile_baseline(inc_obs)
  predict(
    baseline_fit,
    inc_obs,
    cumsum(inc_obs),
    quantiles = quantiles,
    horizon = horizon,
    num_samples = 100000
  )
}
