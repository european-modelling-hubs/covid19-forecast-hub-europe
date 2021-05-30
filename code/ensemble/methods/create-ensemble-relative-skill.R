# Ensemble by relative skill

# Ensemble is the sum of forecast values weighted by the inverse of relative skill
# Weights are by model, horizon, target, location
# i.e. not weighted by quantile

# args:
# forecasts forecasting models used for ensemble
# forecast_date date with saved evaluation csv of forecasts

create_ensemble_relative_skill <- function(forecasts,
                                           evaluation,
                                           continous_weeks = 4) {

  # include only models in forecasts and with forecasts for >= x weeks
  skill <- evaluation %>%
    select(model, continuous_weeks, target_variable,
           horizon, location, relative_skill) %>%
    filter(model %in% forecasts$model &
             continuous_weeks >= !!continuous_weeks)

  # Take inverse of relative skill
  skill <- skill %>%
    mutate(inv_skill = (1/relative_skill))

  # Weights for each model, horizon, location, target
  skill <- skill %>%
    group_by(target_variable, location, horizon) %>%
    mutate(skill_weight = inv_skill / sum(inv_skill))


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
              n_models = n())

  return(weighted_ensemble)

  }
