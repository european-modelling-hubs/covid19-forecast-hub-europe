# Runs and saves past ensembles for specified methods/dates.
# Wrapper around run_ensemble() that allows multiple methods/forecast dates.
# 
# forecast_dates : Dates vector
# methods : character vector of method/s supported in run_ensemble(),
#   (as in the named folders of code/ensemble/forecasts)
# exclude_models : optional character vector to exclude over all dates, 
#   or data.frame with cols model and forecast_date, to exclude for specific dates 
# save_forecasts : logical if TRUE saves forecasts to existing model directory
#   in code/ensemble/forecasts

library(here)
library(vroom)
library(purrr)
library(dplyr)
source(here("code", "ensemble", "utils", "run-ensemble.R"))

run_multiple_ensembles <- function(forecast_dates, 
                                   methods, 
                                   exclude_models = NULL,
                                   save_forecasts = FALSE) {
  
  # Match methods and dates
  forecast_dates <- as.Date(forecast_dates)
  method_dates <- rep(forecast_dates, each = length(methods))
  names(method_dates) <- rep(methods, length(forecast_dates))
  
  # Run ensembles
  ensembles <- imap(method_dates,
                    ~ run_ensemble(method = .y,
                                   forecast_date = .x,
                                   exclude_models = exclude_models,
                                   return_criteria = FALSE))
  
  # Save in code/ensemble/forecasts/model directory as forecast_date.csv
  if (save_forecasts) {
    iwalk(ensembles,
          ~ vroom_write(x = .x,
                        path = here("code", "ensemble", "forecasts", 
                                    .y,
                                    paste0(unique(.x$forecast_date), 
                                           ".csv")), 
                        delim = ","))
    }
  
  return(ensembles)
  
}

