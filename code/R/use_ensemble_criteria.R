#' Load models according to inclusion criteria before ensembling
#'
#' @inheritParams create_ensemble_average
#' @param exclude_models optional character vector to exclude over all dates,
#'   or data.frame with cols model and forecast_date, to exclude for specific
#'    dates
#' @param exclude_designated_other logical: whether to exclude models designated
#' as "other" in their metadata file (default `TRUE`)
#' @param return_criteria logical : whether to return a model/inclusion criteria
#' grid as well as the ensemble forecast (default `TRUE`)
#'
#' @return
#' - if `return_criteria = TRUE`, a list with the following elements
#'   * "ensemble" : tibble : a single ensemble forecast
#'   * "criteria": tibble : all candidate models against criteria
#'     for inclusion in ensemble (all locations and horizons)
#'   * "forecast_date" : date : latest date
#' - if `return_criteria = FALSE`, a tibble of a single ensemble forecast
#'
#' @details
#' Steps:
#' Currently, models included based on having:
#' 1. All quantiles
#' 2. 4 horizons
#' 3. Not manually specified for exclusion
#' 4. Not the hub ensemble
#'
#' @importFrom dplyr filter %>% group_by summarise mutate left_join select inner_join
#' @importFrom here here
#'
#' @export
use_ensemble_criteria <- function(forecasts,
                                  exclude_models = NULL,
                                  exclude_designated_other = TRUE,
                                  return_criteria = TRUE) {

  # Remove point forecasts
  forecasts <- filter(forecasts, type == "quantile")

  # 1. Identify models with all quantiles
  # TODO: get quantiles from config file
  quantiles <- round(c(0.01, 0.025, seq(0.05, 0.95, by = 0.05), 0.975, 0.99), 3)
  all_quantiles <- forecasts %>%
    # Check all quantiles per target/location
    group_by(model, target_variable, location, target_end_date) %>%
    summarise(all_quantiles_present =
                (length(setdiff(quantiles, quantile)) == 0),
              .groups = "drop") %>%
    # Check all quantiles at all horizons
    group_by(model, target_variable, location) %>%
    summarise(all_quantiles_all_horizons = all(all_quantiles_present),
              .groups = "drop")

  # 2. Identify models with 4 week forecasts
  # TODO: get horizons from config file
  horizons <- 1:4
  all_horizons <- forecasts %>%
    group_by(model, target_variable, location) %>%
    summarise(all_horizons =
                (length(setdiff(horizons, horizon)) == 0),
              .groups = "drop")
  forecasts <- forecasts %>%
    filter(horizon %in% horizons)

  # 3. Manually excluded forecasts
  criteria <- all_quantiles %>%
    left_join(all_horizons,
              by = c("model", "target_variable", "location")) %>%
    mutate(not_excluded_manually = !(model %in% exclude_models)) %>%
  # 4. Drop hub ensemble model
    filter(!grepl("EuroCOVIDhub-ensemble", model))

  # 5. Drop "other" designated models
  if (exclude_designated_other) {
    not_other <- get_model_designations(here()) %>%
      filter(designation != "other")
    criteria <- criteria %>%
      filter(model %in% not_other$model)
  }

  # Clarify inclusion and exclusion for all models by location/variable
  include <- filter(criteria,
                    all_quantiles_all_horizons &
                      all_horizons &
                      not_excluded_manually) %>%
    select(model, target_variable, location) %>%
    mutate(included_in_ensemble = TRUE)

  criteria <- left_join(criteria, include,
                        by = c("model", "target_variable", "location")) %>%
    mutate(included_in_ensemble = ifelse(is.na(included_in_ensemble),
                                         FALSE,
                                         included_in_ensemble))


  # Return
  forecasts <- inner_join(forecasts, include,
                          by = c("model", "target_variable", "location"))

  if (return_criteria) {
    return(list("forecasts" = forecasts,
                "criteria" = criteria))
  }

  return(forecasts)
}
