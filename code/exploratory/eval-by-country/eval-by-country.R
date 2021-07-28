library(here)
library(purrr)
library(readr)
library(dplyr)
library(ggplot2)


# Evaluations should be on raw forecasts, grouping over thematic variables
# - i.e. replace group by "model" with group by "team-location-target-match"
# - calculate scores
# - compare by thematic groups
# - presently this is grouping on a grouped evaluation - loses some uncertainty (?)


# Get evaluations ---------------------------------------------------------
# Exclude "Overall" location since this analysis re. location
eval <- read_csv(here("evaluation", "evaluation-2021-07-19.csv")) %>%
  filter(horizon <= 4 &
           !location == "Overall")

# Get team countries ------------------------------------------------------

# # Metadata: manually categorised by location of team institution
# source(here("code", "validation", "get-metadata.R"))
# metadata <- get_metadata(exclude_designated_other = TRUE, exclude_hub = TRUE)
# metadata %>%
#   select(team_name, model_abbr, institution_affil) %>%
#   write_csv(here("code", "exploratory", 
#     "eval-by-country", "team-country-institution.csv"))
# # manually entered country by location of team institution
# # pre-specified categories: locations used in hub, not a hub location, or hub itself
# # re-written to csv

# categorise locations and drop EpiExpert
countries <- read_csv(here("code", "exploratory", 
                           "eval-by-country", "team-country-institution.csv")) %>%
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
                           "EuroCOVIDhub-baseline", "EuroCOVIDhub-ensemble")) %>%
  mutate(team_location_target = case_when(location == team_location ~ "Team in target location",
                                          location != team_location ~ "Team outside target location",
                                          team_location == "nonEuro" ~ "Team outside target location",
                                          model_abbr == "EuroCOVIDhub-ensemble" ~ "EuroCOVIDhub-ensemble",
                                          model_abbr == "EuroCOVIDhub-baseline" ~ "EuroCOVIDhub-baseline"))

# summarise
eval_team_location <- eval_by_country %>%
  filter(!is.na(scaled_rel_skill) &
           !scaled_rel_skill == Inf) %>%
  filter(!team_location_target == "EuroCOVIDhub-baseline") %>%
  group_by(team_location_target) %>% # horizon, target_variable
  summarise(mean.skill = mean(scaled_rel_skill, na.rm = TRUE),
            sd.skill = sd(scaled_rel_skill, na.rm = TRUE),
            n.skill.scores = n(),
            n.skill.forecasts = sum(n),
            n.models = length(unique(model_abbr))) %>%
  mutate(se.skill = sd.skill / sqrt(n.skill.scores),
         lower.ci.skill = mean.skill - qt(1 - (0.05 / 2), n.skill.scores - 1) * se.skill,
         upper.ci.skill = mean.skill + qt(1 - (0.05 / 2), n.skill.scores - 1) * se.skill) # %>%
  # mutate(weeks_ahead = factor(horizon, 
  #                             levels = c("1", "2", "3", "4")))

# plot
eval_team_location %>%
  # re-label for x axis
  mutate(team_location_target = factor(team_location_target,
                                       levels = c("EuroCOVIDhub-ensemble",
                                                  "Team in target location",
                                                  "Team outside target location"),
                                       labels = c("Ensemble", "Inside country", "Outside country"))) %>%
  ggplot(aes(x = team_location_target, y = mean.skill)) +
  geom_point(
    # aes(colour = weeks_ahead),
    position = position_dodge(0.2)) +
  geom_linerange(aes(ymin = lower.ci.skill, ymax = upper.ci.skill), #, colour = weeks_ahead), 
                 position = position_dodge(0.2),
                 alpha = 0.5) +
  geom_hline(aes(yintercept = 1), lty = 2) +
  scale_colour_viridis_d(option = 7, end = 0.9) +
  labs(y = "Mean scaled relative skill", 
       x = "Location of team's primary institution relative to forecast target location",
       colour = "Weeks ahead") +
  theme_classic() +
  theme(legend.position = "bottom")
  # + facet_wrap(~ target_variable #, scales = "free"
  #            )






