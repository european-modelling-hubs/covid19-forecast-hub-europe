# Plot components + weights of contributing models

# origin: create-all-methods-ensembles.R

# Get evaluation dataset
library(here)
library(readr)
library(dplyr)
library(purrr)
library(tidyr)
library(ggplot2)

library(covidHubUtils)
library(EuroForecastHub)

# get eval
source(here::here("code", "papers", "ensemble-eval", "R", "get-eval.R"))
# max_date <- "2021-08-23"
  
# get weights -------------------------------------------------------------
# Pre-cleaning weights: saved for quicker loading
# weights_files <- dir(here("ensembles", "weights"),
#                      recursive = TRUE, full.names = FALSE)
# names(weights_files) <- 1:152
# 
# # read using purrr as files have inconsistent columns
# weights_raw <- map_dfr(here("ensembles", "weights", weights_files),
#                ~ read_csv(.), .id = "file") %>%
#   mutate(file = recode(file, !!!weights_files),
#          target_variable = recode(target_variable, !!!clean_variable_names)) %>%
#   # get ensemble method and date from file name
#   separate(file, into = c("ensemble", "forecast_date"),
#            sep = "/", remove = TRUE) %>%
#   separate(forecast_date, into = "forecast_date",
#            sep = "-EuroCOVIDhub", extra = "drop") %>%
#   mutate(forecast_date = as.Date(forecast_date),
#          ensemble = gsub("EuroCOVIDhub-", "", ensemble),
#          ensemble_name = recode(ensemble, !!!clean_ensemble_names)) %>%
#   left_join(covidHubUtils::hub_locations_ecdc, by = "location") %>%
#   filter(forecast_date <= as.Date(max_date))
# 
# weights <- weights_raw %>%
#   filter(!grepl("Overall", location) &
#            forecast_date >= "2021-03-15") %>%
#   mutate(weighting = case_when(!is.na(horizon) ~ "Weighted by horizon",
#                               grepl("weighted", ensemble) ~ "Weighted",
#                               TRUE ~ "Simple"),
#          horizon = ifelse(is.na(horizon), "All", horizon))
# 
# write_csv(weights, here(file_path_ensemble, "data", "weights.csv"))

# load pre-saved from code above
weights <- read_csv(here(file_path_ensemble, "data", "weights.csv"))

weights_wide <- weights %>%
  select(-ensemble_name) %>%
  pivot_wider(values_from = weight, names_from = ensemble)

# Number of component models over time ------------------------------
# component models over time
component_models <- weights %>%
  filter(grepl("mean", ensemble)) %>%
  group_by(target_variable, ensemble_name, 
           weighting, horizon, 
           forecast_date, location_name) %>%
  summarise(n_models = n(),
            sum_weights = sum(weight, na.rm = TRUE)) %>%
  mutate(n_models = ifelse(sum_weights == 0, NA, n_models)) %>%
  filter(!grepl("by horizon", weighting))

component_models_desc <- map(split(component_models, 
                                   component_models$weighting), 
                             ~ tibble(
                               min = min(.$n_models, na.rm = TRUE),
                               max = max(.$n_models, na.rm = TRUE),
                               total = nrow(.)))

# component models over time: plot
plot_component_models <- component_models %>%
  ggplot(aes(x = forecast_date, y = location_name, 
             fill = n_models)) +
  geom_tile() +
  labs(x = NULL, y = NULL,
       fill = "Number of component models") +
  scale_fill_viridis_c(direction = -1, 
                       breaks = seq(0,18, by = 3),
                       na.value = 0) +
  scale_x_date(date_breaks = "6 weeks",
               date_labels = "%b") +
  facet_wrap(facets = vars(target_variable, weighting),
             scales = "fixed", dir = "h",
             nrow = 1,
             labeller = label_wrap_gen(multi_line = FALSE)) +
  theme_bw() +
  theme(legend.position = "bottom",
        strip.background = element_blank())

#view
plot_component_models
#save
ggsave(here(file_path_ensemble, "figures", "n-component-models.png"),
       height = 5, width = 10)


# average weight by model per ensemble method --------------------------

# average over all time by location
simple_to_weighted <- weights %>%
  filter(grepl("(m|M)ean", ensemble_name) &
           horizon == "All") %>%
  mutate(ensemble = factor(ensemble)) %>% # alphabetical: mean then relative_...
  group_by(model, forecast_date, target_variable, location) %>%
  mutate(change_to_weighted = weight - lag(weight)) %>%
  ungroup() %>%
  filter(!is.na(change_to_weighted)) %>%
  group_by(model, target_variable, location) %>%
  summarise(change_to_weighted = mean(change_to_weighted, na.rm = TRUE),
            n = n())

# Plot average weight for models weighted by skill
# Average difference in contribution to ensemble,
# for each model, location, and target, between simple and weighted 
# Distribution of difference for model, for each country
plot_simple_to_weighted <- simple_to_weighted %>%
  ggplot(aes(x = model, y = change_to_weighted)) +
  geom_boxplot(alpha = 0.8,
               outlier.alpha = 0.2,
               aes(colour = target_variable, fill = target_variable)) +
  geom_hline(aes(yintercept = 0), lty = 2) +
  scale_colour_brewer(palette = "Set1", aesthetics = c("colour", "fill")) +
  labs(y = "Difference of skill-based weight",
       x = NULL, fill = NULL, colour = NULL) +
  theme_bw() +
  theme(legend.position = "bottom",
        axis.text.x = element_text(angle = 30, hjust = 1),
        plot.margin = unit(c(0.1,0.1,0.1,1), "cm"))
#view
plot_simple_to_weighted

#save
ggsave(here(file_path_ensemble, "figures", "weights-simple-to-weighted.png"),
            height = 4, width = 8,
       plot = plot_simple_to_weighted)


# Description -------------------------------------------------------------


