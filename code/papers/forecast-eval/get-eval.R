# Get evaluation dataset
library(here)
library(purrr)
library(readr)
library(dplyr)
library(tidyr)
library(ggplot2)
library(covidHubUtils)

file_path <- here("code", "papers", "forecast-eval", "/")

# model designations
source(here("code", "ensemble", "utils", "get_model_designations.r"))
model_desig <- get_model_designations(here()) %>%
  mutate(designation = case_when(model == "EuroCOVIDhub-baseline" ~ "secondary",
                                 TRUE ~ designation))

# Find latest evaluation
eval_date <- dir(here("evaluation"))
eval_date <- as.Date(gsub("(evaluation-)|(\\.csv)", "", eval_date))
eval_date <- eval_date[length(eval_date)]

# Get evaluation
eval <- read_csv(here("evaluation", 
                      paste0("evaluation-", eval_date, ".csv"))) %>%
  filter(horizon <= 4) %>%
  separate(model, into = c("team_name", "model_name"), sep = "-", remove = FALSE) %>%  
  mutate(target_variable_neat = recode(target_variable,
                                       "inc case" = "Cases",
                                       "inc death" = "Deaths")) %>%
  left_join(read_csv(paste0(file_path, "model-abbr-3.csv")), 
            by = "model") %>%
  select(model_abbr = abbr, everything()) %>%
  filter(!model %in% filter(model_desig, designation == "other")$model)

h1_eval <- filter(eval, horizon == 1)
h1h2_eval <- filter(eval, horizon %in% c(1,2))
