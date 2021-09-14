# Plot components + weights of contributing models

# Get evaluation dataset
library(here)
library(readr)
library(dplyr)
library(purrr)
library(tidyr)
library(ggplot2)

library(covidHubUtils)
library(EuroForecastHub)

# path to this folder of main hub repo - for saving figures
file_path <- here("code", "papers", "ensemble-eval", "/")
ensemble_names <- c(
  "mean" = "Mean",
  "median" = "Median",
  "relative_skill_weighted_mean" = "Weighted mean",
  "relative_skill_weighted_mean_by_horizon" = "Weighted mean by horizon",
  "relative_skill_weighted_median" = "Weighted median",
  "relative_skill_weighted_median_by_horizon" = "Weighted median by horizon"
  )
  
# get weights -------------------------------------------------------------
weights_files <- dir(here("ensembles", "weights"), 
                     recursive = TRUE, full.names = FALSE)
names(weights_files) <- 1:152

# read using purrr as files have inconsistent columns
weights_raw <- map_dfr(here("ensembles", "weights", weights_files), 
               ~ read_csv(.), .id = "file") %>%
  mutate(file = recode(file, !!!weights_files),
         target_variable = recode(target_variable, 
                                  "inc case" = "Cases", "inc death" = "Deaths")) %>%
  # get ensemble method and date from file name
  separate(file, into = c("ensemble", "forecast_date"), 
           sep = "/", remove = TRUE) %>%
  separate(forecast_date, into = "forecast_date",
           sep = "-EuroCOVIDhub", extra = "drop") %>%
  mutate(forecast_date = as.Date(forecast_date),
         ensemble = gsub("EuroCOVIDhub-", "", ensemble),
         ensemble_name = recode(ensemble, !!!ensemble_names)) %>%
  left_join(covidHubUtils::hub_locations_ecdc, by = "location")

weights <- weights_raw %>%
  filter(!grepl("Overall", location) &
           forecast_date >= "2021-03-15") %>%
  mutate(horizon = ifelse(is.na(horizon), "All", horizon))

weights_wide <- weights %>%
  select(-ensemble_name) %>%
  pivot_wider(values_from = weight, names_from = ensemble)


# Plot: number of component models over time ------------------------------
# show number of models each week
weights_raw %>%
  filter(!location == "Overall" &
           ensemble %in% c("Mean", "Weighted mean")) %>%
  mutate(ensemble = recode(ensemble, 
                           "Mean" = "Simple", 
                           "Weighted mean" = "Weighted")) %>%
  group_by(target_variable, ensemble, forecast_date, location_name) %>%
  summarise(n_models = n()) %>%
  ggplot(aes(x = forecast_date, y = location_name, 
             fill = n_models)) +
  geom_tile() +
  labs(x = NULL, y = NULL,
       fill = "Number of component models") +
  scale_x_date(date_breaks = "6 weeks",
               date_labels = "%b") +
  facet_grid(cols = vars(ensemble),
             rows = vars(target_variable),
             scales = "free") +
  theme_bw() +
  theme(legend.position = "bottom")

ggsave(here(file_path, "figures", "n-component-models.png"),
       height = 10)

# average weight by model per ensemble method --------------------------

# average over all time and all locations
model_average <- weights %>%
  group_by(ensemble, model, target_variable, horizon) %>%
  summarise(n_weights = n(),
            mean_weight = mean(weight, na.rm = TRUE))

# Plot average weight for models weighted by skill
model_average %>%
  filter(grepl("Weighted", ensemble)) %>%
  ggplot(aes(x = model, y = mean_weight,
             colour = horizon, fill = horizon)) +
  geom_point() +
  facet_grid(rows = vars(target_variable),
             cols = vars(ensemble))

# weighted by skill: average over all locations, split over time, ignore weight by horizon
model_average_date <- weights %>%
  filter(!grepl("by horizon", ensemble) &
           grepl("Weighted", ensemble)) %>%
  group_by(ensemble, model, target_variable, 
           forecast_date) %>%
  summarise(n_weights = n(),
            mean_weight = mean(weight, na.rm = TRUE))

# Plot weight over time, highlighting only those with standard deviation > 0.03
model_average_date %>%
  ggplot(aes(x = forecast_date, y = mean_weight,
             colour = model, fill = model)) +
  geom_point() +
  geom_line() +
  gghighlight::gghighlight(sd(mean_weight) > 0.03,
                           use_group_by = TRUE,
                           calculate_per_facet = TRUE,
                           use_direct_label = FALSE) +
  facet_grid(rows = vars(target_variable),
             cols = vars(ensemble)) +
  labs(x = NULL, y = "Model weight") +
  theme_bw() +
  theme(legend.position = "bottom")


# Difference between simple and weighted mean over time ---------------------

# Ignoring weights by horizon
weights_diff <- weights_wide %>%
  filter(horizon == "All") %>%
  mutate(diff_mean = relative_skill_weighted_mean - mean,
         diff_median = relative_skill_weighted_median - median) %>%
  select(model, target_variable, location_name,
         forecast_date,
         mean, median, diff_mean, diff_median)
  
weights_diff %>%
  ggplot(aes()) +
  facet_wrap(~ target_variable)


# plot --------------------------------------------------------------------

# Show weights by country
weights %>%
  filter(target_variable == "Cases" &
           !location == "Overall") %>%
  ggplot(aes(x = forecast_date, y = weight, 
             fill = model, colour = model)) +
  geom_col() +
  facet_grid(rows = vars(location),
             cols = vars(ensemble),
             scales = "free") +
  theme(legend.position = "bottom")



# questions:
# do weights change more over time or by location?
# how much do weights differ by model?











