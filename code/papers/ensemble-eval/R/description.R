# Description, formatted for use in results text
source(here::here("code", "papers", "ensemble-eval", "R", "get-eval.R"))

# some formatting functions
format_percent <- function(numerator, denominator, round_to = 0) {
  round(numerator / denominator * 100, round_to)
}

# Dataset description -----------------------------------------------------
# Number of ensemble method, horizon, target, and location combinations
n_ensembles <- length(unique(eval_ensemble$ensemble_name))
n_horizons <- length(unique(eval_ensemble$horizon))
n_target_vars <- length(unique(eval_ensemble$target_variable))
n_locations <- length(unique(eval_ensemble$location))

n_targets <- nrow(eval_ensemble) # because some removed for data anomalies
n_removed <- (n_locations * n_ensembles * n_horizons * n_target_vars) - n_targets

# WIS performance rel to baseline -----------------------------------------
# Number of ensembles that perform worse, the same as, or better than the baseline
rwis_sum <- eval_ensemble %>%
  mutate(weight_horizon = ifelse(grepl("by_horizon", ensemble), 
                                 "By horizon", "All horizons")) %>%
  group_by(target_variable, horizon, ensemble, ensemble_type, weight_horizon) %>%
  summarise(
    n_worse_or_same = sum(rel_wis >= 1),
    n_better = sum(rel_wis < 1),
    n_total = n()
  )

# overall
overall_worse_same_pc <- format_percent(sum(rwis_sum$n_worse_or_same), n_targets)

# Summarise by variable
summarise_performance <- function(var, category) {
  data <- rwis_sum %>%
    filter(.data[[var]] == category)
  summary <- list(
    worse_or_same = data %>% pull(n_worse_or_same) %>% sum(), 
    total = data %>% pull(n_total) %>% sum())
  summary$worse_or_same_pc = format_percent(summary$worse_or_same, summary$total)
  return(summary)
}

# by target
by_target <- map(unique(rwis_sum$target_variable), 
                    ~ summarise_performance(var = "target_variable",
                                            category = .x))
names(by_target) <- unique(rwis_sum$target_variable)

# by horizon
by_horizon <- map(unique(rwis_sum$horizon), 
                  ~ summarise_performance(var = "horizon",
                                               category = .x))
names(by_horizon) <- paste0("h", unique(rwis_sum$horizon))

# by ensemble
by_ensemble <- map(unique(rwis_sum$ensemble), 
                    ~ summarise_performance(var = "ensemble",
                                            category = .x))
names(by_ensemble) <- unique(rwis_sum$ensemble)

# by ensemble type
by_ensemble_type <- map(unique(rwis_sum$ensemble_type), 
                   ~ summarise_performance(var = "ensemble_type",
                                           category = .x))
names(by_ensemble_type) <- unique(rwis_sum$ensemble_type)

by_ensemble <- by_ensemble %>%
  bind_rows(.id = "ensemble")
