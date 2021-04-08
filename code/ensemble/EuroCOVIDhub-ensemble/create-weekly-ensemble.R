# Runs and formats EuroCOVIDhub ensemble 
#  saved in data-processed/EuroCOVIDhub-ensemble
library(vroom)
library(dplyr)
library(lubridate) 
source(here("code", "ensemble", "utils", "run-ensemble.R"))

# Set up ----------------------------------------------------------------
# Get method
method <- readLines(here("code", "ensemble", "EuroCOVIDhub",  "current-method.txt"))

# Set current week of possible forecast dates
forecast_dates <- seq.Date(from = floor_date(today(), "week", 1), 
                           by = -1,
                           length.out = 6)

# Get model names for manual exclusion
exclude_models <- vroom(here("code", "ensemble", "EuroCOVIDhub", "manual-exclusions.csv")) %>%
  filter(forecast_date %in% forecast_dates) %>%
  pull(model)

# Run weekly automated ensemble -----------------------------------------
hub_ensemble <- run_ensemble(method = method,
                             forecast_date = forecast_dates,
                             exclude_models = exclude_models,
                             return_criteria = TRUE)

# Save in data-processed
vroom_write(hub_ensemble$forecast,
            here("data-processed", 
                 paste0("EuroCOVIDhub-ensemble"),
                 paste0(hub_ensemble$forecast_date, 
                        "-EuroCOVIDhub-ensemble.csv")),
            delim = ",")


# Save criteria + methods -------------------------------------------------
vroom_write(hub_ensemble$forecast,
            here("code", "ensemble", "EuroCOVIDhub-ensemble",  
                 "criteria",
                 paste0(hub_ensemble$forecast_date, ".csv")),
            delim = ",")

# Add method to csv
vroom(here("code", "ensemble", "EuroCOVIDhub-ensemble", "method.csv")) %>%
  add_row(forecast_date = hub_ensemble$forecast_date,
          method = method) %>%
  vroom_write(here("code", "ensemble", "EuroCOVIDhub-ensemble", 
                 "method-by-date.csv"),
            delim = ",")
