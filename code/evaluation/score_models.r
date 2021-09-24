library(scoringutils)
library(covidHubUtils)
library(dplyr)
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
forecasts <- load_forecasts(
  source = "local_hub_repo",
  hub_repo_path = here(),
  hub = "ECDC"
) %>%
  # set forecast date to corresponding submission date
  mutate(forecast_date = ceiling_date(forecast_date, "week", week_start = 2) - 1) %>%
  filter(forecast_date >= "2021-03-08") %>%
  rename(prediction = value)

## load truth data -------------------------------------------------------------
raw_truth <- load_truth(truth_source = "JHU",
                        temporal_resolution = "weekly",
                        hub = "ECDC")
# get anomalies
anomalies <- read_csv(here("data-truth", "anomalies", "anomalies.csv"))
truth <- anti_join(raw_truth, anomalies) %>%
  mutate(model = NULL) %>%
  rename(true_value = value)

# remove forecasts made directly after a data anomaly
forecasts <- forecasts %>%
  mutate(previous_end_date = forecast_date - 2) %>%
  left_join(anomalies %>%
              rename(previous_end_date = target_end_date),
            by = c("target_variable",
                   "location", "location_name",
                   "previous_end_date")) %>%
  filter(is.na(anomaly)) %>%
  select(-anomaly, -previous_end_date)

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
  eval_filename <-
    here::here("evaluation", paste0("evaluation-", report_date, ".csv"))

  scores <- score_forecasts(
    forecasts = data,
    quantiles = get_hub_config("forecast_type")$quantiles
  )
  table <- summarise_scores(
    scores = scores,
    report_date = report_date,
    restrict_weeks = restrict_weeks
  )

  write_csv(table, eval_filename)
}

write_csv(scores, here::here("evaluation", "scores.csv"))
