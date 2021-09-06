# Plot scores averaged by location
library(forcats)
library(ggplot2)

# Get latest evaluation scores
source(here::here("code", "papers", "forecast-eval", "R", "get-eval.R"))

# Keep only the 1 week horizon
h1 <- eval_wide %>%
  filter(horizon == 1) %>%
  select(model, model_abbr, model_score_source,
         target_variable, location, 
         model_score, rel_wis, rel_ae,
         baseline_score, ensemble_score)

# All model relative scores by location -----------------------------------
# Boxplot showing range of model scores for each location, 
# relative to baseline at 1 and faceted by case/death
# - not saved
h1 %>%
  ggplot(aes(x = location, y = rel_ae)) +
  geom_boxplot() +
  geom_hline(aes(yintercept = 1), lty = 2) +
  scale_fill_viridis_d(alpha = 0.6) +
  geom_jitter(color = "black", size = 0.4, alpha = 0.9) +
  labs(x = NULL, y = "Interval or AE score") +
  theme_bw() +
  facet_wrap(~ target_variable, scales = "free")

# Average model absolute score by location ------------------------------------
# Get average score by location
h1_location <- h1 %>%
  group_by(location, target_variable) %>%
  summarise(model_score = mean(model_score),
            baseline_score = mean(baseline_score),
            ensemble_score = mean(ensemble_score)) %>%
  group_by(target_variable) %>%
  arrange(baseline_score, .by_group = TRUE)

# Scatter plot showing average model score (either WIS or AE) against 
# baseline score per location, facet by case/death

# get mean scores for drawing comparison lines on plot
mean_baseline_ensemble <- h1_location %>%
  group_by(target_variable) %>%
  summarise(mean_baseline_score = mean(baseline_score),
            mean_ensemble_score = mean(ensemble_score),
            mean_model_score = mean(model_score)) 

h1_location_plot <- h1_location %>%
  filter(!location %in% "Overall") %>%
  full_join(mean_baseline_ensemble, by = "target_variable") 

h1_location_plot <- h1_location_plot %>%
  ggplot(aes(x = baseline_score, y = model_score)) +
  geom_point(aes(col = model_score)) +
  geom_abline(lty = 5) +
  geom_vline(aes(xintercept = mean_baseline_score), lty = 3) +
  geom_hline(aes(yintercept = mean_model_score), lty = 3) +
  geom_text(aes(label = location),
            nudge_x = -0.3, nudge_y = -0.1, 
            check_overlap = TRUE) +
  facet_wrap(~ target_variable, scales = "free") +
  scale_x_log10() +
  scale_y_log10() +
  labs(y = "Average interval or AE score across all other models",
       x = "Baseline score") +
  theme_bw() +
  theme(legend.position = "none")

ggsave(filename = paste0(file_path, "/figures/", "location-absolute-score.png"),
       height = 5, width = 8,
       plot = h1_location_plot)

# Caption:
# Average model score against baseline score, on a log scale for
# 1 week forecasts of each target location. Higher scores indicate higher error
# and worse performance. High scores in both dimensions suggest a location with
# difficult to predict dynamics. The diagonal dotted line indicates equivalence to the
# baseline. The forecast models were exceptionally good at predicting locations
# below the diagonal line. Dotted lines indicate the average score across all locations
# for the baseline (vertical) and all other models (horizontal).
