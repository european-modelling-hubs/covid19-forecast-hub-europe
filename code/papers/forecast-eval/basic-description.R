# Basic hub description
library(here)
library(purrr)
library(readr)
library(dplyr)
library(tidyr)
library(ggplot2)
library(covidHubUtils)
library(lubridate)

all_forecasts <- load_forecasts(hub = "ECDC",
                                source = "local_hub_repo",
                                hub_repo_path = here()) %>%
  rename(team_model = model) %>%
  separate(team_model,
           into = c("team", "model"), 
           sep = "-", 
           remove = FALSE)
all_forecasts <- all_forecasts %>%
  filter(!team == "EuroCOVIDhub")

team_n_model <- all_forecasts %>%
  group_by(team) %>%
  distinct(model) %>%
  count()

multi_model_team <- team_n_model %>%
  filter(n > 1) %>%
  pull(team)

# Teams vs locations
team_n_loc <- all_forecasts %>%
  group_by(team, model) %>%
  distinct(location) %>%
  count()

team_n_loc %>%
  filter(team %in% multi_model_team) 

nrow(team_n_loc %>% filter(n > 1)) # 19 teams forecasting more than one country
nrow(team_n_loc %>% filter(n < 32)) # 22 teams not forecasting all available locs

# Number of forecast models over time
team_time <- all_forecasts %>%
  mutate(forecast_date_epiweek_start = target_end_date - weeks(as.numeric(horizon)) + days(1)) %>%
  group_by(forecast_date_epiweek_start) %>%
  distinct(team_model) %>%
  count() %>%
  filter(forecast_date_epiweek_start > as.Date("2021-03-07"))

ggplot(team_time) +
  geom_line(aes(x = forecast_date_epiweek_start, y = n)) +
  ylim(0, NA)
