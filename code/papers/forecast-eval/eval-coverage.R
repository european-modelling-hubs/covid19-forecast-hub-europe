# 50 Coverage ----------------------------------------------------------------
# Point mean average across all locations
h1_cov50 <- h1_eval %>%
  group_by(model, target_variable_neat) %>%
  summarise(cov50.mean = mean(cov_50, na.rm = TRUE),
            cov50.sd = sd(cov_50, na.rm = TRUE),
            cov50.n = n()) %>%
  drop_na(cov50.mean) %>%
  mutate(cov50.se = cov50.sd / sqrt(cov50.n),
         cov50.lower = cov50.mean - qt(1 - (0.05 / 2), cov50.n - 1) * cov50.se,
         cov50.upper = cov50.mean + qt(1 - (0.05 / 2), cov50.n - 1) * cov50.se,
         diff = 0.5 - cov50.mean) %>%
  group_by(target_variable_neat) %>%
  mutate(model = fct_reorder(model, diff, min)) %>%
  ungroup()

h1_cov50 %>%
  ggplot(aes(y = model)) +
  geom_point(aes(x = cov50.mean)) +
  geom_linerange(aes(xmin = cov50.lower, xmax = cov50.upper)) +
  geom_vline(aes(xintercept = 0.5), lty = 2) +
  xlim(c(0,1)) +
  labs(x = NULL, y = "Average coverage across all forecasts",
       colour = "Target", shape = "Target") +
  theme_bw() +
  facet_wrap(~ target_variable_neat)

 ggsave(height = 6, width = 6,
        filename = paste0(file_path, "eval-coverage.png"))


# 95 and 50 coverage ------------------------------------------------------

# # Point mean average across all locations
# h1_cov <- h1_eval %>%
#   select(model_abbr, target_variable_neat, cov_95, cov_50) %>%
#   group_by(model_abbr, target_variable_neat) %>%
#   summarise(cov_95 = mean(cov_95, na.rm = TRUE),
#             cov_50 = mean(cov_50, na.rm = TRUE)) %>%
#   pivot_longer(c(cov_95, cov_50), values_to = "coverage", names_to = "cov_level") %>%
#   group_by(model_abbr, target_variable_neat, cov_level) %>%
#   mutate(cov_true = case_when(cov_level == "cov_95" ~ 0.95,
#                               cov_level == "cov_50" ~ 0.5),
#          cov_mean = mean(coverage)) %>%
#   ungroup() %>%
#   mutate(model_order = forcats::fct_reorder(model_abbr, cov_mean, max)) 
# 
# h1_cov %>%
#   ggplot(aes(x = model_order, y = coverage, 
#              col = cov_level, shape = cov_level)) +
#   geom_point(position = position_dodge(width = 0.5)) +
#   geom_hline(aes(yintercept = cov_true), lty = 2) +
#   labs(x = NULL, y = "Average coverage across all forecasts", 
#        colour = "Target", shape = "Target") +
#   theme_classic() +
#   theme(legend.position = "bottom", 
#         strip.background = element_blank()) +
#   facet_grid(rows = vars(cov_level), cols = vars(target_variable_neat))
# 
# ggsave(paste0(file_path, "eval-cov.png"))
