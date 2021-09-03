# Scores by horizon
library(ggplot2)

# Get latest evaluation scores
source(here::here("code", "papers", "forecast-eval", "R", "get-eval.R"))

h1_h4 <- eval_wide %>%
  group_by(model, horizon, target_variable) %>%
  summarise(mean_wis = mean(rel_wis, na.rm = TRUE),
            mean_cov50 = mean(cov_50, na.rm = TRUE),
            mean_cov95 = mean(cov_95, na.rm = TRUE)) %>%
  mutate(hub = model == "EuroCOVIDhub-ensemble")


# Plot coverage -----------------------------------------------------------
# get coverage to long format
h1_h4 %>%
  tidyr::pivot_longer(names_to = "coverage_level", values_to = "coverage",
                      cols = c(mean_cov50, mean_cov95)) %>%
  mutate(coverage_level = recode(coverage_level,
                                 "mean_cov50" = "Coverage 50%",
                                 "mean_cov95" = "Coverage 95%"),
         expected = ifelse(coverage_level == "Coverage 50%",
                           0.5, 0.95)) %>%
  ggplot(aes(x = horizon, y = coverage, colour = model)) +
  geom_point(aes(fill = coverage_level)) +
  geom_line() +
  geom_hline(aes(yintercept = expected), lty = 2, colour = "black") +
  gghighlight::gghighlight(hub == TRUE, 
                           calculate_per_facet = TRUE,
                           use_direct_label = FALSE) +
  scale_color_brewer(type = "qual", palette = 6) +
  labs(y = NULL, x = "Weeks ahead horizon") +
  facet_grid(rows = vars(coverage_level), 
             cols = vars(target_variable),
             scales = "free") +
  theme_bw() +
  theme(legend.position = "none") 

ggsave(here(file_path, "figures", 
            paste0(Sys.Date(), "-model-coverage-horizon.png")))


# rel WIS per model by horizon --------------------------------------------
h1_h4 %>%
  ggplot(aes(x = horizon, y = mean_wis, colour = model)) +
  geom_point() +
  geom_line() +
  geom_hline(aes(yintercept = 1), lty = 2, col = "black") +
  gghighlight::gghighlight(hub == TRUE, 
                           calculate_per_facet = TRUE,
                           use_direct_label = FALSE) +
  labs(x = "Weeks ahead horizon", y = "Mean relative WIS") +
  scale_color_brewer(type = "qual", palette = 6) +
  facet_wrap(~ target_variable, scales = "free") +
  theme_bw() +
  theme(legend.position = "none") 

ggsave(here(file_path, "figures", 
            paste0(Sys.Date(), "-model-relwis-horizon.png")))
