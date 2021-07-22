#' Score models
#'
#' @inheritParams create_ensemble_average
#' @param report_date Date at which the scoring takes place
#'
#' @importFrom dplyr group_by mutate ungroup filter select bind_rows count summarise left_join right_join select across if_else n_distinct
#' @importFrom tidyr pivot_wider complete replace_na
#' @importFrom lubridate weeks
#' @importFrom scoringutils eval_forecasts
#'
#' @export
score_models <- function(forecasts, report_date) {

  last_forecast_date <- report_date - 7

  locations <- forecasts %>%
    select(location, location_name) %>%
    unique()

  ## extract data to be scored and set number of locations to one as default (see next command)
  score_data <- forecasts %>%
    filter(forecast_date <= last_forecast_date,
           target_end_date <= report_date)

  ## duplicate country data as overall data
  score_df <- score_data %>%
    mutate(location = "Overall") %>%
    bind_rows(score_data)

  num_loc <- score_df %>%
    group_by(model, location, target_variable, horizon) %>%
    summarise(n_loc = n_distinct(location_name), .groups = "drop")

  ## for overall, if more than 1 location exists, filter to have at least half
  ## of them
  score_df <- num_loc %>%
    filter(location != "Overall" | n_loc >= n_distinct(location_name) / 2)

  ## continuous weeks of submission
  cont_weeks <- score_df %>%
    group_by(forecast_date, model, location, target_variable, horizon) %>%
    summarise(present = 1, .groups = "drop") %>%
    complete(model, location, target_variable, horizon, forecast_date) %>%
    filter(forecast_date <= report_date - weeks(horizon)) %>%
    group_by(model, location, target_variable, horizon) %>%
    mutate(continuous_weeks = cumsum(rev(present))) %>%
    filter(!is.na(continuous_weeks)) %>%
    summarise(continuous_weeks = max(continuous_weeks), .groups = "drop")

  score_df <- score_df %>%
    left_join(cont_weeks, by = c(
      "model", "target_variable", "horizon",
      "location"
    )) %>%
    replace_na(list(continuous_weeks = 0)) %>%
    filter(continuous_weeks >= restrict_weeks)

  ## number of forecasts
  num_fc <- score_df %>%
    filter(type == "point", !is.na(true_value)) %>%
    count(model, target_variable, horizon, location)

  ## calibration metrics (50 and 95 percent coverage and bias)
  coverage <- score_df %>%
    filter(type != "point") %>%
    eval_forecasts(
      summarise_by = c("model", "target_variable", "range", "horizon",
                       "location"),
      metrics = "coverage",
      compute_relative_skill = FALSE
    ) %>%
    filter(range %in% c(50, 95)) %>%
    select(model, target_variable, horizon, location, coverage,
           range) %>%
    pivot_wider(
      names_from = range, values_from = coverage,
      names_prefix = "cov_"
    )

  bias <- score_df %>%
    filter(type != "point") %>%
    eval_forecasts(
      summarise_by = c("model", "target_variable", "horizon", "location"),
      metrics = "bias",
      compute_relative_skill = FALSE
    ) %>%
    select(model, target_variable, horizon, location, bias)

  ## relative absolute error of point forecast
  rel_ae <- score_df %>%
    filter(type == "point", !is.na(true_value)) %>%
    mutate(quantile = NA_real_) %>% ## scoringutils interprets these as point forecasts
    eval_forecasts(
      summarise_by = c(
        "model", "target_variable",
        "horizon", "location"
      ),
      compute_relative_skill = TRUE,
      baseline = "EuroCOVIDhub-baseline",
      rel_skill_metric = "ae_point"
    ) %>%
    select(model, target_variable, horizon, location, rel_ae = scaled_rel_skill)

  ## for calculating WIS and bias, make sure all quantiles are there
  score_df <- score_df %>%
    group_by(location, target_variable, target_end_date, model, horizon) %>%
    mutate(all_quantiles_present =
             (length(setdiff(quantiles, quantile)) == 0)) %>%
    ungroup() %>%
    filter(all_quantiles_present == TRUE) %>%
    select(-all_quantiles_present)

  table <- score_df %>%
    filter(type != "point") %>%
    eval_forecasts(
      summarise_by = c(
        "model", "target_variable",
        "horizon", "location"
      ),
      metrics = "interval_score",
      compute_relative_skill = TRUE,
      baseline = "EuroCOVIDhub-baseline"
    ) %>%
    select(-relative_skill) %>%
    rename(rel_wis = scaled_rel_skill) %>%
    full_join(rel_ae, by = c(
      "model", "target_variable", "horizon",
      "location"
    )) %>%
    full_join(coverage, by = c(
      "model", "target_variable", "horizon",
      "location"
    )) %>%
    full_join(bias, by = c(
      "model", "target_variable", "horizon",
      "location"
    )) %>%
    left_join(num_loc, by = c(
      "model", "target_variable", "horizon",
      "location"
    )) %>%
    left_join(num_fc, by = c(
      "model", "target_variable", "horizon",
      "location"
    )) %>%
    left_join(locations, by = "location") %>%
    mutate(location_name =
             if_else(location == "Overall", "Overall", location_name)) %>%
    mutate(across(c("interval_score", "sharpness",
                    "underprediction", "overprediction"), round)) %>%
    mutate(across(c("bias", "rel_wis", "rel_ae", "cov_50", "cov_95"), round, 2))

  return(table)
}
