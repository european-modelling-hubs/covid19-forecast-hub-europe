# Run full evaluation sequence 
# - using all models with up to 4 weeks forecasts; 
# - optionally, without restriction to presence in latest week

library(here)
library(covidHubUtils)
library(scoringutils)
library(dplyr)
library(lubridate)
library(readr)
library(tidyr)
library(purrr)

# Set up ------------------------------------------------------------------
# copied from: code/reports/rmdchunks/load-data.Rmd

report_date <- as.Date("2021-08-23")
last_forecast_date <- report_date - 7
restrict_weeks <- 4
quantiles <- c(0.010, 0.025, 0.050, 0.100, 0.150, 0.200,
               0.250, 0.300, 0.350, 0.400, 0.450, 0.500,
               0.550, 0.600, 0.650, 0.700, 0.750, 0.800,
               0.850, 0.900, 0.950, 0.975, 0.990)

raw_forecasts <- load_forecasts(
  models = NULL,
  source = "local_hub_repo",
  hub_repo_path = here(),
  hub = "ECDC"
) %>%
  # set forecast date to corresponding submission date
  mutate(forecast_date = ceiling_date(forecast_date, "week", week_start = 2) - 1) %>%
  filter(between(forecast_date, ymd("2021-03-08"), ymd(report_date))) %>%
  rename(prediction = value)

raw_truth <- load_truth(
  truth_source = "JHU",
  temporal_resolution = "weekly",
  truth_end_date = report_date,
  hub = "ECDC"
)

# get anomalies
anomalies <- read_csv(here("data-truth", "anomalies", "anomalies.csv"))
truth <- anti_join(raw_truth, anomalies) %>%
  mutate(model = NULL) %>%
  rename(true_value = value)

# remove forecasts made directly after a data anomaly
forecasts <- raw_forecasts %>%
  mutate(previous_end_date = forecast_date - 2) %>%
  left_join(anomalies %>%
              rename(previous_end_date = target_end_date),
            by = c("target_variable",
                   "location", "location_name",
                   "previous_end_date")) %>%
  filter(is.na(anomaly)) %>%
  select(-anomaly, -previous_end_date)

data <- scoringutils::merge_pred_and_obs(forecasts, truth,
                                         join = "full")

# rm(forecasts, anomalies, truth, raw_truth, raw_forecasts)

# Set up scoring ------------------------------------------------------------
# - code/reports/rmdchunks/score-forecasts.Rmd

locations <- data %>%
  select(location, location_name) %>%
  unique()

## extract data to be scored and set number of locations to one as defulat (see next command)
score_data <- data %>%
  filter(forecast_date <= last_forecast_date,
         target_end_date <= report_date)

## duplicate country data as overall data
score_df <- score_data %>%
  mutate(location = "Overall") %>%
  bind_rows(score_data)

num_loc <- score_df %>%
  group_by(model, location, target_variable, horizon) %>%
  summarise(n_loc = length(unique(location_name)), .groups = "drop")

## for overall, if more than 1 location exists, filter to have at least half
## of them
score_df <- score_df %>%
  group_by(model, target_variable, location, horizon) %>%
  mutate(n = length(unique(location_name))) %>%
  ungroup() %>%
  mutate(nall = length(unique(location_name))) %>%
  filter(location != "Overall" | n >= nall / 2) %>%
  select(-n, -nall)

## continuous weeks of submission
### hub standard: model submitted in the last week with a history of at least x submissions
### - using cumsum() creates NAs along entire series if not present in latest week
### new alternative: any model with a history of at least x submissions
### - Using any model with 4+ weeks history adds 818 model/location/horizon/target combinations
cont_weeks <- score_df %>%
  group_by(forecast_date, model, location, target_variable, horizon) %>%
  summarise(present = 1, .groups = "drop") %>%
  complete(model, location, target_variable, horizon, forecast_date) %>%
  filter(forecast_date <= report_date - 7 * as.integer(horizon)) %>% 
  group_by(model, location, target_variable, horizon) %>%
  # mutate(continuous_weeks = cumsum(rev(present))) %>% # old: cumulative sum
  mutate(continuous_weeks = sum(present, na.rm = TRUE)) %>% # new: simple sum of all forecasts at any time
  # filter(!is.na(continuous_weeks)) %>% # NAs should not be present 
  summarise(continuous_weeks = max(continuous_weeks), .groups = "drop")

