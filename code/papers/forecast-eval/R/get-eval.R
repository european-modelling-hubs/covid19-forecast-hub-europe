# Get evaluation dataset
library(here)
library(purrr)
library(readr)
library(dplyr)
library(tidyr)
library(ggplot2)
library(covidHubUtils)

# path to this folder of main hub repo - for saving figures
file_path <- here("code", "papers", "forecast-eval", "/")

# get model designations - in order to remove "other" except baseline
source(here("code", "ensemble", "utils", "get_model_designations.r"))
model_desig <- get_model_designations(here()) %>%
  mutate(designation = case_when(model == "EuroCOVIDhub-baseline" ~ "secondary",
                                 TRUE ~ designation))

# Find latest evaluation
eval_date <- dir(here("evaluation"))
eval_date <- as.Date(gsub("(evaluation-)|(\\.csv)", "", eval_date))
eval_date <- eval_date[length(eval_date)]

# clean variable names
clean_variables <- c("inc case" = "Cases", "inc death" = "Deaths")

# Get evaluation
eval <- read_csv(here("evaluation", 
                      paste0("evaluation-", eval_date, ".csv"))) %>%
  # keep only 1-4 horizons
  filter(horizon <= 4) %>%
  # clean up team-model names
  separate(model, into = c("team_name", "model_name"), 
           sep = "-", remove = FALSE) %>%  
  mutate(
    # add neat variables for plots
    target_variable_neat = recode(target_variable, !!!clean_variables),
    # ensure scores are numeric
    across(interval_score:n, as.numeric)) %>%
  # add 3 letter model abbreviation
  left_join(read_csv(paste0(file_path, "/data/model-abbr-3.csv")), by = "model") %>%
  select(model_abbr = abbr, everything()) %>%
  # remove models designated "other"
  filter(!model %in% filter(model_desig, designation == "other")$model)

eval_all_locs <- eval %>%
  filter(location != "Overall") 

rm(model_desig, get_model_designations)
   