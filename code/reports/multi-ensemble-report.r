# packages ---------------------------------------------------------------------
library(purrr)
library(dplyr)
library(here)
library(readr)
library(scoringutils)
library(rmarkdown)
library(data.table)
library(covidHubUtils)
library(lubridate)

options(knitr.duplicate.label = "allow")

report_date <-
  lubridate::floor_date(lubridate::today(), "week", week_start = 7) + 1
locations <- hub_locations_ecdc

suppressWarnings(dir.create(here::here("html")))

last_forecast_date <- report_date - 7
## load forecasts --------------------------------------------------------------
forecasts <- load_forecasts(source = "local_hub_repo",
                            hub_repo_path = here("ensembles"),
                            hub = "ECDC")
setDT(forecasts)
## set forecast date to corresponding submision date
forecasts[, forecast_date :=
              ceiling_date(forecast_date, "week", week_start = 2) - 1]
forecasts <- forecasts[forecast_date >= "2021-03-08"]
forecasts <- forecasts[forecast_date <= last_forecast_date]
setnames(forecasts, old = c("value"), new = c("prediction"))

## load truth data -------------------------------------------------------------
truth <- map_dfr(.x = c("inc case", "inc death"),
                 .f = ~ load_truth(truth_source = "JHU",
                                   target_variable = .x,
                                   hub = "ECDC"))
setDT(truth)
truth[, model := NULL]
truth <- truth[target_end_date <= report_date]
setnames(truth, old = c("value"),
         new = c("true_value"))

data <- scoringutils::merge_pred_and_obs(forecasts, truth,
                                         join = "full")

rmarkdown::render(here::here("code", "reports", "evaluation",
                             "evaluation-report.Rmd"),
                  params = list(data = data,
                                report_date = report_date,
                                restrict_weeks = 4),
                  output_format = "html_document",
                  output_file =
                    here::here("html", paste0("multi-ensemble-report-", report_date,
                                              "-Overall.html")),
                  envir = new.env())

## to make this generalisable
# allow bits to be turned off and on
# somehow pass down the filtering
