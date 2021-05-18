# Run and save past ensembles for all methods/dates
library(here)
library(vroom)
source(here("code", "ensemble", "utils", "run-multiple-ensembles.R"))

# Get exclusions for all weeks
exclude_by_date <- vroom(here("code", "ensemble", "EuroCOVIDhub", 
                      "manual-exclusions.csv"))

# Get all past weeks' forecast dates
all_dates <- vroom(here("code", "ensemble", "EuroCOVIDhub",
                             "method-by-date.csv")) %>%
  pull(forecast_date)

# Get all methods
all_methods <- dir(here("code", "ensemble", "forecasts"))

# Run ensembles over all methods and past forecast dates
ensembles <- run_multiple_ensembles(forecast_dates = all_dates,
                                    methods = all_methods,
                                    exclude_models = exclude_by_date)

# Save in code/ensemble/forecasts/model directory as forecast_date.csv
walk(ensembles,
     ~ vroom_write(x = .x$ensemble,
                   path = here("code", "ensemble", "forecasts", 
                               .x$method,
                               paste0(unique(.x$forecast_date), 
                                      ".csv")), 
                   delim = ","))
