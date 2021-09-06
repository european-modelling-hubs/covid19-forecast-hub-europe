# plot all model scores against baseline
library(forcats)
library(ggplot2)

# Get latest evaluation scores
source(here::here("code", "papers", "forecast-eval", "R", "get-eval.R"))

# Keep only the 1 week horizon
h1 <- eval_wide %>%
  filter(!location %in% "Overall") %>%
  filter(horizon == 1) %>%
  select(model, model_abbr, model_score_source,
         target_variable, location, 
         model_score, rel_wis, rel_ae,
         baseline_score, ensemble_score)

# Average relative score against baseline ------------------------------------------
# Boxplot: spread of each model's relative performance across locations
rel_score <- eval %>%
  filter(horizon %in% c(1, 2) & 
           !location %in% "Overall" & 
           !grepl("baseline", model)) %>%
  group_by(target_variable, model, horizon) %>%
  mutate(n_locs = length(unique(location))) %>%
  ungroup() %>%
  mutate(rel_wis_point = ifelse(n_locs == 1, rel_wis, NA), # & !is.na(rel_wis), rel_wis,
         rel_wis_multi = ifelse(n_locs > 1, rel_wis, NA),
         rel_ae_point = ifelse(n_locs == 1, rel_ae, NA), # & !is.na(rel_wis), rel_wis,
         rel_ae_multi = ifelse(n_locs > 1, rel_ae, NA)) %>%
  ungroup() 

# Rel WIS
rwis_plot <- rel_score %>%
  mutate(horizon = factor(horizon, ordered = TRUE)) %>%
  ggplot(aes(y = model, 
             colour = horizon,
             fill = horizon)) +
  geom_boxplot(aes(x = rel_wis_multi),
               alpha = 0.8,
               outlier.shape = NA) +
  geom_jitter(aes(x = rel_wis_multi),
              alpha = 0.2) +
  geom_point(aes(x = rel_wis_point), alpha = 0.9,
             position = position_dodge(width = 0.1)) +
  xlim(c(0, 3)) +
  geom_vline(aes(xintercept = 1), lty = 2) +
  labs(y = NULL, x = "Scaled relative WIS per location",
       colour = "Weeks ahead", fill = "Weeks ahead") +
  scale_fill_brewer(palette = "Set1") +
  scale_colour_brewer(palette = "Set1") +
  coord_flip() +
  facet_grid(rows = vars(target_variable), scales = "free_x") +
  theme_bw() +
  theme(legend.position = "bottom",
        axis.text.x = element_text(angle = 30, hjust = 1),
        plot.margin = unit(x = c(0.2,0.2,0.2,2), units = "cm"))
        
ggsave(filename = paste0(file_path, "/figures/", "model-relative-wis.png"),
       height = 5, width = 9,
       plot = rwis_plot)

# Rel AE
rae_plot <- rel_score %>%
  mutate(horizon = factor(horizon, ordered = TRUE)) %>%
  ggplot(aes(y = model, 
             colour = horizon,
             fill = horizon)) +
  geom_boxplot(aes(x = rel_ae_multi),
               alpha = 0.8,
               outlier.shape = NA) +
  geom_jitter(aes(x = rel_ae_multi),
              alpha = 0.2) +
  geom_point(aes(x = rel_ae_point), alpha = 0.9,
             position = position_dodge(width = 0.1)) +
  xlim(c(0, 3)) +
  geom_vline(aes(xintercept = 1), lty = 2) +
  labs(y = NULL, x = "Scaled relative AE per location",
       colour = "Weeks ahead", fill = "Weeks ahead") +
  scale_fill_brewer(palette = "Set1") +
  scale_colour_brewer(palette = "Set1") +
  coord_flip() +
  facet_grid(rows = vars(target_variable), scales = "free_x") +
  theme_bw() +
  theme(legend.position = "bottom",
        axis.text.x = element_text(angle = 30, hjust = 1),
        plot.margin = unit(x = c(0.2,0.2,0.2,2), units = "cm"))

ggsave(filename = paste0(file_path, "/figures/", "model-relative-ae.png"),
       height = 5, width = 9,
       plot = rae_plot)

###
rae_n_pairs_cases <- sum(rae$target_variable == "Cases")
rae_n_pairs_deaths <- sum(rae$target_variable == "Deaths")
rae_n_outliers <- nrow(filter(rae, rel_ae > 3))


