# Basic hub description
# See Results sections 1 and 2 (forecast community, forecast models)

library(here)
library(purrr)
library(readr)
library(dplyr)
library(tidyr)
library(ggplot2)
library(covidHubUtils)
library(lubridate)

# Set up ------------------------------------------------------------------
# get forecasts
source(here("code", "papers", "forecast-eval", "get-forecasts.R"))

# get participating team's institutional locations
team_countries <- read_csv(here("code", "papers", "thematic-eval", 
                                "eval-by-country", "team-country-institution.csv"))

# Teams by country ------------------------------------------------
team_countries <- team_countries %>%
  group_by(country) %>%
  summarise(n = n())

# Teams and models -------------------------------------------------------
# all teams
length(unique(forecasts_ex_hub$team)) # 34 submitting teams

# teams submitting more than 1 model
multi_model_team <- forecasts_ex_hub %>%
  group_by(team) %>%
  distinct(model) %>%
  count() %>%
  filter(n > 1) # 3 teams submitted 2 models and 1 team submitted 3 models

# Locations -----------------------------------------------------
team_n_loc <- forecasts %>%
  group_by(team, model) %>%
  distinct(location) %>%
  count()
nrow(team_n_loc %>% filter(n > 1)) # 25 models forecast for multiple locations
nrow(team_n_loc %>% filter(n == 32)) # 16 teams forecasting all available locs

# Teams and models over time ----------------------------------------------
models_time <- forecasts %>%
  filter(forecast_date > as.Date("2021-03-01") &
           !grepl("EuroCOVIDhub", team)) %>%
  group_by(forecast_date_epiweek_start) %>%
  distinct(team, model) %>%
  summarise(n_teams = length(unique(team)),
            n_models = length(unique(model)))

# Uncertainty ------------------------------------------------------
n_predictions <- forecasts %>%
  group_by(team_model, location, horizon, target_variable, target_end_date) %>%
  summarise(n_preds = n(), .groups = "drop") 

quantile_all <- n_predictions %>%
  filter(n_preds == 24) %>%
  pull(team_model) %>%
  unique()
quantile_subset <- n_predictions %>%
  filter(n_preds > 1 & n_preds < 24) %>%
  pull(team_model) %>%
  unique()
quantile_point <- n_predictions %>%
  filter(n_preds == 1) %>%
  pull(team_model) %>%
  unique()

all_models <- unique(forecasts$team_model) # N = 41 unique models
length(intersect(all_models, quantile_all)) # + 37 models submitted full quantile distribution
length(intersect(quantile_point, quantile_all)) # (of which 2 models expanded from point to all quantiles)
length(intersect(quantile_subset, quantile_all)) # (of which 3 models expanded from a subset to all quantiles)
length(setdiff(quantile_point, quantile_all)) # + 2 models submitted only point forecasts
length(setdiff(quantile_subset, quantile_all)) # + 2 models submitted only a subset of quantiles

# Target variables ----------------------------------------------
var <- forecasts %>%
  distinct(target_variable, team_model) %>%
  mutate(present = 1) %>%
  pivot_wider(names_from = target_variable, values_from = present)

var_case <- var$team_model[!is.na(var$`inc case`)]
var_death <- var$team_model[!is.na(var$`inc death`)]

length(intersect(var_case, var_death)) # 28 models forecast both targets
length(setdiff(var_case, var_death)) # 6 forecast cases but not deaths
length(setdiff(var_death, var_case)) # 5 forecast deaths but not cases

# Horizons -----------------------------------------------------------
horizon <- forecasts %>%
  distinct(horizon, team_model) %>%
  mutate(present = 1) %>%
  pivot_wider(names_from = horizon, values_from = present) %>%
  summarise(across(-team_model, sum, na.rm = TRUE))

