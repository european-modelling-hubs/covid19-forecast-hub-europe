library(dplyr)
library(purrr)
library(lubridate)
library(yaml)
library(covidModels)
library(here)
library(readr)
library(EuroForecastHub)

model_name <- "EuroCOVIDhub-baseline"
model_folder <- here("data-processed", model_name)
if (!dir.exists(model_folder)) {
  dir.create(model_folder)
}

hub_quantiles <- get_hub_config("forecast_type")[["quantiles"]]
hub_horizon <- max(get_hub_config("horizon")[["values"]])
hub_targets <- get_hub_config("target_variables")

forecast_date <- today()

raw_truth <- covidHubUtils::load_truth(
  truth_source = "JHU",
  temporal_resolution = "weekly",
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
  filter(type %in% substr(hub_targets, 1, 3)) %>%
  mutate(type = "quantile")

format_ensemble(baseline_forecast, forecast_date) %>%
  write_csv(paste0(model_folder, "/", forecast_date, "-", model_name, ".csv"))


