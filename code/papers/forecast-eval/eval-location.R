library(forcats)

# Top models across different stratifications
# How does the composition of the best performing models change across different stratifications?

# Take only 2 week horizon

# Rank at the most aggregated level

# Rank by each 32 location for both 2 variables
# Rank by 2 variable for all 32 locations
# Rank by location and variable
# Which models appear in top n rank? 
# Is there a consistent direction in scores?
# Did any models reverse a more general trend?
# EG average interval score improves (lower) for cases than deaths
# - is there any model with better (lower) average for deaths than cases
# 
# Compare: rank by horizon

# get eval

h2 <- filter(eval, horizon == 2) %>%
  mutate(across(interval_score:mae, as.numeric))

# Top models across all locations by any variable
h2_overall <- h2 %>%
  filter(location == "Overall") %>%
  slice_min(scaled_rel_skill, prop = 0.25)

h2_loc_av <- h2 %>%
  filter(location == "Overall") %>%
  group_by(model, model_abbr) %>%
  summarise(across(interval_score:mae, mean, na.rm = TRUE), .groups = "drop") %>%
  mutate(score_group = "averaged across targets for overall location") %>%
  slice_min(scaled_rel_skill, prop = 0.25)


# where is "easy" to predict?
# average MAE by location

# The "easiest" (most accurate average MAE across all models) to predict was
# incident deaths in Iceland with average MAE only 0.2
# The top 14 of 64 location/target pairs ranked by average MAE were death forecasts
# Compare this table to the mean and SD of truth data over eval period
# Check if rank scores correlate - are targets easier at low counts or stable periods?
# 
# 
# Variability in model performance for each location
# Confidence interval around the mean of all model scores for each of 32 countries
h2_easy_loc <- h2 %>%
  filter(location != "Overall") %>%
  mutate(var = mae) %>%
  group_by(location, target_variable_neat) %>%
  summarise(var.mean = mean(var, na.rm = TRUE),
            var.sd = sd(var, na.rm = TRUE),
            var.n = n()) %>%
  mutate(var.se = var.sd / sqrt(var.n),
         var.lower = var.mean - qt(1 - (0.05 / 2), var.n - 1) * var.se,
         var.upper = var.mean + qt(1 - (0.05 / 2), var.n - 1) * var.se) %>%
  rename_with(~ gsub("var.", "mae.", .x, fixed = TRUE))

h2_easy_loc %>%
  group_by(target_variable_neat) %>%
  left_join(hub_locations_ecdc, by = "location") %>%
  mutate(location_name = fct_reorder(location_name, mae.mean, min)) %>%
  ggplot(aes(y = location_name)) +
  geom_point(aes(x = mae.mean)) +
  geom_linerange(aes(xmin = mae.lower, xmax = mae.upper)) +
  labs(x = "Mean average error (MAE), mean with 95% CI, 
       across all models' forecasts at 2-week horizon", 
       y = NULL) +
  facet_wrap(~ target_variable_neat, scales = "free_x") +
  theme_bw()
ggsave(paste0(figure_path, "eval-location.png"))

















