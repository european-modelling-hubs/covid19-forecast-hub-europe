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
                            forecast_date) {
  
  # Format as standard forecast
  ensemble <- ensemble %>%
    mutate(forecast_date = forecast_date,
           target = paste(horizon, temporal_resolution, 
                          "ahead", target_variable)) %>%
    select(forecast_date, target, target_end_date,
           location, type, quantile, value)
  
  # round
  ensemble <- ensemble %>%
    mutate(value = round(value))

  # Add point forecasts
  ensemble_point <- ensemble %>%
    filter(quantile == 0.5) %>%
    mutate(type = "point",
           quantile = NA_real_)
  
  ensemble_with_point <- ensemble %>%
    bind_rows(ensemble_point)
  
  return(ensemble_with_point)
}
