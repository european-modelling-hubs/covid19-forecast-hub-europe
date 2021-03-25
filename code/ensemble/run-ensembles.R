# Create ensembles
library(here)
library(vroom)
library(lubridate)
source(here("code", "ensemble", "load-ensemble-forecasts.R"))
source(here("code", "ensemble", "format-ensemble.R"))

# Set up ------------------------------------------------------------------
team_name <- "EuroCOVIDhub"
forecast_date <- floor_date(today(), "week", 1)

# Load forecasts by criteria ----------------------------------------------
ensemble_base <- load_ensemble_forecasts(exclude_models = NULL,
                                         forecast_date = forecast_date)
criteria <- ensemble_base$criteria
forecasts <- ensemble_base$forecasts

# Save model criteria
vroom_write(exclusion,
            here::here("code", "ensemble", "criteria",
                       paste0(forecast_date, "-criteria.csv")),
            delim = ",")

# Create mean -------------------------------------------------------------
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

# Create median -------------------------------------------------------------
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
