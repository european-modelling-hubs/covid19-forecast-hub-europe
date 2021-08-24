# Eval all models by rel wis
source(here::here("code", "papers", "forecast-eval", "get-eval.R"))



# average rel wis 
wis <- eval_all_locs %>%
  mutate(var = rel_wis) %>%
  group_by(model, model_abbr, horizon, target_variable_neat) %>%
  summarise(var.mean = mean(var, na.rm = TRUE),
            var.sd = sd(var, na.rm = TRUE),
            var.n = n()) %>%
  mutate(var.se = var.sd / sqrt(var.n),
         var.lower = var.mean - qt(1 - (0.05 / 2), var.n - 1) * var.se,
         var.upper = var.mean + qt(1 - (0.05 / 2), var.n - 1) * var.se) %>%
  rename_with(~ gsub("var.", "wis.", .x, fixed = TRUE))

wis_plot <- wis %>%
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
       caption = "Models which did not provide quantiles have no score") +
  facet_wrap(~ target_variable_neat, scales = "free_x") +
  theme_bw() +
  theme(legend.position = "bottom")

# Show all 4 horizons
wis_4wk <- wis_plot +
  labs(caption = "Not showing relative absolute error > 3 (n=3)")
ggsave(height = 6, width = 6,
       filename = paste0(file_path, "/eval-wis-4wk.png"), 
       plot = wis_4wk)

# Show only horizons 1 & 2
wis_2wk_data <- wis_plot$data %>%
  filter(horizon %in% c(1,2))
wis_2wk <- wis_plot
wis_2wk$data <- wis_2wk_data
ggsave(height = 6, width = 6,
       filename = paste0(file_path, "/eval-wis-2wk.png"), 
       plot = wis_2wk)
