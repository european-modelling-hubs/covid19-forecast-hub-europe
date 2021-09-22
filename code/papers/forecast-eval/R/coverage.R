# Plot scores averaged by location
library(forcats)
library(ggplot2)

# Get latest evaluation scores
source(here::here("code", "papers", "forecast-eval", "R", "get-eval.R"))

# Keep only the 1-2 week horizon
cov <- eval_wide %>%
  filter(horizon %in% c(1,2)) %>%
  select(model, model_abbr,
         target_variable, location, horizon,
         cov_50, cov_95,
         baseline_score, ensemble_score)

# Plot 50% Coverage ----------------------------------------------------------
cov %>%
  mutate(horizon = factor(horizon, ordered = TRUE)) %>%
  ggplot(aes(y = model, colour = horizon)) +
  # geom_point(aes(x = cov50.mean)) +
  # geom_linerange(aes(xmin = cov50.lower, xmax = cov50.upper)) +
  geom_boxplot(aes(x = cov_50), outlier.alpha = 0.2) +
  geom_vline(aes(xintercept = 0.5), lty = 2) +
  xlim(c(0,1)) +
  labs(y = NULL, 
       x = "50% coverage across all forecasts",
       colour = "Weeks ahead", shape = "Weeks ahead") +
  scale_fill_brewer(palette = "Set1") +
  scale_colour_brewer(palette = "Set1") +  
  coord_flip() +
  facet_grid(rows = vars(target_variable), scales = "free") +
  theme_bw() +
  theme(legend.position = "bottom",
        legend.justification = "right",
        axis.text.x = element_text(angle = 30, hjust = 1),
        plot.margin = unit(x = c(0.2,0.2,0.2,2), units = "cm"))

 ggsave(height = 5, width = 9,
        filename = paste0(file_path, "/figures/", "model-coverage.png"))
 
 # Caption
 #  The proportion of observations that fell within the 50% prediction interval 
 #  for each model. 
 #  Ideally, a forecast model would achieve 50% coverage of 0.50 (meaning 50% of 
 #  observations fall within the 50% prediction interval), shown as the vertical
 #  dotted line. Values of greater than 0.5 indicate that the forecasts are 
 #  under-confident (prediction intervals are on average too wide), whereas values 
 #  smaller than 0.5 indicate that the forecasts are overconfident (prediction 
 #  intervals tend to be too narrow.)

 # Description -------------------------------------------------------------
 # Sample
 (n_cov <- length(unique(cov$model))) # 31 models with probabilistic distributions
 n_cov_group <- cov %>%
   distinct(horizon, target_variable, model) %>%
   count(horizon, target_variable) # 24 forecasting for cases and 26 for deaths with coverage stats
 
  # Coverage: mean average across all locations
 cov50 <- cov %>%
   group_by(model, target_variable, horizon) %>%
   summarise(cov50.mean = mean(cov_50, na.rm = TRUE),
             cov50.sd = sd(cov_50, na.rm = TRUE),
             cov50.n = n()) %>%
   drop_na(cov50.mean) %>%
   mutate(cov50.se = cov50.sd / sqrt(cov50.n),
          cov50.lower = cov50.mean - qt(1 - (0.05 / 2), cov50.n - 1) * cov50.se,
          cov50.upper = cov50.mean + qt(1 - (0.05 / 2), cov50.n - 1) * cov50.se,
          diff = 0.5 - cov50.mean) %>%
   group_by(target_variable) %>%
   # mutate(model = fct_reorder(model, diff, min)) %>%
   ungroup()
 
 # Overall summary
 cov50_summary <- cov50 %>%
   group_by(horizon, target_variable) %>%
   summarise(
     min = min(cov50.mean),
     max = max(cov50.mean),
     range = max(cov50.mean) - min(cov50.mean),
     mean = mean(cov50.mean),
     mean_under_40 = sum(cov50.mean <= 0.4, na.rm = TRUE),
     mean_over_60 = sum(cov50.mean >= 0.6, na.rm = TRUE),
     mean_between = sum(cov50.mean > 0.4 & cov50.mean < 0.6, na.rm = TRUE),
     n = n())

# Consistency between case and death targets
cov50_target_consistency <- cov50 %>%
  group_by(model, horizon) %>%
  summarise(
    mean_under_40 = sum(cov50.mean <= 0.4, na.rm = TRUE),
    mean_over_60 = sum(cov50.mean >= 0.6, na.rm = TRUE),
    mean_between = sum(cov50.mean > 0.4 & cov50.mean < 0.6, na.rm = TRUE),
    n = n()
  ) %>%
  filter(n == 2, horizon == 1)
 


