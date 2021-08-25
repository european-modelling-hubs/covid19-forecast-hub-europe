# Consistency of model performance among forecast targets
# Compare ranks: Which models appear in top n rank? 
source(here::here("code", "papers", "forecast-eval", "get-eval.R"))
# 
# 256 forecast combinations: 2 target variables * 32 locations * 4 horizons 
combinations <- length(unique(eval_all_locs$horizon)) * 
  length(unique(eval_all_locs$target_variable)) * 
  length(unique(eval_all_locs$location))

# Top model for each location ~ horizon ~ variable
top_models_targets <- eval_all_locs %>%
  filter(!grepl("baseline", model)) %>%
  group_by(location, target_variable_neat, horizon) %>%
  arrange(rel_ae, .by_group = TRUE) %>%
  mutate(rank = row_number())

# number of forecast targets when the best model was worse than the baseline
nrow(filter(top_models_targets, rel_ae >= 1)) / nrow(top_models_targets) * 100

# number of times each model was the best ranked among models
#  - this includes tied pairs
ranks <- top_models_targets %>%
  group_by(model) %>%
  summarise(rank_1 = sum(rank == 1),
            rank_2 = sum(rank == 2),
            rank_3 = sum(rank == 3),
            rank_4 = sum(rank == 4),
            rank_5 = sum(rank == 5)) %>%
  mutate(rank.sum = rank_1 + rank_2 + rank_3 + rank_4 + rank_5)
# of all 256 targets, the ensemble appeared in the top 5 models ranked by relative AE,
# 210 times, more than any other model.  

rank_long <- ranks %>%
  pivot_longer(cols = starts_with("rank_"),
               names_to = "rank",
               values_to = "rank_n") %>%
  mutate(rank = as.numeric(stringr::str_remove_all(rank, "rank_"))) %>%
  filter(rank_n > 0)

# Plot
rank_long %>%
  mutate(model = fct_reorder(model, rank.sum),
         rank = fct_inseq(factor(rank))) %>%
  ggplot(aes(x = rank_n, y = model, fill = rank)) +
  geom_col() +
  scale_fill_viridis_d(option = 10) +
  labs(x = "Number of times appearing in top five ranked models 
       of 256 forecast targets",
       y = NULL) +
  theme_bw() +
  theme(legend.position = "bottom")
ggsave(filename = paste0(file_path, "/figures/eval-ranks.png"),
       height = 6, width = 6)

# - this just shows the models which forecast for the most number of places

# todo:
# How does the composition of the best performing models change across 
#  different stratifications?

# check-mae-score.R
models <- model_desig %>%
  filter(designation != "other") %>% 
  pull(model)

targets <- score_df %>%
  distinct(model, horizon, location, target_variable) %>%
  mutate(horizon = as.numeric(horizon),
         present_in_forecast = 1) %>%
  filter(model %in% models & 
           horizon <= 4)

