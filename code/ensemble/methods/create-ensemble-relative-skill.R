# Ensemble by relative skill
#
# Ensemble = sum of forecast values weighted by the inverse of relative skill
# Weights are by model, horizon, target, location
# i.e. not weighted by quantile
#'
#' @param forecasts forecasting models used for ensemble
#' @param forecast_date date with saved evaluation csv of forecasts
#' @param continuous_weeks include only forecasts with a history of evaluation

library(dplyr)

create_ensemble_relative_skill <- function(forecasts,
                                           evaluation_date,
                                           continuous_weeks = 4,
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

# Find weights ---------------------------------------------
  # Take inverse of relative skill
  skill <- skill %>%
    mutate(inv_skill = ifelse(relative_skill > 0,
                              1/relative_skill, 0))

  # Weights for each model, horizon, location, target
  skill <- skill %>%
    group_by(target_variable, location, horizon) %>%
    mutate(skill_weight = inv_skill / sum(inv_skill))

  if (verbose) {message(paste0("Included ",
                               length(unique(skill$model)), " models"))}


# Sum weights for ensemble ------------------------------------------------
  # Join weights to each forecast
  forecast_skill <- left_join(forecasts, skill,
                              by = c("model", "target_variable",
                                     "location", "horizon")) %>%
    filter(!is.na(skill_weight)) %>%
    mutate(weighted_value = value * skill_weight)

  # Take sum of weighted values
  weighted_ensemble <- forecast_skill %>%
    group_by(quantile, target_variable, location, horizon) %>%
    summarise(value = sum(weighted_value, na.rm = TRUE),
              n_models = n(),
              .groups = "drop")

  if (return_criteria) {
    return(list("weights" = skill,
                "ensemble" = weighted_ensemble))
  }

  return(weighted_ensemble)
  }
