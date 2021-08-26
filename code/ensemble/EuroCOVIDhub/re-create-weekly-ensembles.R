# Re-create past weekly ensembles for EuroCOVIDhub
library(here)
library(vroom)
library(purrr)
library(EuroForecastHub)

# Get method by date
method_by_date <- vroom(here("code", "ensemble", "EuroCOVIDhub",
                     "method-by-date.csv"))

# Get exclusions by date
exclude_by_date <- vroom(here("code", "ensemble", "EuroCOVIDhub",
                              "manual-exclusions.csv"))

# Run ensemble for past weeks
ensembles <- map2(.x = method_by_date$method,
                  .y = method_by_date$forecast_date,
                  ~ run_ensemble(method = .x,
                                 forecast_date = .y,
                                 exclude_models = exclude_by_date))

# Save forecast in data-processed
walk(.x = ensembles,
     ~ vroom_write(.$ensemble,
            here("data-processed", "EuroCOVIDhub-ensemble",
                 paste0(.$forecast_date,
                        "-EuroCOVIDhub-ensemble.csv")),
            delim = ","))

# Save criteria
walk(.x = ensembles,
     ~ vroom_write(.$criteria,
                 here("code", "ensemble", "EuroCOVIDhub", "criteria",
                      paste0("criteria-", .$forecast_date, ".csv")),
                 delim = ","))
