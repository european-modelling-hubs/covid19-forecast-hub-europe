# Get evaluation dataset
library(here)
library(purrr)
library(readr)
library(dplyr)
library(tidyr)
library(ggplot2)
library(covidHubUtils)
library(EuroForecastHub)

# path to this folder of main hub repo - for saving figures
file_path <- here("code", "papers", "forecast-eval", "/")

# get model designations - in order to remove "other" except baseline
model_desig <- EuroForecastHub::get_model_designations(hub_repo_path = here()) %>%
  mutate(designation = case_when(model == "EuroCOVIDhub-baseline" ~ "secondary",
                                 TRUE ~ designation))

# Find latest evaluation
# eval_date <- dir(here("evaluation"))
# eval_date <- as.Date(gsub("(evaluation-)|(\\.csv)", "", eval_date))
# eval_date <- eval_date[length(eval_date)]
# eval_file <- here("evaluation", paste0("evaluation-", eval_date, ".csv"))

# or use freshly run evaluation saved in /data folder:
eval_file <- here("code", "papers", "forecast-eval", "data", "2021-08-23-evaluation-all-forecasts.csv")

# clean variable names
clean_variables <- c("inc case" = "Cases", "inc death" = "Deaths")

# Get evaluation and tidy up
eval <- read_csv(eval_file) %>%
  # keep only 1-4 horizons
  filter(horizon <= 4) %>%
  # clean up team-model names
  separate(model, into = c("team_name", "model_name"), 
           sep = "-", remove = FALSE) %>%  
  mutate(
    # add neat variables, esp useful for plots
    target_variable = recode(target_variable, !!!clean_variables),
    # ensure scores are numeric
    across(c(horizon, interval_score:n), as.numeric)) %>%
  # add 3 letter model abbreviation
  left_join(read_csv(paste0(file_path, "/data/model-abbr-3.csv")), by = "model") %>%
  select(model_abbr = abbr, everything()) %>%
  # remove models designated "other"
  filter(!model %in% filter(model_desig, designation == "other")$model)

# Where no interval score, using mean AE in place of mean WIS
eval <- eval %>%
  mutate(model_score = case_when(is.na(interval_score) ~ ae,
                              TRUE ~ interval_score),
         model_score_source = case_when(is.na(interval_score) ~ "AE",
                                TRUE ~ "Interval"),
         # model as alphabetical ordered factor for plotting
         model = factor(model, ordered = TRUE))

# separate out baseline and ensemble as comparators
score_base <- eval %>%
  filter(grepl("hub-baseline", model)) %>%
  select(baseline_score = interval_score,
         target_variable, horizon, location)

score_ensemble <- eval %>%
  filter(grepl("hub-ensemble", model)) %>%
  select(ensemble_score = interval_score,
         target_variable, horizon, location)

eval_wide <- eval %>%
  filter(!grepl("hub-baseline", model)) %>% # leave ensemble as row as well as col
  full_join(score_base) %>%
  full_join(score_ensemble)

###
rm(model_desig, clean_variables,
   score_base, score_ensemble)
   