# Get latest evaluation scores ("eval"), filtered to 1 wk horizon ("h1_eval")
source(here::here("code", "papers", "forecast-eval", "get-eval.R"))

# Overall = evaluation scored across all locations 
#   for models with forecasts for > half locations (22)
h1_overall <- filter(h1_eval, location == "Overall")

# Overall AE -------------------------------------------------------------
# Plot
h1_overall %>%
  filter(!grepl("baseline", model)) %>%
  group_by(target_variable_neat) %>%
  mutate(model = fct_reorder(model, rel_ae, min)) %>%
  ggplot(aes(y = model)) +
  geom_point(aes(x = rel_ae)) +
  geom_vline(aes(xintercept = 1), lty = 2) +
  labs(x = "Relative average error compared to baseline, by model at 1-week horizon", 
       y = NULL) +
  facet_wrap(~ target_variable_neat, scales = "free_x") +
  theme_bw() +
  theme(legend.position = "none")
ggsave(paste0(file_path, "/eval-overall-rae-models.png"))

# Overall relative skill --------------------------------------------------
# Models against baseline, overall relative skill, by target
h1_overall_target <- h1_overall %>%
  group_by(model, target_variable) %>%
  summarise(across(interval_score:mae, mean, na.rm = TRUE), .groups = "drop")

h1_overall_target %>%
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


# •	Consistency between locations/horizons/targets (are the same models always good)
# •	Map models / overall performance
# •	By target variable

