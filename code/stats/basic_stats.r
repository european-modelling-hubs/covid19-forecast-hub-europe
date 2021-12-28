library(covidHubUtils)
library(dplyr)
library(here)
library(lubridate)
library(EuroForecastHub)

cutoff_date <- as.Date("2021-08-31")

raw_forecasts <- load_forecasts(
  source = "local_hub_repo",
  hub_repo_path = here(),
  hub = "ECDC"
) %>%
  filter(between(forecast_date, ymd("2021-03-08"), ymd(cutoff_date)))

## number of models
raw_forecasts %>%
  filter(!grepl("^EuroCOVIDhub-", model)) %>%
  summarise(models = length(unique(model)))

## number of forecasts
raw_forecasts %>%
  filter(!grepl("^EuroCOVIDhub-", model)) %>%
  nrow()

## number of models that supply all quantiles

qf <- raw_forecasts %>%
  group_by(location, target_variable, target_end_date, model, horizon) %>%
  filter(length(setdiff(get_hub_config("forecast_type")$quantiles, quantile)) == 0) %>%
  ungroup()

qf %>%
  filter(!grepl("^EuroCOVIDhub-", model)) %>%
  summarise(models = length(unique(model)))

