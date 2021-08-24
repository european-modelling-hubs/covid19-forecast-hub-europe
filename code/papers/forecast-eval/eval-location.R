library(forcats)

# Get latest evaluation scores
source(here::here("code", "papers", "forecast-eval", "get-eval.R"))
# get absolute MAE
source(here::here("code", "papers", "forecast-eval", "check-mae-scores.R"))

# Absolute mean AE
ae_by_loc_abs <- rel_ae %>%
  filter(location != "Overall" &
           horizon <= 2) %>%
  mutate(target_variable_neat = recode(target_variable, !!!clean_variables),
         var = ae_point) %>%
  group_by(location, target_variable_neat, horizon) %>%
  summarise(var.mean = mean(var, na.rm = TRUE),
            var.sd = sd(var, na.rm = TRUE),
            var.n = n()) %>%
  mutate(var.se = var.sd / sqrt(var.n),
         var.lower = var.mean - qt(1 - (0.05 / 2), var.n - 1) * var.se,
         var.upper = var.mean + qt(1 - (0.05 / 2), var.n - 1) * var.se) %>%
  rename_with(~ gsub("var.", "rae.", .x, fixed = TRUE))

ae_by_loc_plot <- ae_by_loc_abs %>%
  group_by(target_variable_neat) %>%
  left_join(hub_locations_ecdc, by = "location") %>%
  mutate(location_name = fct_reorder2(location_name, horizon, rae.mean, min),
         horizon = fct_inseq(factor(horizon))) %>%
  ggplot(aes(y = location_name, col = horizon)) +
  geom_point(aes(x = rae.mean)) +
  geom_linerange(aes(xmin = rae.lower, xmax = rae.upper)) +
  labs(x = "Relative average error (MAE) compared to baseline, mean with 95% CI, 
       across all models' forecasts",
       y = NULL,
       colour = "Weeks ahead") +
  scale_colour_viridis_d(option = 7) +
  facet_grid(~ target_variable_neat, scales = "free_x") +
  theme_bw() +
  theme(legend.position = "bottom")

# By absolute AE, the "easiest" (most accurate average MAE across all models) 
# target to predict was incident deaths in Iceland with average MAE only 0.2
# 
# The most difficult to predict was incident cases in France





# Relative AE by location
ae_by_loc_rel <- eval_all_locs %>%
  filter(location != "Overall") %>%
  mutate(var = rel_ae) %>%
  group_by(location, target_variable_neat, horizon) %>%
  summarise(var.mean = mean(var, na.rm = TRUE),
            var.sd = sd(var, na.rm = TRUE),
            var.n = n()) %>%
  mutate(var.se = var.sd / sqrt(var.n),
         var.lower = var.mean - qt(1 - (0.05 / 2), var.n - 1) * var.se,
         var.upper = var.mean + qt(1 - (0.05 / 2), var.n - 1) * var.se) %>%
  rename_with(~ gsub("var.", "rae.", .x, fixed = TRUE))

ae_by_loc_plot <- ae_by_loc %>%
  group_by(target_variable_neat) %>%
  left_join(hub_locations_ecdc, by = "location") %>%
  mutate(location_name = fct_reorder2(location_name, horizon, rae.mean, min),
         horizon = fct_inseq(factor(horizon))) %>%
  ggplot(aes(y = location_name, col = horizon)) +
  geom_point(aes(x = rae.mean)) +
  geom_linerange(aes(xmin = rae.lower, xmax = rae.upper)) +
  labs(x = "Relative average error (MAE) compared to baseline, mean with 95% CI, 
       across all models' forecasts",
       y = NULL,
       colour = "Weeks ahead") +
  scale_colour_viridis_d(option = 7) +
  facet_grid(~ target_variable_neat, scales = "free_x") +
  theme_bw() +
  theme(legend.position = "bottom")

# Show all 4 horizons
ae_by_loc_4wk <- ae_by_loc_plot
ggsave(height = 6, width = 6,
       filename = paste0(file_path, "/eval-location-ae-4wk.png"), 
       plot = ae_by_loc_4wk)

# Show only horizons 1 & 2
ae_by_loc_2wk_data <- ae_by_loc_plot$data %>%
  filter(horizon %in% c(1,2))
ae_by_loc_2wk <- ae_by_loc_plot
ae_by_loc_2wk$data <- ae_by_loc_2wk_data
ggsave(height = 6, width = 6,
       filename = paste0(file_path, "/eval-location-ae-2wk.png"), 
       plot = ae_by_loc_2wk)


