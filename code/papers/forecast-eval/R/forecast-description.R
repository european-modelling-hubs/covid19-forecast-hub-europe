# Basic hub description
# See Results sections 1 and 2 (forecast models)
library(here)
library(purrr)
library(readr)
library(dplyr)
library(tidyr)
library(ggplot2)
library(covidHubUtils)
library(lubridate)

# Set up ------------------------------------------------------------------
report_date <- as.Date("2021-08-23")
report_date_formatted <- format(report_date, "%d %B %Y")

# get forecasts
source(here("code", "papers", "forecast-eval", "R", "get-forecasts.R"))

# get participating team's institutional locations
team_countries <- read_csv(here("code", "papers", "thematic-eval", 
                                "eval-by-country", "team-country-institution.csv"))

# Teams - excludes hub team ----------------------------------------------
# Over time
models_time <- forecasts_ex_hub %>%
  group_by(forecast_date, target_variable) %>%
  distinct(team_name, model_name) %>%
  summarise(n_teams = length(unique(team_name)),
            n_models = length(unique(model_name)))
teams_min <- min(models_time$n_teams)
teams_max <- max(models_time$n_teams)
teams_unique <- length(unique(forecasts_ex_hub$team_name)) # 34 submitting teams

# plot n teams over time
models_time %>%
  mutate(target_variable = recode(target_variable,
                                  "inc case" = "Cases",
                                  "inc death" = "Deaths")) %>%
  ggplot(aes(x = forecast_date, y = n_teams, 
             colour = target_variable)) +
  geom_point() +
  geom_line() +
  labs(x = NULL, y = "Number of teams",
       colour = NULL) +
  scale_colour_brewer(palette = "Set1") +
  theme_bw() +
  theme(legend.position = "bottom")

ggsave(height = 3, width = 3,
       filename = paste0(file_path, "/figures/", "teams-over-time.png"))

#  by country
team_countries <- team_countries %>% # excludes hub team
  group_by(country) %>%
  summarise(n = n()) %>%
  left_join(covidHubUtils::hub_locations_ecdc, by = c("country" = "location_name")) %>%
  mutate(location = ifelse(country == "UK", "GB", location))
locs_euro <- sum(!is.na(team_countries$location))
locs_ex_euro_teams <- sum(team_countries[is.na(team_countries$location), "n"])

# teams submitting more than 1 model
teams_multi_model <- forecasts_ex_hub %>%
  group_by(team_name) %>%
  distinct(model_name) %>%
  count() %>%
  filter(n > 1) %>%
  length()

# Models - includes hub models -----------------------------------------------
models_unique <- length(unique(forecasts$model))

# Locations
model_n_loc <- forecasts %>%
  group_by(team_name, model_name) %>%
  distinct(location) %>%
  count()
models_multi_country_n <- nrow(model_n_loc %>% filter(n > 1)) 
models_multi_country_pct <- round(models_multi_country_n / models_unique * 100)
models_all_country_n <- nrow(model_n_loc %>% filter(n == 32)) 

# Target variables
var <- forecasts %>%
  distinct(target_variable, model) %>%
  mutate(present = 1) %>%
  pivot_wider(names_from = target_variable, values_from = present)
var_case <- var$model[!is.na(var$`inc case`)]
var_death <- var$model[!is.na(var$`inc death`)]

models_all_targets_n <- length(intersect(var_case, var_death))
models_all_targets_pct <- round(models_all_targets_n/models_unique * 100)
models_targets_cases_only <- length(setdiff(var_case, var_death))
models_targets_deaths_only <- length(setdiff(var_death, var_case)) 

# Horizons
horizon <- forecasts %>%
  distinct(horizon, model) %>%
  mutate(present = 1) %>%
  pivot_wider(names_from = horizon, values_from = present) %>%
  summarise(across(-model, sum, na.rm = TRUE))

models_horizon_1 <- ifelse(horizon$`1` == models_unique, "All", horizon$`1`)
models_horizon_2_n <- horizon$`2`
models_horizon_2_pct <- round(models_horizon_2_n / models_unique * 100)
models_horizon_3_4_min_pct <- round(min(horizon$`3`, horizon$`4`) / models_unique * 100)

# Uncertainty
n_predictions <- forecasts %>%
  group_by(model, location, horizon, target_variable, target_end_date) %>%
  summarise(n_preds = n(), .groups = "drop") 

quantile_all <- n_predictions %>%
  filter(n_preds == 24) %>%
  pull(model) %>%
  unique()

quantile_subset <- n_predictions %>%
  filter(n_preds > 1 & n_preds < 24) %>%
  pull(model) %>%
  unique()

quantile_point <- n_predictions %>%
  filter(n_preds == 1) %>%
  pull(model) %>%
  unique()

models_unique_name <- unique(forecasts$model) 

# Number of models submitting all 23 quantiles
models_quantile_all <- length(intersect(models_unique_name, quantile_all))
# Number that added to create the full set from either a point or a subset of quantiles:
models_quantile_added <- length(intersect(quantile_point, quantile_all)) + length(intersect(quantile_subset, quantile_all))
# subset of quantiles only
models_quantile_subset <- length(setdiff(quantile_subset, quantile_all)) # models that only ever had a subset of quantiles
# point only
models_quantile_point <- length(setdiff(quantile_point, quantile_all))

# number submitting any quantile
models_quantile_n <- models_unique - models_quantile_point
models_quantile_pct <- round(models_quantile_n / models_unique * 100)


# Heatmap: forecasts over time ---------------------------------------------

forecasts_summary <- forecasts %>%
  filter(horizon %in% c(1,2)) %>%
  group_by(forecast_date, location_name, target_variable) %>%
  summarise(n_predictions = n(),
            n_models = length(unique(.$model)))

forecasts_summary %>%
  mutate(target_variable = recode(target_variable,
                                  "inc case" = "Cases",
                                  "inc death" = "Deaths")) %>%
  ggplot(aes(x = forecast_date, y = location_name, fill = n_predictions)) +
  geom_tile() +
  labs(x = NULL, y = NULL,
       fill = "Number of one and two week predictions") +
  facet_wrap(~ target_variable) +
  scale_fill_distiller(direction = 1) +
  scale_x_date(date_breaks = "6 week", date_labels = "%b") +
  theme_bw() +
  theme(legend.position = "bottom")


ggsave(height = 5, width = 5,
       filename = paste0(file_path, "/figures/", "predictions-over-time.png"))
