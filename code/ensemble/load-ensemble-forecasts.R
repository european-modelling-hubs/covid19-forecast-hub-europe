# Load models according to inclusion criteria before ensembling
# 
# Steps:
# Loads all forecasts using covidHubUtils::load_forecasts()
# Currently, models included based on having: 
# - All quantiles
# - 4 horizons 
# - Not manually specified for exclusion 
# - Not the hub ensemble
# Returns a list:
# - "forecasts" = tibble, all forecasts passing inclusion criteria
# - "criteria" = tibble, model names and criteria assessment

load_ensemble_forecasts <- function(exclude_models = NULL,
                                    team_name = "EuroCOVIDhub",
                                    forecast_date = floor_date(today(), "week", 1)) {
  # Set up and get all forecasts
  quantiles <- round(c(0.01, 0.025, seq(0.05, 0.95, by = 0.05), 0.975, 0.99), 3)
  forecasts <- load_forecasts(source = "local_hub_repo",
                           hub_repo_path = here(),
                           hub = "ECDC",
                           forecast_dates = forecast_date)
  
  # Identify models with all quantiles
  all_quantiles <- forecasts %>%
    group_by(model, target_variable, location, target_end_date) %>%
    filter(length(setdiff(quantiles, quantile)) == 0) %>%
    pull(model) %>%
    unique()
  # Identify models with 4 week forecasts
  all_horizons <- forecasts %>%
    group_by(model, target_variable, location) %>%
    filter(any(grepl("4", horizon))) %>%
    pull(model) %>%
    unique()
  
  # Give criteria
  criteria <- tibble("forecast_date" = forecast_date, 
                     "model" = unique(forecasts$model)) %>%
    # Exclude any hub ensemble models
    filter(!grepl(team_name, model)) %>%
    # Set out all other criteria
    mutate(missing_quantiles = !model %in% all_quantiles,
           missing_horizons = !model %in% all_horizons,
           excluded_manually = model %in% exclude_models,
           include = !(missing_quantiles | missing_horizons | excluded_manually))
  
  # Filter forecasts
  forecasts <- filter(forecasts, 
                      model %in% filter(criteria, include)$model)
  
  # Return
  ensemble_forecasts <- list("forecasts" = forecasts,
                             "criteria" = criteria)
  return(ensemble_forecasts)
}
