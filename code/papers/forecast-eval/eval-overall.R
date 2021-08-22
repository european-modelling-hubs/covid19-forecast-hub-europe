# get eval
source(here::here("code", "exploratory", "get-eval.R"))

# Get overall
# Overall = only applied to models with forecasts for > half locations (22)
overall <- filter(eval, location == "Overall")
h2_overall <- filter(h2_eval, location == "Overall")

# Overall MAE -------------------------------------------------------------
baseline_mae_cases = filter(h2_overall,
                            model == "EuroCOVIDhub-baseline" &
                              target_variable == "inc case") %>%
  pull(mae)
baseline_mae_death = filter(h2_overall,
                            model == "EuroCOVIDhub-baseline" &
                              target_variable == "inc death") %>%
  pull(mae)

h2_overall %>%
  group_by(target_variable_neat) %>%
  mutate(model = fct_reorder(model, mae, min),
         hub = case_when(grepl("EuroCOVIDhub", model) ~ TRUE),
         baseline_mae = case_when(target_variable_neat == "Cases" ~ baseline_mae_cases,
                                  target_variable_neat == "Deaths" ~ baseline_mae_death)) %>%
  ggplot(aes(y = model, colour = hub)) +
  geom_point(aes(x = mae)) +
  geom_vline(aes(xintercept = baseline_mae), lty = 2) +
  labs(x = "Mean average error (MAE), by model at 2-week horizon", 
       y = NULL) +
  facet_wrap(~ target_variable_neat, scales = "free_x") +
  theme_bw() +
  theme(legend.position = "none")
ggsave(paste0(figure_path, "/eval-overall-mae-models.png"))

# Overall relative skill --------------------------------------------------

# Models against baseline, overall relative skill, by target

h2_target <- h2 %>%
  mutate()
  group_by(model, target_variable) %>%
  summarise(across(interval_score:mae, mean, na.rm = TRUE), .groups = "drop")

overall %>%
  ggplot(aes(x = horizon, y = scaled_rel_skill)) +
  geom_point(aes(colour = model)) +
  geom_line(aes(colour = model)) +
  geom_hline(aes(yintercept = 1), lty = 2) +
  labs(x = "Forecast week horizon", 
       y = "Relative forecast skill to baseline",
       colour = "Model") +
  facet_wrap(~ target_variable_neat) +
  theme_classic() +
  theme(legend.position = "bottom",
        strip.background = element_blank())

horizon <- overall %>%
  group_by(model, target_variable_neat) %>%
  arrange(horizon, .by_group = TRUE) %>%
  mutate(skill_horizon_change = case_when(
    horizon == 2 ~ scaled_rel_skill - lag(scaled_rel_skill, 1),
    horizon == 3 ~ scaled_rel_skill - lag(scaled_rel_skill, 2),
    horizon == 4 ~ scaled_rel_skill - lag(scaled_rel_skill, 3)))

horizon %>%
  group_by(target_variable) %>%
  summarise(change_down = sum(skill_horizon_change < 0, na.rm = TRUE),
            n = n() - sum(is.na(skill_horizon_change)),
            decr_perc = change_down / n * 100)

# for inc deaths, 
# most models decrease relative skill compared to baseline over longer horizons
# than 1 week ahead (so models > baseline at 2-4 weeks compared to 1 week)
# so models are particularly more useful than baseline at longer horizons
# but this only applies to inc death (81% models improve over horizon v. baseline),
# not inc case (39% improve over baseline at longer horizons)
 







# •	Consistency between locations/horizons/targets (are the same models always good)
# •	Map models / overall performance
# •	By target variable

