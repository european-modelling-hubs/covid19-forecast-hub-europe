# Runs and saves past ensembles for specified methods/dates.
# Wrapper around run_ensemble() that allows multiple methods/forecast dates.
#
# forecast_dates : Dates vector
# methods : character vector of method/s supported in run_ensemble(),
#   (as in the named folders of code/ensemble/forecasts)
# exclude_models : optional character vector to exclude over all dates,
#   or data.frame with cols model and forecast_date, to exclude for specific dates
#
# Returns a list of ensembles with forecasts, method, forecast date, criteria

library(here)
library(vroom)
library(purrr)
library(dplyr)
source(here("code", "ensemble", "utils", "run-ensemble.R"))

run_multiple_ensembles <- function(forecast_dates,
                                   methods,
                                   ...) {

  # Match methods and dates
  forecast_dates <- as.Date(forecast_dates)
  dates <- rep(forecast_dates, each = length(methods))
  methods <- rep(methods, length(forecast_dates))

  # Run ensembles
  safe_run_ensemble <- safely(run_ensemble, otherwise = NULL)
  ensembles <- map2(methods,
                    dates,
                    ~ safe_run_ensemble(method = .x,
                                        forecast_date = .y,
                                        ...))

  # Add descriptive name
  names(ensembles) <- paste(methods, dates, sep = "-")

  return(ensembles)

}
