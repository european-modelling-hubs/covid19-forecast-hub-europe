#' Score models
#'
#' @importFrom dplyr group_by mutate ungroup filter select bind_rows count summarise left_join right_join
#' @importFrom tidyr pivot_wider complete replace_na
#' @importFrom scoringutils eval_forecasts
#'
#' @export
score_models <- function(data, report_date, restrict_weeks) {

  last_forecast_date <- report_date - 7

  score_data <- data[forecast_date <= last_forecast_date &
                       target_end_date <= report_date]

  ## for overall, if more than 1 location exists, filter to have at least half
  ## of them
  overall_df <- score_data %>%
    group_by(model, target_variable) %>%
    mutate(n = length(unique(location))) %>%
    ungroup() %>%
    mutate(nall = length(unique(location))) %>%
    filter(n >= nall / 2) %>%
    select(-n, -nall) %>%
    mutate(location = "Overall")

  df <- score_data %>%
    bind_rows(overall_df)

  coverage <- df %>%
    filter(type != "point") %>%
    eval_forecasts(
      summarise_by = c("model", "target_variable", "range", "horizon",
                       "location"),
      # FIXME: we only care about coverage but we have to compute
      # "interval_score" first for this to work.
      # See https://github.com/epiforecasts/scoringutils/issues/111
      metrics = c("interval_score", "coverage"),
      compute_relative_skill = FALSE
    ) %>%
    filter(range %in% c(50, 95)) %>%
    select(model, target_variable, horizon, location, coverage,
           range) %>%
    pivot_wider(
      names_from = range, values_from = coverage,
      names_prefix = "cov_"
    )

  ## number of forecasts
  num_fc <- df %>%
    filter(type == "point", !is.na(true_value)) %>%
    count(model, target_variable, horizon, location)

  ## mean absolute error of point forecast
  mae <- df %>%
    filter(type == "point", !is.na(true_value)) %>%
    mutate(ae = abs(prediction - true_value)) %>%
    group_by(model, target_variable, location, horizon) %>%
    summarise(mae = mean(ae), .groups = "drop")

  ## continuous weeks of submission
  cont_weeks <- df %>%
    filter(!is.na(model)) %>%
    group_by(forecast_date, model, location, target_variable, horizon) %>%
    summarise(present = 1, .groups = "drop") %>%
    complete(model, location, target_variable, horizon, forecast_date) %>%
    group_by(model, location, target_variable, horizon) %>%
    mutate(continuous_weeks = cumsum(rev(present))) %>%
    filter(!is.na(continuous_weeks)) %>%
    summarise(continuous_weeks = max(continuous_weeks), .groups = "drop")

  table <- df %>%
    filter(type != "point") %>%
    eval_forecasts(
      summarise_by = c(
        "model", "target_variable",
        "horizon", "location"
      ),
      compute_relative_skill = TRUE,
      baseline = "EuroCOVIDhub-baseline"
    ) %>%
    left_join(coverage, by = c(
      "model", "target_variable", "horizon",
      "location"
    )) %>%
    right_join(mae, by = c(
      "model", "target_variable", "horizon",
      "location"
    )) %>%
    left_join(num_fc, by = c(
      "model", "target_variable", "horizon",
      "location"
    )) %>%
    left_join(cont_weeks, by = c(
      "model", "target_variable", "horizon",
      "location"
    )) %>%
    replace_na(list(continuous_weeks = 0))

  return(table)
}
