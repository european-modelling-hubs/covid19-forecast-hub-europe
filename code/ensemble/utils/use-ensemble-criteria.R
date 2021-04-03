# Load models according to inclusion criteria before ensembling
# 
# Steps:
# Currently, models included based on having: 
# 1. All quantiles
# 2. 4 horizons 
# 3. Not manually specified for exclusion 
# 4. Not the hub ensemble
# 
# Returns a list:
# - "forecasts" = tibble, all forecasts passing inclusion criteria
# - "criteria" = tibble, model names and criteria assessment
# 
library(dplyr)
library(tibble)
library(lubridate)
library(here)

use_ensemble_criteria <- function(forecasts = 
                                    covidHubUtils::load_forecasts(source = "local_hub_repo",
                                                                  hub_repo_path = here(),
                                                                  hub = "ECDC",
                                                                  forecast_dates = floor_date(today(), "week", 1)),
                                  forecast_date = floor_date(today(), "week", 1),
                                  exclude_models = NULL,
                                  team_name = "EuroCOVIDhub") {
  
  # Remove point forecasts
  forecasts <- filter(forecasts, type == "quantile")
  
  # 1. Identify models with all quantiles
  quantiles <- round(c(0.01, 0.025, seq(0.05, 0.95, by = 0.05), 0.975, 0.99), 3)
  all_quantiles <- forecasts %>%
    # Check all quantiles per target/location
    group_by(model, target_variable, location, target_end_date) %>%
    summarise(all_quantiles_present = setequal(quantile, quantiles)) %>%
    # Check all quantiles at all horizons
    group_by(model, target_variable, location) %>%
    summarise(all_quantiles_all_horizons = all(all_quantiles_present))
  
  # 2. Identify models with 4 week forecasts
  horizons <- 1:4
  all_horizons <- forecasts %>%
    group_by(model, target_variable, location) %>%
    summarise(all_horizons = setequal(horizon, horizons))
  
  # 3. Manually excluded forecasts
  criteria <- all_quantiles %>%
    left_join(all_horizons, 
              by = c("model", "target_variable", "location")) %>%
    mutate(excluded_manually = model %in% exclude_models,
           include = all(all_quantiles_all_horizons, all_horizons) & !excluded_manually)  %>%
  # 4. Drop hub ensemble model
    filter(!grepl(team_name, model))
  
  include <- filter(criteria, include) %>%
    select(model, target_variable, location)
  
  # Return
  forecasts <- inner_join(forecasts, include, 
                          by = c("model", "target_variable", "location"))
  
  ensemble_forecasts <- list("forecasts" = forecasts,
                             "criteria" = criteria)
  return(ensemble_forecasts)
}
