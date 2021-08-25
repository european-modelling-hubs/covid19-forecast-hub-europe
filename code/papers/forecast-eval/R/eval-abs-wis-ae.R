# Get latest evaluation scores
source(here::here("code", "papers", "forecast-eval", "R", "get-eval.R"))
# get absolute MAE
source(here::here("code", "papers", "forecast-eval", "R", "check-mae-scores.R"))
# join
abs_wis <- left_join(eval, 
                          rel_ae %>% 
                            select(-rel_ae) %>% 
                            mutate(horizon = as.numeric(horizon))) %>%
  select(model, target_variable_neat, horizon, location, 
         interval_score, ae_point)

#Figure 7: Mean WIS by forecast target and prediction horizon for submitted models and the preregistered
# median ensemble. For models providing only point forecasts, the mean AE is shown. The lower boundary of
# the grey area represents the baseline model KIT-baseline. Lines crossing the grey area thus indicate that
# a model fails

# Mean WIS and mean AE plotted against baseline
# (based on DE/PL hub paper figure 7)
# for case and deaths - location with highest and lowest average WIS/AE

# Where no interval score, using mean AE in place of mean WIS
abs_wis <- abs_wis %>%
  mutate(mean_score = case_when(is.na(interval_score) ~ ae_point,
                                TRUE ~ interval_score))

# separate out baseline to plot against
abs_wis_base <- abs_wis %>%
  filter(grepl("baseline", model)) %>%
  select(baseline_score = interval_score,
         target_variable_neat, horizon, location)

abs_wis_models <- abs_wis %>%
  filter(!grepl("baseline", model)) %>%
  full_join(abs_wis_base)
  
# tester plot
abs_wis_models %>%
  filter(location == "ES") %>%
  ggplot(aes(x = horizon, colour = model)) +
  geom_point(aes(y = mean_score)) +
  geom_line(aes(y = mean_score)) +
  geom_line(aes(y = baseline_score), lty = 2) +
  geom_ribbon(aes(ymin = baseline_score, ymax = Inf), 
              alpha = 0.01) +
  facet_wrap(~ target_variable_neat, scales = "free") +
  theme_bw() +
  theme(legend.position = "bottom")
  
# Identify how many models did better or worse than baseline 
#  by location, on average across all horizons
abs_wis_locs <- abs_wis_models %>%
  filter(location != "Overall") %>%
  mutate(diff = baseline_score - mean_score) %>%
  group_by(target_variable_neat, location) %>%
  summarise(mean_diff = mean(diff, na.rm = TRUE),
            n_better = sum(diff < 0),
            n_worse = sum(diff >= 0),
            n = n(),
            pct_better = (n_better / n),
            pct_worse = (n_worse / n))

# Locations with more than half forecasts beating baseline
nrow(abs_wis_locs %>%
       filter(target_variable_neat == "Cases" & pct_better > 0.5))

# Locations with biggest differences between cases and deaths
abs_wis_locs_var <- abs_wis_locs %>%
  pivot_wider(id_cols = location,
              names_from = target_variable_neat,
              values_from = pct_worse) %>%
  mutate(cases_deaths_diff = Cases - Deaths) 
# how much models are better at predicting deaths than cases compared to baseline
# ie baseline is easy to predict cases, models better at predicting deaths in all 
#  but 2 locs
#  
#  