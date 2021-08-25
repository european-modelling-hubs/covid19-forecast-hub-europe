# Get all forecasts
library(covidHubUtils)
library(scoringutils)
library(dplyr)
library(lubridate)
library(tidyr)

# set up 
report_date <- as.Date("2021-08-23")

# all models
raw_forecasts <- load_forecasts(source = "local_hub_repo", 
                                hub_repo_path = here(), 
                                hub = "ECDC") %>%
  # set forecast date to corresponding submission date
  mutate(forecast_date = ceiling_date(forecast_date, "week", week_start = 2) - 1) %>%
  filter(between(forecast_date, ymd("2021-03-08"), ymd(report_date))) %>%
  rename(prediction = value,
         team_model = model) %>%
  separate(team_model,
           into = c("team", "model"), 
           sep = "-", 
           remove = FALSE)

# Remove "other" designated models, except baseline
source(here("code", "ensemble", "utils", "get_model_designations.r"))
model_desig_other <- get_model_designations(here()) %>%
  mutate(designation = case_when(model == "EuroCOVIDhub-baseline" ~ "secondary",
                                 TRUE ~ designation)) %>%
  filter(designation == "other") %>%
  pull(model)

# Remove horizons > 4 weeks
forecasts <- raw_forecasts %>%
  filter(!team_model %in% model_desig_other &
           horizon <= 4)


