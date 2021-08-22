# packages ---------------------------------------------------------------------
library(dplyr)
library(here)
library(readr)
library(scoringutils)
library(rmarkdown)
library(covidHubUtils)
library(lubridate)
source(here("code", "config_utils", "get_hub_config.R"))

hub_models <- c("EuroCOVIDhub-ensemble", "EuroCOVIDhub-baseline")
report_date <- today()
wday(report_date) <- get_hub_config("forecast_week_day")
last_forecast_date <- report_date - 7

# Load data
params <- list(report_date = report_date,
               restrict_weeks = 4)
rmarkdown::render(here::here("code", "reports", "rmdchunks",
                               "load-data.Rmd"),
                  clean = TRUE, 
                  params = params)
score_data <- data %>%
  filter(forecast_date <= last_forecast_date,
         target_end_date <= report_date)

## duplicate country data as overall data
score_df <- score_data %>%
  mutate(location = "Overall") %>%
  bind_rows(score_data)

## for overall, if more than 1 location exists, filter to have at least half
## of them
score_df <- score_df %>%
  group_by(model, target_variable, location, horizon) %>%
  mutate(n = length(unique(location_name))) %>%
  ungroup() %>%
  mutate(nall = length(unique(location_name))) %>%
  filter(location != "Overall" | n >= nall / 2) %>%
  select(-n, -nall)

# calibration -------------------------------------------------------------

coverage <- score_df %>%
  filter(type != "point") %>%
  eval_forecasts(
    summarise_by = c("model", "target_variable", 
                     "range", "horizon",
                     "forecast_date",
                     "location"),
    metrics = c("interval_score", "coverage"),
    compute_relative_skill = FALSE
  ) %>%
  filter(range %in% c(50, 95)) %>%
  select(model, target_variable, horizon, location, coverage,
         forecast_date,
         range) %>%
  pivot_wider(
    names_from = range, values_from = coverage,
    names_prefix = "cov_"
  )
