# Format forecasts for evaluation and calculate absolute error 
#   - as an example of how to calculate any of the eval scores (as calculated 
#   in: code/reports/rmdchunks/score-forecasts.Rmd)
#   
library(covidHubUtils)
library(scoringutils)
library(dplyr)
library(lubridate)

# Set up ------------------------------------------------------------------
# - a simplified version of code/reports/rmdchunks/load-data.Rmd
# 
# get raw forecasts
source(here("code", "papers", "forecast-eval", "get-forecasts.R"))

# set up
last_forecast_date <- report_date - 7
restrict_weeks <- 4
quantiles <- c(0.010, 0.025, 0.050, 0.100, 0.150, 0.200,
               0.250, 0.300, 0.350, 0.400, 0.450, 0.500,
               0.550, 0.600, 0.650, 0.700, 0.750, 0.800,
               0.850, 0.900, 0.950, 0.975, 0.990)

# truth data
raw_truth <- load_truth(truth_source = "JHU",
                        temporal_resolution = "week", 
                        hub = "ECDC", 
                        data_location = "local_hub_repo", 
                        local_repo_path = here()) 

# get anomalies
anomalies <- read_csv(here("data-truth", "anomalies", "anomalies.csv"))

truth <- anti_join(raw_truth, anomalies) %>%
  mutate(model = NULL) %>%
  rename(true_value = value)

# remove forecasts made directly after a data anomaly
score_df <- raw_forecasts %>%
  mutate(previous_end_date = forecast_date - 2) %>%
  left_join(anomalies %>%
              rename(previous_end_date = target_end_date),
            by = c("target_variable",
                   "location", "location_name",
                   "previous_end_date")) %>%
  filter(is.na(anomaly)) %>%
  select(-anomaly, -previous_end_date)

score_df <- left_join(score_df, 
                      truth,
                      join = "full",
                      by = c("target_end_date", "location", "location_name",
                             "target_variable", "population")) 
# continuous weeks of submission
cont_weeks <- score_df %>%
  group_by(forecast_date, model, location, target_variable, horizon) %>%
  summarise(present = 1, .groups = "drop") %>%
  complete(model, location, target_variable, horizon, forecast_date) %>%
  filter(forecast_date <= report_date - 7 * as.integer(horizon)) %>%
  group_by(model, location, target_variable, horizon) %>%
  mutate(continuous_weeks = cumsum(rev(present))) %>%
  filter(!is.na(continuous_weeks)) %>%
  summarise(continuous_weeks = max(continuous_weeks), .groups = "drop")

score_df <- score_df %>%
  left_join(cont_weeks, by = c(
    "model", "target_variable", "horizon",
    "location"
  )) %>%
  replace_na(list(continuous_weeks = 0)) %>%
  filter(continuous_weeks >= restrict_weeks) %>%
  select(-continuous_weeks)


# Score relative and mean absolute error ----------------------------------
# - a simplified version of code/reports/rmdchunks/score-forecasts.Rmd
# - uses raw_forecasts i.e. all available forecasts except around anomalies

rel_ae <- score_df %>%
  filter(type == "point", !is.na(true_value)) %>%
  mutate(quantile = NA_real_) %>% ## scoringutils interprets these as point forecasts
  eval_forecasts(
    summarise_by = c(
      "model", "target_variable",
      "horizon", "location"
    ),
    compute_relative_skill = TRUE,
    baseline = "EuroCOVIDhub-baseline",
    rel_skill_metric = "ae_point"
  ) %>%
  select(model, target_variable, horizon, location, rel_ae = scaled_rel_skill,
         ae_point) %>%
  mutate(across(rel_ae:ae_point, round, digits = 2))

# clean environment
del <- ls()
keep <- c("score_df", "rel_ae")
rm(list = del[!del %in% keep])
rm(del, keep)
