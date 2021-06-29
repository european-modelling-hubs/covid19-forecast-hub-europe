library(scoringutils)
library(covidHubUtils)
library(dplyr)
library(data.table)
library(tidyr)
library(lubridate)
library(here)
library(readr)
source(here("code", "config_utils", "get_hub_config.R"))
data_types <- get_hub_config("targets")

## only evaluate if the last 4 weeks hae been submitted
restrict_weeks <- 4

suppressWarnings(dir.create(here::here("evaluation")))

score_models <- function(file, data, report_date, restrict_weeks) {
    last_forecast_date <- report_date - 7

    score_data <- data[forecast_date <= last_forecast_date &
        target_end_date <= report_date]

    ## for overall, if more than 1 location exists, filter to have at least half
    ## of them
    overall_df <- score_data %>%
        group_by(model, target_variable) %>%
        mutate(n = length(unique(location))) %>%
        ungroup() %>%
        mutate(nall = length(unique(location))) %>%
        filter(n >= nall / 2) %>%
        select(-n, -nall) %>%
        mutate(location = "Overall")

    df <- data %>%
        bind_rows(overall_df)

    coverage <- eval_forecasts(
        df %>% filter(type != "point"),
      summarise_by = c("model", "target_variable", "range", "horizon",
                       "location"),
        compute_relative_skill = FALSE,
    ) %>%
        dplyr::filter(range %in% c(50, 95)) %>%
      dplyr::select(model, target_variable, horizon, location, coverage,
                    range) %>%
        tidyr::pivot_wider(
            names_from = range, values_from = coverage,
            names_prefix = "cov_"
        )

    ## number of forecasts
    num_fc <- df %>%
        dplyr::filter(type == "point", !is.na(true_value)) %>%
        dplyr::group_by(model, target_variable, horizon, location) %>%
        dplyr::summarise(n = n(), .groups = "drop")

    ## mean absolute error of point forecast
    mae <- df %>%
        dplyr::filter(type == "point", !is.na(true_value)) %>%
        mutate(ae = abs(prediction - true_value)) %>%
        group_by(model, target_variable, location, horizon) %>%
        summarise(mae = mean(ae), .groups = "drop")

    ## continuous weeks of submission
    cont_weeks <- df %>%
        filter(!is.na(model)) %>%
        group_by(forecast_date, model, location, target_variable, horizon) %>%
        summarise(present = 1, .groups = "drop") %>%
        complete(model, location, target_variable, horizon, forecast_date) %>%
        group_by(model, location, target_variable, horizon) %>%
        mutate(continuous_weeks = cumsum(rev(present))) %>%
        filter(!is.na(continuous_weeks)) %>%
        summarise(continuous_weeks = max(continuous_weeks), .groups = "drop")

    table <-
        eval_forecasts(df %>% dplyr::filter(type != "point"),
            summarise_by = c(
                "model", "target_variable",
                "horizon", "location"
            ),
            compute_relative_skill = TRUE
        ) %>%
        dplyr::left_join(coverage, by = c(
            "model", "target_variable", "horizon",
            "location"
        )) %>%
        dplyr::right_join(mae, by = c(
            "model", "target_variable", "horizon",
            "location"
        )) %>%
        dplyr::left_join(num_fc, by = c(
            "model", "target_variable", "horizon",
            "location"
        )) %>%
        dplyr::left_join(cont_weeks, by = c(
            "model", "target_variable", "horizon",
            "location"
        )) %>%
      replace_na(list(continuous_weeks = 0))

    write_csv(table, file)
}

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
                        target_variable = gsub("^(\\w+)s$", "inc \\1", data_types),
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

latest_date <- update(today(), wday = get_hub_config("forecast_week_day"),
                      week_start = 1, roll = TRUE)

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
  score_models(filename, data, report_date, restrict_weeks)
}
