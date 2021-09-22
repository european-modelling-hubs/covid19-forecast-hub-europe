library(here)
library(readr)
library(dplyr)
library(tidyr)

# Set up ------------------------------------------------------------------
max_date <- "2021-08-23"

# set path to this folder of main hub repo 
file_path_ensemble <- here("code", "papers", "ensemble-eval", "/")

# If not already, run evaluation on all ensemble files:
# source(here(file_path_ensemble, "R", "re-run-eval.R"))

# Get evaluation dataset --------------------------------------------------
# use freshly run evaluation saved in /data folder:
eval_ensemble <- here(file_path_ensemble, "data", 
                           paste0(max_date, "-evaluation-all-ensembles.csv"))
eval_ensemble <- read_csv(eval_ensemble)

# Prep dataset ------------------------------------------------------------
# neater categorical variable names
clean_variable_names <- c("inc case" = "Cases", "inc death" = "Deaths")
clean_ensemble_names <- c(
  "mean" = "Mean",
  "relative_skill_weighted_mean" = "Weighted mean",
  "relative_skill_weighted_mean_by_horizon" = "Weighted mean by horizon",
  "median" = "Median",
  "relative_skill_weighted_median" = "Weighted median",
  "relative_skill_weighted_median_by_horizon" = "Weighted median by horizon"
)
clean_ensemble_type <- c(
  "mean" = "Mean",
  "relative_skill_weighted_mean" = "Mean",
  "relative_skill_weighted_mean_by_horizon" = "Mean",
  "median" = "Median",
  "relative_skill_weighted_median" = "Median",
  "relative_skill_weighted_median_by_horizon" = "Median"
)


# Tidy up
eval_ensemble <- eval_ensemble %>%
  # keep only 1-4 horizons
  filter(horizon <= 4) %>%
  # clean up team-model names
  separate(model, into = c("team_name", "model_name"), 
           sep = "-", remove = FALSE) %>%  
  mutate(
    target_variable = recode(target_variable, !!!clean_variable_names),
    ensemble_type = recode(model_name, !!!clean_ensemble_type),
    ensemble_name = recode(model_name, !!!clean_ensemble_names),
    # ensure scores are numeric
    across(c(horizon, interval_score:n), as.numeric),
    # set horizon as ordered factor
    horizon = factor(horizon, ordered = TRUE)) %>%
  select(ensemble = model_name, ensemble_name, ensemble_type,
         location, location_name, target_variable, horizon,
         n, rel_wis, cov_50, cov_95) %>%
  filter(!location %in% "Overall" &
           ensemble != "baseline")
