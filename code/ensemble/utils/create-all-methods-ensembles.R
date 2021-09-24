# Run and save past ensembles for all methods/dates
library(here)
library(vroom)
library(dplyr)
library(purrr)
library(EuroForecastHub)

# Get exclusions for all weeks
exclude_by_date <- vroom(here("code", "ensemble", "EuroCOVIDhub",
                      "manual-exclusions.csv"))

for (cutoff in c(TRUE, FALSE)) {

  ## Get all past weeks' forecast dates
  all_dates <- vroom(here("code", "ensemble", "EuroCOVIDhub",
                          "method-by-date.csv")) %>%
    pull(forecast_date)

  if (cutoff) {
    all_dates <- all_dates[-seq(1, 7)]
  }

  ## Get all methods
  all_methods <- c("mean", "median", paste0("relative_skill_weighted_", c("mean", "median"), c("", "_by_horizon")))

  ## Run all ensembles for all past dates ------------------------------------
  ensembles <- run_multiple_ensembles(forecast_dates = all_dates,
                                      methods = all_methods, # all_methods,
                                      exclude_models = exclude_by_date,
                                      verbose = TRUE,
                                      rel_wis_cutoff = if_else(cutoff, 1, Inf),
                                      identifier = if_else(cutoff, "cutoff", "")) %>%
  transpose() %>%
  simplify_all()

  results <- ensembles$result %>%
    compact()

  ## Save in ensemble/data-processed/model
  walk(results,
       ~ suppressWarnings(dir.create(here("ensembles", "data-processed",
                                          paste0("EuroCOVIDhub-", .x$method)),
                                     recursive = TRUE)))

  walk(results,
       ~ vroom_write(x = .x$ensemble,
                     path = here("ensembles", "data-processed",
                                 paste0("EuroCOVIDhub-", .x$method),
                                 paste0(.x$forecast_date, "-EuroCOVIDhub-",
                                        .x$method, ".csv")),
                     delim = ","))

  ## Save weights in ensemble/weights/model
  walk(results,
       ~ suppressWarnings(dir.create(here("ensembles", "weights",
                                          paste0("EuroCOVIDhub-", .x$method)),
                                     recursive = TRUE)))

  walk(results,
       ~ vroom_write(x = .x$weights,
                     path = here("ensembles", "weights",
                                 paste0("EuroCOVIDhub-", .x$method),
                                 paste0(.x$forecast_date, "-EuroCOVIDhub-",
                                        .x$method, ".csv")),
                     delim = ","))
}
