# Run and save past ensembles for all methods/dates
library(here)
library(vroom)
library(dplyr)
library(purrr)
library(EuroForecastHub)

ensembles <- list()

histories <- setdiff(list.dirs(here::here("evaluation"), full.names = FALSE), "")

for (cutoff in c(TRUE, FALSE)) {
  for (history in histories) {
    ## Get all past weeks' forecast dates
    all_dates <- vroom(here("code", "ensemble", "EuroCOVIDhub",
                            "method-by-date.csv")) %>%
      pull(forecast_date)

    if (cutoff) {
      all_dates <- all_dates[-seq(1, 7)]
    } else {
      all_dates <- all_dates[-seq(1, 4)]
    }

    ## Get all methods
    all_methods <- c(paste0("relative_skill_weighted_", c("mean", "median")))

    eval_dir <- here::here("evaluation", history)
    ## Run all ensembles for all past dates ------------------------------------
    ensembles[[length(ensembles) + 1]] <-
      run_multiple_ensembles(forecast_dates = all_dates,
                             methods = all_methods, # all_methods,
                             verbose = TRUE,
                             rel_wis_cutoff = if_else(cutoff, 1, Inf),
                             eval_dir = eval_dir,
                             identifier = paste0(if_else(cutoff, "cutoff_", ""),
                                                 history))
  }
}

for (i in 1:length(ensembles)) {

  ## Save in ensemble/data-processed/model
  walk(ensembles[[i]],
       ~ suppressWarnings(dir.create(here("ensembles", "data-processed",
                                          paste0("EuroCOVIDhub-", .x$method)),
                                     recursive = TRUE)))

  walk(ensembles[[i]],
       ~ vroom_write(x = .x$ensemble,
                     path = here("ensembles", "data-processed",
                                 paste0("EuroCOVIDhub-", .x$method),
                                 paste0(.x$forecast_date, "-EuroCOVIDhub-",
                                        .x$method, ".csv")),
                     delim = ","))

  ## Save weights in ensemble/weights/model
  walk(ensembles[[i]],
       ~ suppressWarnings(dir.create(here("ensembles", "weights",
                                          paste0("EuroCOVIDhub-", .x$method)),
                                     recursive = TRUE)))

  walk(ensembles[[i]],
       ~ vroom_write(x = .x$weights,
                     path = here("ensembles", "weights",
                                 paste0("EuroCOVIDhub-", .x$method),
                                 paste0(.x$forecast_date, "-EuroCOVIDhub-",
                                        .x$method, ".csv")),
                     delim = ","))
}
