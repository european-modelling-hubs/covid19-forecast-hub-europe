# Format ensemble
#
# Converts a quantile-only ensemble based on covidHubUtils::load_forecasts()
# to standardised submission format
#
# Steps:
# Creates "target" variable
# Adds point forecasts from 0.5 quantile
#
library(dplyr)

format_ensemble <- function(ensemble,
                            forecast_date,
                            temporal_resolution = "wk") {

  ensemble <- ungroup(ensemble)

  # Add target end date
  if (!"target_end_date" %in% names(ensemble)) {
    ensemble <- ensemble %>%
      mutate(target_end_date = ((forecast_date +
                                   (7 - wday(forecast_date)) - 7 ) +
                                (7 * horizon)))
  }

  # Add type
  if (!"type" %in% names(ensemble)) {
    ensemble <- ensemble %>%
      mutate(type = "quantile")
  }

  # Set target and model
  ensemble <- ensemble %>%
    mutate(forecast_date = !!forecast_date,
           target = paste(horizon, temporal_resolution,
                          "ahead", target_variable)) %>%
    # Keep only standard columns
    select(forecast_date, target, target_end_date,
           location, type, quantile, value)

  # Add point forecasts
  ensemble_point <- ensemble %>%
    filter(quantile == 0.5) %>%
    mutate(type = "point",
           quantile = NA_real_)
  ensemble_with_point <- ensemble %>%
    bind_rows(ensemble_point)

  return(ensemble_with_point)
}