# Rel AE description ------------------------------------------------------
# by model
rae_summary <- rae %>%
  group_by(model, target_variable, horizon) %>%
  summarise(mean_scale_score = mean(rel_ae, na.rm = TRUE),
            outperform = sum(rel_ae < 1, na.rm = TRUE),
            underperform = sum(rel_ae >= 1, na.rm = TRUE),
            n_locations = n(),
            out_p = round(outperform / n_locations, 2),
            under_p = round(underperform / n_locations, 2),
            min_scaled_score = min(rel_ae, na.rm = TRUE),
            max_scaled_score = max(rel_ae, na.rm = TRUE),
            scaled_range = max_scaled_score - min_scaled_score)
  
# by location
rae_summary_location <- rae %>%
  group_by(location, target_variable, horizon) %>%
  summarise(mean_scale_score = mean(rel_ae, na.rm = TRUE),
            outperform = sum(rel_ae < 1, na.rm = TRUE),
            underperform = sum(rel_ae >= 1, na.rm = TRUE),
            n_locations = n(),
            out_p = round(outperform / n_locations, 2),
            under_p = round(underperform / n_locations, 2),
            min_scaled_score = min(rel_ae, na.rm = TRUE),
            max_scaled_score = max(rel_ae, na.rm = TRUE),
            scaled_range = max_scaled_score - min_scaled_score)


# Raw average score by model ----------------------------------------------------------------
# - not saved
# Absolute error or interval score, model vs baseline score
# get a  average of relative score for each model v baseline,
#  across all locations, by case/death
h1_average_score <- h1  %>%
  group_by(model, model_abbr, target_variable) %>%
  summarise(# average score of comparators
    mean_baseline_score = mean(baseline_score),
    mean_ensemble_score = mean(ensemble_score),
    # average raw interval or AE score
    mean_model_score = mean(model_score),
    # average scaled relative score compared to baseline
    mean_rel_ae = mean(rel_ae, na.rm = TRUE),
    mean_rel_wis = mean(rel_wis, na.rm = TRUE),
    # number of locations in which better or worse than baseline
    rel_ae_better = sum(rel_ae < 1, na.rm = TRUE),
    rel_ae_worse = sum(rel_ae > 1, na.rm = TRUE),
    n = n())

h1_average_score %>%
  # filter(baseline_score < 100) %>%
  ggplot(aes(x = mean_baseline_score, y = mean_model_score)) +
  geom_point(aes(colour = model_abbr), alpha = 0.5) +
  geom_abline(lty = 2) +
  #scale_x_log10() +
  #scale_y_log10() +
  # geom_text(aes(label = model_abbr), vjust = "inward", hjust = "inward") +
  labs(x = "Baseline score", y = "Average model score", 
       colour = "Model") +
  facet_wrap(~ target_variable, scales = "free") +
  theme_bw() +
  theme(legend.position = "bottom")


# Variety of best performers ----------------------------------------------
# Variety of models making up the "best" performing for each target
# Target = location * variable * 1 horizon
top_target <- eval %>%
  filter(horizon %in% c(1,2) &
           location != "Overall") %>% # 
  # Keep only the best model by relative AE
  group_by(target_variable, location, horizon) %>%
  slice_min(rel_ae, n = 1) %>%
  select(location, horizon, target_variable, 
         team_name, model_name, model,
         rel_ae, model_score, model_score_source)

# Summarise how many targets each model was top for
top_target_models <- top_target %>%
  group_by(model, target_variable, horizon) %>%
  summarise(n = n(),
            n_pct = round(n / nrow(top_target) * 100, 1))

# Plot
top_models_plot <- top_target_models %>%
  group_by(model) %>%
  mutate(horizon = fct_reorder(as.character(horizon), horizon, sum)) %>%
  group_by(target_variable) %>%
  ggplot(aes(y = model, x = n)) + 
  geom_col(aes(fill = horizon), position = position_stack()) +
  # scico::scale_fill_scico_d(palette = "bamako", end = 0.8, direction = -1) +
  scale_fill_viridis_d(alpha = 0.6, guide = "legend") +
  labs(y = NULL, x = "Number of targets out of 32 for which a model ranked first 
       on absolute error relative to baseline",
       fill = "Weeks ahead") +
  facet_wrap(~ target_variable, scales = "fixed") +
  theme_bw() +
  theme(legend.position = "bottom")

plot(top_models_plot)

  ggsave(filename = paste0(file_path, "/figures/", "top-models.png"),
       height = 4, width = 5,
       plot = top_models_plot)
  
# Percent of all targets of cases and deaths in 32 locations
# over 1 and 2 week horizons in which model ranked best among all models relative to baseline forecast
# (available targets N = 64, top ranks = 69 due to tied rankings

