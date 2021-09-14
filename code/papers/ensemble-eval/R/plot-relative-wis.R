library(ggplot2)

# Average relative score against baseline ------------------------------------------
# Boxplot: spread of each model's relative performance across locations
rel_score <- eval %>%
  filter(#horizon %in% c(1, 2) & 
           !location %in% "Overall" & 
           !grepl("baseline", model) &
             !grepl("horizon", model)) %>%
  group_by(target_variable, model_name, horizon) %>%
  mutate(n_locs = length(unique(location))) %>%
  ungroup() 

# Rel WIS
rwis_plot <- rel_score %>%
  mutate(horizon = factor(horizon, ordered = TRUE)) %>%
  ggplot(aes(y = model_name, 
             colour = horizon,
             fill = horizon)) +
  geom_boxplot(aes(x = rel_wis),
               alpha = 0.8,
               #outlier.shape = NA
               ) +
  # geom_jitter(aes(x = rel_wis),
  #              alpha = 0.2) +
  # xlim(c(0, 3)) +
  geom_vline(aes(xintercept = 1), lty = 2) +
  labs(y = NULL, x = "Scaled relative WIS per location",
       colour = "Weeks ahead", fill = "Weeks ahead") +
  scale_colour_brewer(type = "seq", direction = -1, 
                      aesthetics = c("colour", "fill"),
                      ) + # palette = "Set1"
  coord_flip() +
  facet_grid(rows = vars(target_variable), scales = "free_x") +
  theme_bw() +
  theme(legend.position = "bottom",
        legend.justification = "right",
        axis.text.x = element_text(angle = 30, hjust = 1))

# view
rwis_plot

# save
ggsave(filename = paste0(file_path, "/figures/", "model-relative-wis.png"),
       height = 5, width = 9,
       plot = rwis_plot)
