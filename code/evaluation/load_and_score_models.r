suppressMessages(library(dplyr))
suppressMessages(library(here))
suppressMessages(library(lubridate))
suppressMessages(library(readr))
suppressMessages(library(scoringutils))
suppressMessages(library(covidHubUtils))
suppressMessages(library(EuroForecastHub))

load_and_score_models <- function(subdir = "", limit = NULL) {

  data_types <- get_hub_config("target_variables")

  if (is.null(limit)) {
    dates <- NULL
  } else {
    dates <- seq(today() - weeks(limit), today(), by = "day")
  }

  ## load forecasts --------------------------------------------------------------
  forecasts <- load_forecasts(
    source = "local_hub_repo",
    hub_repo_path = here(subdir),
    hub = "ECDC",
    dates = dates
  ) %>%
    ## set forecast date to corresponding submission date
    mutate(forecast_date = ceiling_date(forecast_date, "week", week_start = 2) - 1) %>%
    filter(forecast_date >= as.Date(get_hub_config("launch_date"))) %>%
    rename(prediction = value)

  ## load truth data -------------------------------------------------------------
  raw_truth <- load_truth(temporal_resolution = "weekly", hub = "ECDC")
  raw_truth <- raw_truth %>%
    EuroForecastHub::add_status() %>%
    filter(status == "final")

  if (!is.null(limit)) {
    raw_truth <- raw_truth |>
      filter(target_end_date > today() - weeks(limit))
  }

  ## get anomalies
  anomalies <- read_csv(here("data-truth", "anomalies", "anomalies.csv"))
  truth <- anti_join(raw_truth, anomalies) %>%
    mutate(model = NULL) %>%
    rename(true_value = value)

  ## remove forecasts made directly after a data anomaly
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

  message("Scoring all forecasts.")

  scores <- score_forecasts(
    forecasts = data,
    quantiles = get_hub_config("forecast_type")$quantiles
  )

  return(scores)
}
