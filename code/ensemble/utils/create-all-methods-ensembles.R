# Run and save past ensembles for all methods/dates
library(here)
library(vroom)
library(dplyr)
library(purrr)
library(EuroForecastHub)

# Settings
if (!exists("opts")) opts <- list(
  subdir = "ensembles",
  latest_date = as.Date("2022-03-07"),
  histories = c("All"), #"10"
)

# Methods ---------------------------------------------------------------
unweighted_methods <- c("mean", "median")
weighted_methods <- c(paste0("relative_skill_weighted_", unweighted_methods))

# Dates -----------------------------------------------------------------
## Get all past weeks' forecast dates
all_dates <- vroom(here("code", "ensemble", "EuroCOVIDhub",
                        "method-by-date.csv")) %>%
  pull(forecast_date)

# restrict to evaluation period
all_dates <- all_dates[all_dates <= opts$latest_date]
all_dates <- all_dates[-seq(1, 4)]

# Run ---------------------------------------------------------------------
ensembles <- list()

## Run unweighted ensembles for all past dates ---
ensembles[[length(ensembles) + 1]] <-
    run_multiple_ensembles(forecast_dates = all_dates,
                           methods = unweighted_methods,
                           verbose = TRUE,
                           rel_wis_cutoff = Inf,
                           identifier = "",
                           min_nmodels = 3)

## Run weighted ensembles for all past dates ---
 for (history in opts$histories) {
   ensembles[[length(ensembles) + 1]] <-
     run_multiple_ensembles(forecast_dates = all_dates,
                            methods = weighted_methods,
                            history = history,
                            verbose = TRUE,
                            rel_wis_cutoff = Inf,
                            identifier = paste0("", history),
                            min_nmodels = 3)
 }

# Save --------------------------------------------------------------------
for (i in 1:length(ensembles)) {

  ## Save in ensemble/data-processed/model
  walk(ensembles[[i]],
       ~ suppressWarnings(dir.create(here(opts$subdir, "data-processed",
                                          paste0("EuroCOVIDhub-", .x$method)),
                                     recursive = TRUE)))

  walk(ensembles[[i]],
       ~ vroom_write(x = .x$ensemble,
                     path = here(opts$subdir, "data-processed",
                                 paste0("EuroCOVIDhub-", .x$method),
                                 paste0(.x$forecast_date, "-EuroCOVIDhub-",
                                        .x$method, ".csv")),
                     delim = ","))

  ## Save weights in ensemble/weights/model
  walk(ensembles[[i]],
       ~ suppressWarnings(dir.create(here(opts$subdir, "weights",
                                          paste0("EuroCOVIDhub-", .x$method)),
                                     recursive = TRUE)))

  walk(ensembles[[i]],
       ~ vroom_write(x = .x$weights,
                     path = here(opts$subdir, "weights",
                                 paste0("EuroCOVIDhub-", .x$method),
                                 paste0(.x$forecast_date, "-EuroCOVIDhub-",
                                        .x$method, ".csv")),
                     delim = ","))
}
