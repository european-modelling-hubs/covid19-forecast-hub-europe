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
all_methods <- sub("^.*-", "", dir(here("ensembles", "data-processed")))

# Run all ensembles for all past dates ------------------------------------
ensembles <- run_multiple_ensembles(forecast_dates = all_dates,
                                    methods = "relative_skill", # all_methods,
                                    exclude_models = exclude_by_date,
                                    by_horizon = FALSE,
                                    verbose = TRUE) %>%
  transpose() %>%
  simplify_all()

results <- ensembles$result %>%
  compact()

# Save in ensemble/data-processed/model
res <- lapply(all_methods, function(x)
  suppressWarnings(dir.create(here("ensembles", "data-processed",
                                   paste0("EuroCOVIDhub-", x)),
                              recursive = TRUE)))

walk(results,
     ~ vroom_write(x = .x$ensemble,
                   path = here("ensembles", "data-processed",
                               paste0("EuroCOVIDhub-", .x$method),
                               paste0(.x$forecast_date, "-EuroCOVIDhub-",
                                      .x$method, ".csv")),
                   delim = ","))

# Save weights in ensemble/weights/model
walk(results,
     ~ vroom_write(x = .x$weights,
                   path = here("ensembles", "weights",
                               paste0("EuroCOVIDhub-", .x$method),
                               paste0(.x$forecast_date, "-EuroCOVIDhub-",
                                      .x$method, ".csv")),
                   delim = ","))
