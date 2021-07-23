library(here)
library(purrr)
library(readr)
library(dplyr)
library(ggplot2)

# Get evaluations ---------------------------------------------------------
eval <- read_csv(here("evaluation", "evaluation-2021-07-19.csv")) %>%
  filter(horizon <= 4 &
           !location == "Overall")

# Get team countries ------------------------------------------------------

# source(here("code", "validation", "get-metadata.R"))
# metadata <- get_metadata(exclude_designated_other = TRUE, exclude_hub = TRUE)
# - exported to csv
# - manually checked team country
# - re-written to csv

# categorise locations and drop EpiExpert
countries <- read_csv(here("docs", "team-country-institution.csv")) %>%
  left_join(covidHubUtils::hub_locations_ecdc, 
            by = c("country" = "location_name")) %>%
  mutate(location = case_when(country == "UK" ~ "GB",
                              is.na(location) ~ "nonEuro",
                              TRUE ~ location)) %>%
  filter(!model_abbr == "epiforecasts-EpiExpert") %>%
  select(team_name, model_abbr, 
         team_location = location)


# Join --------------------------------------------------------------------
eval_by_country <- eval %>%
  rename(model_abbr = model) %>%
  left_join(countries, by = "model_abbr") %>%
  filter(model_abbr %in% c(countries$model_abbr, 
                           "EuroCOVIDhub-baseline", "EuroCOVIDhub-ensemble"))

eval_country_origin <- eval_by_country %>%
  mutate(team_location_target = case_when(team_location == "nonEuro" ~ "Team nonEuro",
                                          location == team_location ~ "Team in target location",
                                          location != team_location ~ "Team outside target location",
                                          model_abbr == "EuroCOVIDhub-ensemble" ~ "EuroCOVIDhub-ensemble",
                                          model_abbr == "EuroCOVIDhub-baseline" ~ "EuroCOVIDhub-baseline"))

eval_team_location <- eval_country_origin %>%
  filter(!is.na(relative_skill)) %>%
  group_by(team_location_target, target_variable, horizon) %>%
  summarise(n_sum = sum(n),
            n_mean = mean(n, na.rm = TRUE),
            interval_score = mean(interval_score, na.rm = TRUE),
            relative_skill = mean(relative_skill, na.rm = TRUE),
            scaled_rel_skill = mean(scaled_rel_skill, na.rm = TRUE))


eval_team_location %>%
  filter(target_variable == "inc case") %>%
  filter(!team_location_target == "Team nonEuro") %>%
  ggplot(aes(x = team_location_target, y = relative_skill)) +
  geom_point(aes(colour = horizon))


# Ensemble forecasts BY in vs out target location ----------------------------













