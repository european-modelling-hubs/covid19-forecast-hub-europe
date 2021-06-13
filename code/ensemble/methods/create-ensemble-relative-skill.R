# Ensemble by relative skill
#
# Ensemble = sum of forecast values weighted by the inverse of relative skill
# Weights are by model, horizon, target, location
# i.e. not weighted by quantile
#'
#' @param forecasts forecasting models used for ensemble
#' @param forecast_date date with saved evaluation csv of forecasts
#' @param continuous_weeks include only forecasts with a history of evaluation
#' @param by_horizon weight using relative skill by horizon, rather than average

library(dplyr)
library(cNORM)

## helper functions
weighted_mean <- function(x, weights) {
  return(sum(x * weights) / sum(weights))
}

weighted_median <- function(x, weights) {
  return(cNORM::weighted.quantile(x, probs = 0.5, weights = weights))
}

weighted_average <- function(..., average = "mean") {
  if (average == "mean") {
    return(weighted_mean(...))
  } else if (average == "median") {
    return(weighted_median(...))
  } else {
    stop("Unknown average: ", average)
  }
}

create_ensemble_relative_skill <- function(forecasts,
                                           evaluation_date,
                                           continuous_weeks = 4,
                                           average = "mean",
                                           by_horizon = FALSE,
                                           return_criteria = FALSE,
                                           verbose = FALSE) {

# Get evaluation ----------------------------------------------------------
  evaluation <- try(suppressMessages(
    vroom(here("evaluation", paste0("evaluation-", evaluation_date, ".csv")))))
  # evaluation error catching
  if ("try-error" %in% class(evaluation)) {
    stop(paste0("Evaluation not found for ", evaluation_date))
  }
  if (verbose) {message(paste0("Relative skill evaluation as of ",
                               evaluation_date))}
  if (!"relative_skill" %in% names(evaluation)) {
    stop("Evaluation does not include relative skill")
  }

  # include only models with forecasts,
  #   with evaluation for >= x weeks
  skill <- evaluation %>%
    select(model, continuous_weeks, target_variable,
           horizon, location, relative_skill) %>%
    filter(model %in% forecasts$model &
             continuous_weeks >= !!continuous_weeks &
             !is.na(relative_skill))

  # Average skill over all horizons (default)
  if (!by_horizon) {
    skill <- skill %>%
      group_by(model, location, target_variable) %>%
      summarise(relative_skill = mean(relative_skill, na.rm = TRUE),
                .groups = "drop")
  }

# Find weights ---------------------------------------------
  # Take inverse of relative skill
  skill <- skill %>%
    mutate(inv_skill = ifelse(relative_skill > 0,
                              1/relative_skill, 0))

  # Weights for each model, by location, target (and horizon)
  groups <- c("target_variable", "location")
  if (by_horizon) {
    groups <- c(groups, "horizon")
  }

  weights <- skill %>%
    group_by(across(all_of(groups))) %>%
    mutate(sum_inv_skill = sum(inv_skill, na.rm = TRUE),
           weight = inv_skill / sum_inv_skill) %>%
    select_at(c("model", groups, "weight"))

  if (verbose) {message(paste0("Included ",
                               length(unique(weights$model)), " models"))}

# Sum weights for ensemble ------------------------------------------------
  join <- c(groups, "model")
  forecast_skill <- left_join(forecasts, weights, by = join) %>%
    filter(!is.na(weight))

  # Take sum of weighted values
  weighted_ensemble <- forecast_skill %>%
    group_by(quantile, target_variable, location, horizon) %>%
    summarise(value = weighted_average(x = value, weights = weight,
                                       average = average),
              n_models = n(),
              .groups = "drop")

  if (return_criteria) {
    return(list("weights" = weights,
                "ensemble" = weighted_ensemble))
  }

  return(weighted_ensemble)
}
