# Plot scores averaged by location
library(forcats)
library(ggplot2)

# Get latest evaluation scores
source(here::here("code", "papers", "forecast-eval", "R", "get-eval.R"))

# All model relative WIS scores by location -----------------------------------
# Boxplot showing range of model scores for each location, 
# relative to baseline at 1 and faceted by case/death

location_rwis <- eval_wide %>%
  filter(horizon %in% c(1,2) &
           location != "Overall" &
           !grepl("hub-ensemble", model)) %>%
  mutate(horizon = factor(horizon, ordered = TRUE)) %>%
  # plot structure: boxplot rel wis by location and horizon
  ggplot(aes(x = location_name, y = rel_wis, col = horizon, fill = horizon)) +
  geom_boxplot(alpha = 0.1, outlier.alpha = 0.2, fill = NA) +
  geom_hline(aes(yintercept = 1), lty = 2) +
  # add ensemble as extra point
  geom_point(aes(y = ensemble_rel_wis),
              size = 2, alpha = 2, shape = "asterisk",
             position = position_dodge(width = 0.8)) +
  # format
  ylim(c(0,4)) +
  labs(x = NULL, y = "Relative WIS",
       colour = "Weeks ahead", fill = "Weeks ahead") +
  scale_fill_brewer(palette = "Set1") +
  scale_colour_brewer(palette = "Set1") +
  facet_grid(rows = vars(target_variable), scales = "free") +
  theme_bw() +
  theme(legend.position = "bottom",
        axis.text.x = element_text(angle = 30, hjust = 1))
location_rwis
ggsave(filename = paste0(file_path, "/figures/", "location-relative-wis.tiff"),
       height = 5, width = 9,
       plot = location_rwis)

# Relative WIS by country and horizon, showing boxplot of model scores,
# ensemble (asterisk), and outliers (faded), relative to baseline (1, dashed line),
# y-axis limited to exclude outliers > 4 x baseline



# Average model absolute score by location ------------------------------------
# Keep only the 1 week horizon
h1 <- eval_wide %>%
  filter(horizon == 1) %>%
  select(model, model_abbr, model_score_source,
         target_variable, location, 
         model_score, rel_wis, rel_ae,
         baseline_score, ensemble_score)

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

# ggsave(filename = paste0(file_path, "/figures/", "location-absolute-score.png"),
#        height = 5, width = 8,
#        plot = h1_location_plot)

# Caption:
# Average model score against baseline score, on a log scale for
# 1 week forecasts of each target location. Higher scores indicate higher error
# and worse performance. High scores in both dimensions suggest a location with
# difficult to predict dynamics. The diagonal dotted line indicates equivalence to the
# baseline. The forecast models were exceptionally good at predicting locations
# below the diagonal line. Dotted lines indicate the average score across all locations
# for the baseline (vertical) and all other models (horizontal).
