# Get evaluation dataset
library(here)
library(purrr)
library(readr)
library(dplyr)
library(ggplot2)
library(covidHubUtils)

figure_path <- here("code", "exploratory", "/")

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
  left_join(read_csv(here("code", "exploratory", "model-abbr-3.csv")), 
            by = "model") %>%
  select(model_abbr = abbr, everything()) %>%
  filter(!model %in% filter(model_desig, designation == "other")$model)

h2_eval <- filter(eval, horizon == 2)
