# Eval all models by rel ae
source(here::here("code", "papers", "forecast-eval", "get-eval.R"))

# Models relative AE plotted across all locations
ae <- eval %>%
  mutate(var = rel_ae) %>%
  group_by(model, model_abbr, horizon, target_variable_neat) %>%
  summarise(var.mean = mean(var, na.rm = TRUE),
            var.sd = sd(var, na.rm = TRUE),
            var.n = n()) %>%
  mutate(var.se = var.sd / sqrt(var.n),
         var.lower = var.mean - qt(1 - (0.05 / 2), var.n - 1) * var.se,
         var.upper = var.mean + qt(1 - (0.05 / 2), var.n - 1) * var.se) %>%
  rename_with(~ gsub("var.", "rae.", .x, fixed = TRUE))

ae %>%
  filter(!grepl("baseline", model)) %>%
  group_by(target_variable_neat, horizon) %>%
  mutate(model = fct_reorder(model, rae.mean, min)) %>%
  ggplot(aes(y = model, col = factor(horizon, ordered = TRUE))) +
  geom_point(aes(x = rae.mean)) +
  geom_linerange(aes(xmin = rae.lower, xmax = rae.upper)) +
  geom_vline(aes(xintercept = 1), lty = 2) +
  scale_colour_viridis_d(option = 7) +
  xlim(c(0,3)) +
  labs(x = "Average relative error, 
       mean with 95%CI across all locations, compared to baseline",
       y = NULL,
       colour = "Weeks ahead",
       caption = "Not showing relative absolute error > 3 (n=3)") +
  facet_wrap(~ target_variable_neat, scales = "free_x") +
  theme_bw() +
  theme(legend.position = "bottom")

ggsave(paste0(file_path, "/eval-rae.png"))


# wis ---------------------------------------------------------------------

# check correlation of wis with ae
cor(eval$rel_ae, eval$rel_wis, use = "pairwise") # 0.81
cor_ae_wis <- eval %>%
  group_by(horizon, target_variable) %>%
  summarise(cor_ae_wis = cor(rel_wis, rel_ae, use = "pairwise"),
            .groups = "drop") %>%
  arrange()
# 0.85 to 0.97 correlations between relative AE and relative WIS
# across locations and models

# average rel wis 
wis <- eval %>%
  mutate(var = rel_wis) %>%
  group_by(model, model_abbr, horizon, target_variable_neat) %>%
  summarise(var.mean = mean(var, na.rm = TRUE),
            var.sd = sd(var, na.rm = TRUE),
            var.n = n()) %>%
  mutate(var.se = var.sd / sqrt(var.n),
         var.lower = var.mean - qt(1 - (0.05 / 2), var.n - 1) * var.se,
         var.upper = var.mean + qt(1 - (0.05 / 2), var.n - 1) * var.se) %>%
  rename_with(~ gsub("var.", "wis.", .x, fixed = TRUE))

wis %>%
  filter(!grepl("baseline", model)) %>%
  group_by(target_variable_neat, horizon) %>%
  mutate(model = fct_reorder(model, wis.mean, min)) %>%
  ggplot(aes(y = model, col = factor(horizon, ordered = TRUE))) +
  geom_point(aes(x = wis.mean)) +
  geom_linerange(aes(xmin = wis.lower, xmax = wis.upper)) +
  geom_vline(aes(xintercept = 1), lty = 2) +
  scale_colour_viridis_d(option = 7) +
  xlim(c(0,3)) +
  labs(x = "Average relative skill based on interval score, 
       mean with 95%CI across all locations, compared to baseline",
       y = NULL,
       colour = "Weeks ahead",
       caption = "Not showing relative absolute error > 3 (n=2)
       Models which did not provide quantiles have no score") +
  facet_wrap(~ target_variable_neat, scales = "free_x") +
  theme_bw() +
  theme(legend.position = "bottom")

ggsave(paste0(file_path, "/eval-wis.png"))

