# Wrapper to build baseline because S3 doesn't usually work well with pipe
# workflows
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