score_df <- score_df %>%
  left_join(cont_weeks, by = c(
    "model", "target_variable", "horizon",
    "location"
  )) %>%
  # replace_na(list(continuous_weeks = 0)) %>% # old - not needed
  filter(continuous_weeks >= restrict_weeks) %>%
  select(-continuous_weeks)


# Full scoring routine ----------------------------------------------------
# from: code/reports/rmdchunks/score-forecasts.Rmd

## number of forecasts
num_fc <- score_df %>%
  filter(type == "point", !is.na(true_value)) %>%
  count(model, target_variable, horizon, location)

## calibration metrics (50 and 95 percent coverage and bias)
coverage <- score_df %>%
  filter(type != "point") %>%
  eval_forecasts(
    summarise_by = c("model", "target_variable", "range", "horizon",
                     "location"),
    ## FIXME: we only care about coverage but we have to compute
    ## "interval_score" first for this to work.
    ## See https://github.com/epiforecasts/scoringutils/issues/111
    metrics = c("interval_score", "coverage"),
    compute_relative_skill = FALSE
  ) %>%
  filter(range %in% c(50, 95)) %>%
  select(model, target_variable, horizon, location, coverage,
         range) %>%
  pivot_wider(
    names_from = range, values_from = coverage,
    names_prefix = "cov_"
  )

bias <- score_df %>%
  filter(type != "point") %>%
  eval_forecasts(
    summarise_by = c("model", "target_variable", "horizon", "location"),
    ## FIXME: we only care about coverage but we have to compute
    ## "interval_score" first for this to work.
    ## See https://github.com/epiforecasts/scoringutils/issues/111
    metrics = c("interval_score", "bias"),
    compute_relative_skill = FALSE
  ) %>%
  select(model, target_variable, horizon, location, bias)

## relative absolute error of point forecast
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
  select(model, target_variable, horizon, location,
         ae = ae_point, rel_ae = scaled_rel_skill)

## for calculating WIS and bias, make sure all quantiles are there
score_df <- score_df %>%
  group_by(location, target_variable, target_end_date, model, horizon) %>%
  mutate(all_quantiles_present =
           (length(setdiff(quantiles, quantile)) == 0)) %>%
  ungroup() %>%
  filter(all_quantiles_present == TRUE) %>%
  select(-all_quantiles_present)

table <- score_df %>%
  filter(type != "point") %>%
  eval_forecasts(
    summarise_by = c(
      "model", "target_variable",
      "horizon", "location"
    ),
    metrics = "interval_score",
    compute_relative_skill = TRUE,
    baseline = "EuroCOVIDhub-baseline"
  ) %>%
  select(-relative_skill) %>%
  rename(rel_wis = scaled_rel_skill) %>%
  full_join(rel_ae, by = c(
    "model", "target_variable", "horizon",
    "location"
  )) %>%
  full_join(coverage, by = c(
    "model", "target_variable", "horizon",
    "location"
  )) %>%
  full_join(bias, by = c(
    "model", "target_variable", "horizon",
    "location"
  )) %>%
  left_join(num_loc, by = c(
    "model", "target_variable", "horizon",
    "location"
  )) %>%
  left_join(num_fc, by = c(
    "model", "target_variable", "horizon",
    "location"
  )) %>%
  left_join(locations, by = "location") %>%
  mutate(location_name =
           if_else(location == "Overall", "Overall", location_name)) %>%
  mutate(across(c("interval_score", "sharpness",
                  "underprediction", "overprediction", "ae"), round)) %>%
  mutate(across(c("bias", "rel_wis", "rel_ae", "cov_50", "cov_95"), round, 2))


# save --------------------------------------------------------------------
write_csv(table, here("code", "papers", "forecast-eval", "data", "2021-08-23-evaluation-all-forecasts.csv"))

# clean up ----------------------------------------------------------------
del <- ls()
keep <- c("score_df", "table")
rm(list = del[!del %in% keep])
rm(del, keep)
