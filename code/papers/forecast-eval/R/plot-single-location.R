# Plot forecasts against truth
library(here)
library(dplyr)
library(ggplot2)

# Set up ------------------------------------------------------------------
file_path <- here("code", "papers", "forecast-eval")
report_date <- as.Date("2021-08-23")
last_forecast_date <- report_date - 7
restrict_weeks <- 4
quantiles <- c(0.010, 0.025, 0.050, 0.100, 0.150, 0.200,
               0.250, 0.300, 0.350, 0.400, 0.450, 0.500,
               0.550, 0.600, 0.650, 0.700, 0.750, 0.800,
               0.850, 0.900, 0.950, 0.975, 0.990)

# re-run-eval.R up to line 61
# or load saved version of this dataset
# data <- readr::read_csv(here(file_path, "data", "all-scoring-data.csv"))
# 
# get model designations - in order to remove "other" except baseline
model_desig <- EuroForecastHub::get_model_designations(hub_repo_path = here()) %>%
  mutate(designation = case_when(model == "EuroCOVIDhub-baseline" ~ "secondary",
                                 TRUE ~ designation))
score_df <- data %>%
  filter(forecast_date <= last_forecast_date,
         target_end_date <= report_date &
           !model %in% filter(model_desig, designation == "other")$model)


# Prepare data for plot ---------------------------------------------------
score_df_plot_data <- score_df %>%
  mutate(horizon = as.numeric(horizon),
         quantile = ifelse(type == "point", 0.5, quantile)) %>%
  filter(horizon == 1 &
           quantile %in% c(0.25, 0.5, 0.75)) %>%
  pivot_wider(names_from = quantile, values_from = prediction) %>%
  select(forecast_date, target_end_date, model,
         location, target_variable,
         true_value, low = `0.25`, mid = `0.5`, up = `0.75`) 

score_df_plot <- score_df_plot_data %>%
  ggplot(aes(x = target_end_date)) +
  geom_point(aes(y = mid, col = model, shape = model)) +
  geom_point(aes(y = mid, col = model)) +
  geom_linerange(aes(ymin = low, ymax = up, col = model),
                 lty = 3) +
  geom_line(aes(y = true_value), size = 1) +
  scico::scale_colour_scico_d(palette = "roma") +
  scale_y_continuous(labels = scales::label_comma()) +
  labs(y = "1 week ahead forecasts and observed values",
       x = NULL,
       colour = "Forecast model",
       shape = "Forecast model") +
  theme_bw() +
  theme(legend.position = "left") 

# FR 
score_df_plot_data_fr <- score_df_plot$data %>%
  filter(location == "FR" & 
           target_variable == "inc case") %>%
  # join ensemble and baseline as separate cols for plotting
  left_join(score_df_plot_data_fr %>%
                  filter(grepl("EuroCOVIDhub-ensemble", model)) %>%
                  select(target_end_date, hub_ensemble = mid),
            by = "target_end_date") %>%
  left_join(score_df_plot_data_fr %>%
              filter(grepl("EuroCOVIDhub-baseline", model)) %>%
              select(target_end_date, hub_baseline = mid),
            by = "target_end_date") %>%
  filter(!grepl("EuroCOVIDhub", model)) %>%
  # set to NA any forecast without a true baseline
  mutate(hub_baseline = ifelse(is.na(true_value), NA, hub_baseline),
         hub_ensemble = ifelse(is.na(true_value), NA, hub_ensemble),
         mid = ifelse(is.na(true_value), NA, mid),
         low = ifelse(is.na(true_value), NA, low),
         up = ifelse(is.na(true_value), NA, up))
    
score_df_plot_fr <- score_df_plot
score_df_plot_fr$data <- score_df_plot_data_fr
score_df_plot_fr +
  geom_line(aes(y = hub_ensemble), col = "red", lty = 2) +
  geom_line(aes(y = hub_baseline), col = "blue", lty = 2)

ggsave(filename = paste0(file_path, "/figures/", Sys.Date(), "-forecast-v-true_france.png"),
       plot = score_df_plot_fr,
       height = 5, width = 8)

# Caption:
# 1 week ahead forecasts for weekly incident cases in France.
# Forecasts and data excluded around a data anomaly (-350,000 cases reported) in May.
# Black represents observed value. Dotted lines represent 25% and 75% quantile predictions
# for those models that provided them










