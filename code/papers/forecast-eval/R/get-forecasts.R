# Get all forecasts
library(covidHubUtils)
library(scoringutils)
library(dplyr)
library(lubridate)
library(tidyr)
library(EuroForecastHub)
# set up 
# report_date <- as.Date("2021-08-23")

# all models
raw_forecasts <- load_forecasts(source = "local_hub_repo", 
                                hub_repo_path = here(), 
                                hub = "ECDC") %>%
  # set forecast date to corresponding submission date
  mutate(forecast_date = ceiling_date(forecast_date, "week", week_start = 2) - 1) %>%
  filter(between(forecast_date, ymd("2021-03-08"), ymd(report_date))) %>%
  rename(prediction = value) %>%
  separate(model,
           into = c("team_name", "model_name"), 
           sep = "-", 
           remove = FALSE)

# Remove "other" designated models, except baseline
model_desig_other <- EuroForecastHub::get_model_designations(hub_repo_path = here()) %>%
  mutate(designation = case_when(model == "EuroCOVIDhub-baseline" ~ "secondary",
                                 TRUE ~ designation)) %>%
  filter(designation == "other") %>%
  pull(model)

# Remove horizons > 4 weeks
forecasts <- raw_forecasts %>%
  filter(!model %in% model_desig_other &
           horizon <= 4)

# Remove hub forecasts
forecasts_ex_hub <- forecasts %>%
  filter(!grepl("EuroCOVIDhub", model))

rm(model_desig_other)

