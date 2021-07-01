library(dplyr)
library(purrr)
library(lubridate)
library(yaml)
library(covidModels)
library(here)
library(readr)

source(here("code", "config_utils", "get_hub_config.R"))
source(here("code", "ensemble", "utils", "format-ensemble.R"))

model_name <- "EuroCOVIDhub-baseline"
model_folder <- here("data-processed", model_name)
if (!dir.exists(model_folder)) {
  dir.create(model_folder)
}

hub_quantiles <- get_hub_config("forecast_type")[["quantiles"]]
hub_horizon <- get_hub_config("horizon")[["value"]]

forecast_date <- today()

first_target_date <- forecast_date
wday(first_target_date) <- get_hub_config("week_end_day")

# Wrapper to build baseline because S3 doesn't usually work well with pipe
# workflows
build_baseline <- function(inc_obs, quantiles, horizon) {
  baseline_fit <- covidModels::fit_quantile_baseline(inc_obs)
  predict(
    baseline_fit,
    inc_obs,
    cumsum(inc_obs),
    quantiles = quantiles,
    horizon = horizon,
    num_samples = 100000
  )
}

raw_truth <- covidHubUtils::load_truth(
  truth_source = "JHU",
  target_variable = c("inc case", "inc death"),
  truth_end_date = forecast_date - 1,
  hub = "ECDC"
)

baseline_forecast <- raw_truth %>%
  filter(!is.na(value)) %>%
  group_by(location, target_variable) %>%
  group_map(
    ~ full_join(
      .y,
      build_baseline(.x$value, quantiles = hub_quantiles, horizon = hub_horizon),
      by = character()
    )
  ) %>%
  bind_rows() %>%
  filter(type == "inc")

format_ensemble(baseline_forecast, forecast_date) %>%
  write_csv(paste0(model_folder, "/", forecast_date, "-", model_name, ".csv"))


