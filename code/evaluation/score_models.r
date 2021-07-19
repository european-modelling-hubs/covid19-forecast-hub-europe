library(scoringutils)
library(covidHubUtils)
library(dplyr)
library(data.table)
library(tidyr)
library(lubridate)
library(here)
library(readr)
library(EuroForecastHub)

data_types <- get_hub_config("target_variables")

## only evaluate if the last 4 weeks hae been submitted
restrict_weeks <- 4

suppressWarnings(dir.create(here::here("evaluation")))

## load forecasts --------------------------------------------------------------
forecasts <- load_forecasts(source = "local_hub_repo",
                            hub_repo_path = here(),
                            hub = "ECDC")
setDT(forecasts)
## set forecast date to corresponding submision date
forecasts[, forecast_date :=
              ceiling_date(forecast_date, "week", week_start = 2) - 1]
forecasts <- forecasts[forecast_date >= "2021-03-08"]
setnames(forecasts, old = c("value"), new = c("prediction"))

## load truth data -------------------------------------------------------------
raw_truth <- load_truth(truth_source = "JHU",
                        target_variable = data_types,
                        hub = "ECDC")
# get anomalies
anomalies <- read_csv(here("data-truth", "anomalies", "anomalies.csv"))
truth <- anti_join(raw_truth, anomalies)

setDT(truth)
truth[, model := NULL]
setnames(truth, old = c("value"),
         new = c("true_value"))

data <- scoringutils::merge_pred_and_obs(forecasts, truth,
                                         join = "full")

latest_date <- today()
wday(latest_date) <- get_hub_config("forecast_week_day")

## can modify manually if wanting to re-run past evaluation
re_run <- FALSE
if (re_run) {
  start_date <- as.Date("2021-03-08") + 4 * 7
} else {
  start_date <- latest_date
}
report_dates <- seq(start_date, latest_date, by = "week")

for (chr_report_date in as.character(report_dates)) {
  report_date <- as.Date(chr_report_date)
  filename <-
    here::here("evaluation", paste0("evaluation-", report_date, ".csv"))

  table <- score_models(data, report_date) %>%
    mutate(across(c("interval_score", "sharpness", "underprediction", "overprediction", "aem", "mae"), round)) %>%
    mutate(across(c("coverage_deviation", "bias", "relative_skill", "scaled_rel_skill", "cov_50", "cov_95"), round, 2))

  write_csv(table, filename)
}
