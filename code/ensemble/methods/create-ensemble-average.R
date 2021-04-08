# Create ensemble using mean or median average.
# 
# Steps:
# Takes forecasts which should come from load_ensemble_forecasts()
# Averages by mean or median
# Formats in submission format
# 
# Returns ensemble model
# 
library(dplyr)

create_ensemble_average <- function(forecasts, 
                                    method = c("mean", "median")) {
  # Set up
  ensemble <- forecasts %>%
    filter(type == "quantile") %>%
    mutate(quantile = round(quantile, 3))
  
  # Mean
  if (method == "mean") {
    ensemble <- ensemble %>%
      group_by(target_variable, horizon, temporal_resolution,
               target_end_date, location, type, quantile) %>%
      summarise(forecasts = n(),
                value = mean(value),
                .groups = "drop")
    # Median
  } else if (method == "median") {
    ensemble <- ensemble %>%
      group_by(target_variable, horizon, temporal_resolution, 
               target_end_date, location, type, quantile) %>%
      summarise(forecasts = n(),
                value = median(value),
                .groups = "drop")
  } else {
    stop("Supported methods: 'mean' or 'median'")
  }
  
  # Return ensemble
  return(ensemble)
}



