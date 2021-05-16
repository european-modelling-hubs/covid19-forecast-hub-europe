library(here)
library(vroom)
library(purrr)
library(dplyr)
source(here("code", "ensemble", "utils", "run-ensemble.R"))

# Get exclusions for all weeks
exclude <- vroom(here("code", "ensemble", "EuroCOVIDhub", 
                      "manual-exclusions.csv"))

# Get all past weeks' forecast dates
all_dates <- dir(here("data-processed", "EuroCOVIDhub-ensemble"))
all_dates <- all_dates[!grepl("metadata", all_dates)]
all_dates <- as.Date(substr(all_dates, 1, 10))

# Get all methods
all_methods <- dir(here("code", "ensemble", "forecasts"))

# Match methods and dates
method_dates <- rep(all_dates, each = length(all_methods))
names(method_dates) <- rep(all_methods, length(all_dates))

# Run past ensembles for all methods/dates
ensembles <- map2(.x = names(method_dates), 
                  .y = method_dates,
                  ~ run_ensemble(method = .x,
                                    forecast_date = .y,
                                    exclude_models = exclude,
                                    return_criteria = FALSE) %>%
                    mutate(method = .x) %>%
                    vroom_write(here("code", "ensemble", "forecasts",
                                     .x, paste0(.y, ".csv")), 
                                delim = ","))


