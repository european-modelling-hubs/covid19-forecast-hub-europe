# Get latest evaluation scores ("eval"), filtered to 2 wk horizon ("h1_eval")
source(here::here("code", "papers", "forecast-eval", "get-eval.R"))
library(forcats)

# By absolute AE, the "easiest" (most accurate average MAE across all models) 
# target to predict was incident deaths in Iceland with average MAE only 0.2
# 
# The most difficult to predict was incident cases in France
# 
# Relative AE by location
h1_loc_ae <- h1_eval %>%
  filter(location != "Overall") %>%
  mutate(var = rel_ae) %>%
  group_by(location, target_variable_neat) %>%
  summarise(var.mean = mean(var, na.rm = TRUE),
            var.sd = sd(var, na.rm = TRUE),
            var.n = n()) %>%
  mutate(var.se = var.sd / sqrt(var.n),
         var.lower = var.mean - qt(1 - (0.05 / 2), var.n - 1) * var.se,
         var.upper = var.mean + qt(1 - (0.05 / 2), var.n - 1) * var.se) %>%
  rename_with(~ gsub("var.", "rae.", .x, fixed = TRUE))

h1_loc_ae %>%
  group_by(target_variable_neat) %>%
  left_join(hub_locations_ecdc, by = "location") %>%
  mutate(location_name = fct_reorder(location_name, rae.mean, min)) %>%
  ggplot(aes(y = location_name)) +
  geom_point(aes(x = rae.mean)) +
  geom_linerange(aes(xmin = rae.lower, xmax = rae.upper)) +
  labs(x = "Relative average error (MAE) compared to baseline, mean with 95% CI, 
       across all models' forecasts at 2-week horizon", 
       y = NULL) +
  facet_wrap(~ target_variable_neat, scales = "free_x") +
  theme_bw()
ggsave(paste0(file_path, "eval-location-rae.png"))


