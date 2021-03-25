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

use_ensemble_criteria <- function(forecasts = 
                                    covidHubUtils::load_forecasts(source = "local_hub_repo",
                                                                  hub_repo_path = here(),
                                                                  hub = "ECDC",
                                                                  forecast_dates = forecast_date),
                                  exclude_models = NULL,
                                  team_name = "EuroCOVIDhub",
                                  forecast_date = floor_date(today(), "week", 1)) {
  
  # 1. Identify models with all quantiles
  quantiles <- round(c(0.01, 0.025, seq(0.05, 0.95, by = 0.05), 0.975, 0.99), 3)
  all_quantiles <- forecasts %>%
    group_by(model, target_variable, location, target_end_date) %>%
    filter(length(setdiff(quantiles, quantile)) == 0) %>%
    pull(model) %>%
    unique()
  
  # 2. Identify models with 4 week forecasts
  all_horizons <- forecasts %>%
    group_by(model, target_variable, location) %>%
    filter(any(grepl("4", horizon))) %>%
    pull(model) %>%
    unique()
  
  criteria <- tibble("forecast_date" = forecast_date, 
                     "model" = unique(forecasts$model)) %>%
    mutate(missing_quantiles = !model %in% all_quantiles,
           missing_horizons = !model %in% all_horizons,
  # 3. Manually excluded forecasts
           excluded_manually = model %in% exclude_models,
           include = !(missing_quantiles | missing_horizons | excluded_manually)) %>%
  # 4. Drop any hub ensemble models
    filter(!grepl(team_name, model))
  
  # Return
  forecasts <- filter(forecasts, 
                      model %in% filter(criteria, include)$model)
  ensemble_forecasts <- list("forecasts" = forecasts,
                             "criteria" = criteria)
  return(ensemble_forecasts)
}
