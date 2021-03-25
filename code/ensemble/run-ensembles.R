# Run all ensembling methods
# 
# Steps:
# Loads all forecasts using covidHubUtils::load_forecasts()
# Filters models according to criteria
# Saves inclusion criteria
# Runs, formats, and saves in relevant data-processed folder:
#  - mean ensemble
#  - median ensemble
# 
library(here)
library(vroom)
library(lubridate)
library(covidHubUtils)
source(here("code", "ensemble", "utils", "use-ensemble-criteria.R"))
source(here("code", "ensemble", "utils", "format-ensemble.R"))

# Set up ----------------------------------------------------------------
team_name <- "EuroCOVIDhub"
forecast_date <- floor_date(today(), "week", 1)

# Character vector of model names for manual exclusion
# - e.g. exclusion because of late submission
exclude_models <- c()

# Load forecasts and save criteria --------------------------------------------
# Get all forecasts
forecasts <- load_forecasts(source = "local_hub_repo",
                            hub_repo_path = here(),
                            hub = "ECDC",
                            forecast_dates = forecast_date)

# Filter by inclusion criteria
ensemble_base <- use_ensemble_criteria(forecasts = forecasts,
                                       team_name = team_name,
                                       exclude_models = exclude_models,
                                       forecast_date = forecast_date)
forecasts <- ensemble_base$forecasts

# Save criteria
criteria <- ensemble_base$criteria
vroom_write(criteria,
            here::here("code", "ensemble", "criteria",
                       paste0(forecast_date, "-criteria.csv")),
            delim = ",")

# Run averaged ensembles ---------------------------------------------------
source(here("code", "ensemble", "methods", "create-ensemble-average.R"))

## Mean
model_name <- "ensemble"
ensemble_mean <- create_ensemble_average(method = "mean",
                                         model_name = model_name,
                                         team_name = team_name,
                                         forecasts = forecasts,
                                         forecast_date = forecast_date)
ensemble_mean <- format_ensemble(ensemble_mean)

vroom_write(ensemble_mean,
            here("data-processed", 
                 paste0(team_name, "-", model_name),
                 paste0(forecast_date, "-", 
                        team_name, "-", model_name, ".csv")),
            delim = ",")

## Median
model_name <- "median"
ensemble_median <- create_ensemble_average(method = "median",
                                         model_name = model_name,
                                         team_name = team_name,
                                         forecasts = forecasts,
                                         forecast_date = forecast_date)
ensemble_median <- format_ensemble(ensemble_median)
vroom_write(ensemble_median,
            here("data-processed", 
                 paste0(team_name, "-", model_name),
                 paste0(forecast_date, "-", 
                        team_name, "-", model_name, ".csv")),
            delim = ",")
