# Model methods
library(here)
library(dplyr)
library(ggplot2)
source(here("code", "validation", "get-metadata.R"))


# Models by method --------------------------------------------------------
# # Metadata: manually categorised by location of team institution
# source(here("code", "validation", "get-metadata.R"))
# metadata <- get_metadata(exclude_designated_other = TRUE, exclude_hub = TRUE)
# metadata %>%
#   select(model_abbr, methods, methods_long, citation, website_url, repo_url) %>%
#   write_csv(here("code", "exploratory", 
#     "eval-by-method", "models-by-method.csv"))
# # manually entered method against metadata, citation/web/repo where given
# # re-written to csv

models <- read_csv(here("code", "exploratory", 
                        "eval-by-method", "models-by-method.csv")) %>%
  select(model_abbr, method)

# plot distribution of methods
models %>%
  ggplot() +
  geom_bar(aes(x = forcats::fct_infreq(method))) +
  labs(y = NULL, x = NULL) +
  theme_classic()

method_freq <- models %>%
  group_by(method) %>%
  summarise(n_models = n())

# Evaluation --------------------------------------------------------------
# get eval
eval <- read_csv(here("evaluation", "evaluation-2021-07-19.csv")) %>%
  filter(horizon <= 4)

# join to methods
eval_by_method <- eval %>%
  rename(model_abbr = model) %>%
  left_join(models, by = "model_abbr") %>%
  filter(model_abbr %in% c(models$model_abbr, 
                           "EuroCOVIDhub-baseline", "EuroCOVIDhub-ensemble")) %>%
  mutate(method = ifelse(is.na(method), model_abbr, method))

# plot distribution of forecasts by method
method_forecast_freq <- eval_by_method %>%
  filter(!grepl("EuroCOVIDhub", model_abbr)) %>%
  group_by(method) %>%
  summarise(n_forecasts = sum(n)) %>%
  left_join(method_freq) %>%
  tidyr::pivot_longer(-method)

method_levels <- c("statistical", "mathematical", "mixed", "spatial", "other")

method_forecast_freq %>%
  group_by(name) %>%
  mutate(percent = value / sum(value),
         variable = case_when(name == "n_forecasts" ~ "% evaluated forecast targets",
                           name == "n_models" ~ "% evaluated models"),
         method = factor(method, levels = method_levels)) %>%
  ggplot(aes(x = method, fill = variable)) +
  geom_col(aes(y = percent), position = "dodge") +
  labs(x = NULL, y = NULL, fill = NULL,
       caption = "Evaluated targets = 90,156 unique model/location/horizon/date/variable combinations
       Evaluated models = 39 submitted models") +
  scale_y_continuous(labels = scales::percent) +
  scale_fill_viridis_d(option = 10, end = 0.9) +
  theme_classic() +
  theme(legend.position = "bottom")

eval_by_method %>%
  filter(!grepl("EuroCOVIDhub", model_abbr)) %>%
  ggplot(aes(x = forcats::fct_infreq(method))) +
  geom_bar() +
  labs(y = NULL, x = NULL) +
  theme_classic()

# summarise
eval_method_type <- eval_by_method %>%
  filter(!is.na(scaled_rel_skill) &
           !scaled_rel_skill == Inf) %>%
  # filter(!method == "EuroCOVIDhub-baseline") %>%
  group_by(method, target_variable, horizon) %>%
  summarise(mean.skill = mean(scaled_rel_skill, na.rm = TRUE),
            sd.skill = sd(scaled_rel_skill, na.rm = TRUE),
            n.skill.scores = n(),
            n.forecasts = sum(n)) %>%
  mutate(se.skill = sd.skill / sqrt(n.skill.scores),
         lower.ci.skill = mean.skill - qt(1 - (0.05 / 2), n.skill.scores - 1) * se.skill,
         upper.ci.skill = mean.skill + qt(1 - (0.05 / 2), n.skill.scores - 1) * se.skill) %>%
  mutate(weeks_ahead = factor(horizon, 
                              levels = c("1", "2", "3", "4")))







  
