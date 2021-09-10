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
file_path <- here("code", "papers", "ensemble-eval", "/")

# use freshly run evaluation saved in /data folder:
eval_file <- here("code", "papers", "ensemble-eval", "data", "2021-08-23-evaluation-all-ensembles.csv")

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
    across(c(horizon, interval_score:n), as.numeric))


# separate out baseline as comparator
score_base <- eval %>%
  filter(grepl("hub-baseline", model)) %>%
  select(baseline_score = interval_score,
         baseline_rel_wis = rel_wis,
         baseline_rel_ae = rel_ae,
         target_variable, horizon, location)

eval_wide <- eval %>%
  filter(!grepl("hub-baseline", model)) %>%
  full_join(score_base)

###
rm(clean_variables,
   score_base, score_ensemble)
   