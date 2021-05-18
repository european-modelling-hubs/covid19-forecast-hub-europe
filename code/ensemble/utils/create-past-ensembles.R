# Run and save past ensembles for all methods/dates
library(here)
library(vroom)
source(here("code", "ensemble", "utils", "run-multiple-ensembles.R"))

# Get exclusions for all weeks
exclude_by_date <- vroom(here("code", "ensemble", "EuroCOVIDhub", 
                      "manual-exclusions.csv"))

# Get all past weeks' forecast dates
all_dates <- dir(here("data-processed", "EuroCOVIDhub-ensemble"))
all_dates <- all_dates[!grepl("metadata", all_dates)]
all_dates <- as.Date(substr(all_dates, 1, 10))

# Get all methods
all_methods <- dir(here("code", "ensemble", "forecasts"))

# Run ensembles over all methods and past forecast dates
ensembles <- run_multiple_ensembles(forecast_dates = all_dates,
                                    methods = all_methods,
                                    exclude_models = exclude_by_date,
                                    save_forecasts = FALSE)




