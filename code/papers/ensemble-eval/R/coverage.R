source(here::here("code", "papers", "ensemble-eval", "R", "get-eval.R"))
library(ggplot2)


# Plot --------------------------------------------------------------------
# Coverage by ensemble with boxplot showing locations as points
plot_coverage <- eval_ensemble %>%
  filter(ensemble != "baseline") %>%
  ggplot(aes(y = ensemble_name, colour = horizon)) +
  geom_boxplot(aes(x = cov_50), 
               alpha = 0.8,
               outlier.alpha = 0.2,
               varwidth = TRUE) +
  geom_vline(aes(xintercept = 0.5), lty = 2) +
  xlim(c(0,1)) +
  labs(y = NULL, 
       x = "50% coverage across all forecasts",
       colour = "Weeks ahead", shape = "Weeks ahead") +
  scale_colour_viridis_d(direction = 1,
                         aesthetics = c("colour", "fill")) + 
  coord_flip() +
  facet_wrap(facets = vars(target_variable, ensemble_type),
             scales = "free", dir = "h",
             labeller = label_wrap_gen(multi_line = FALSE)) +
  theme_bw() +
  theme(legend.position = "bottom",
        legend.justification = "right",
        strip.background = element_blank())
# view
plot_coverage

# save
ggsave(filename = paste0(file_path_ensemble, "/figures/", "ensemble-coverage.png"),
       height = 4, width = 10,
       plot = plot_coverage)
