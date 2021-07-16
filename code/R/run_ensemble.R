#' Run ensembling methods
#'
#' @param method name of ensembling method
#' @param forecast_date date or character
#' @inheritParams use_ensemble_criteria
#' @inheritParams create_ensemble_relative_skill
#' @param ... arguments passed to [create_ensemble_relative_skill()]
#'
#' @details
#' Used to create a single ensemble forecast.
#' Takes a forecast date and loads all forecasts for the preceding week, then:
#' Filters models according to criteria
#' Ensembles forecasts according to given method
#' Formats ensemble forecast
#' Returns ensemble forecast and optionally the criteria for inclusion
#'
#' @importFrom covidHubUtils load_forecasts
#' @importFrom dplyr %>% filter pull mutate group_by summarise if_else
#'
#' @export

run_ensemble <- function(method = "mean",
                         forecast_date,
                         exclude_models = NULL,
                         return_criteria = TRUE,
                         verbose = FALSE,
                         exclude_designated_other = TRUE,
                         ...) {

  # Method ------------------------------------------------------------------
  # Check method is supported
  methods <- sub("^.*-", "", dir(here("ensembles", "data-processed")))

  if (missing(method)) {
    method <- get_hub_config("ensemble_method")
  }
  method <- match.arg(arg = method,
                      choices = methods,
                      several.ok = FALSE)

  if (verbose) {message(paste0("Ensemble method: ", method))}

  # Dates ------------------------------------------------------------------
  # determine forecast dates matching the forecast date
  forecast_date <- as.Date(forecast_date)
  forecast_dates <- seq.Date(from = forecast_date,
                             by = -1,
                             length.out = 6)

  # Load forecasts and save criteria --------------------------------------------
  # Get all forecasts
  all_forecasts <- suppressMessages(
    load_forecasts(source = "local_hub_repo",
                   hub_repo_path = here(),
                   hub = "ECDC",
                   forecast_dates = forecast_dates,
                   verbose = FALSE))

  if (verbose) {message(paste0(
    "Forecasts loaded from ",
    as.character(min(forecast_dates)), " to ",
    as.character(max(forecast_dates))))
    }

  # Exclusions --------------------------------------------------------------
  # If manual exclusion is csv, convert to vector
  if ("data.frame" %in% class(exclude_models)) {
    exclude_models <- exclude_models %>%
      filter(forecast_date == !!forecast_date) %>%
      pull(model)
  }

  # Filter by inclusion criteria
  forecasts <- use_ensemble_criteria(forecasts = all_forecasts,
                                     exclude_models = exclude_models,
                                     return_criteria = return_criteria,
                                     exclude_designated_other = exclude_designated_other)

  if (return_criteria) {
    criteria <- forecasts$criteria
    forecasts <- forecasts$forecasts
  }

  forecasts <- forecasts %>%
    filter(type == "quantile") %>%
    mutate(quantile = round(quantile, 3),
           horizon = as.numeric(horizon))

  # Run  ensembles ---------------------------------------------------
  # Averages
  if (method %in% c("mean", "median")) {
    ensemble <- create_ensemble_average(method = method,
                                        forecasts = forecasts)
    if (return_criteria) {
      weights <- forecasts %>%
        group_by(target_variable, location) %>%
        mutate(weight = 1 / length(unique(model))) %>%
        group_by(model, target_variable, location) %>%
        summarise(weight = unique(weight), .groups = "drop")
    }
  }

  # Relative skill
  if (grepl("^relative_skill", method)) {
    by_horizon <- grepl("_by_horizon", method)
    use_median <- grepl("_median", method )
    ensemble <- create_ensemble_relative_skill(forecasts = forecasts,
                                               by_horizon = by_horizon,
                                               average = if_else(use_median,
                                                                 "median",
                                                                 "mean"),
                                               return_criteria = return_criteria,
                                               verbose = verbose,
                                               ...)
    # Update model inclusion criteria
    if (return_criteria) {
      weights <- ensemble$weights
      ensemble <- ensemble$ensemble
      criteria <- criteria %>%
        mutate(included_in_ensemble = ifelse(model %in% weights$model,
                                             included_in_ensemble,
                                             FALSE))
    }
  }

  # Add other ensemble methods here as:
  #   if (method == "method") {
  #     ensemble <- method_function_call()
  #   }

# Format and return -----------------------------------------------------------
  ensemble <- format_ensemble(ensemble = ensemble,
                              forecast_date = max(forecast_dates))

  if (verbose) {message("Ensemble formatted in hub standard")}

  if (return_criteria) {
    return(list("ensemble" = ensemble,
                "criteria" = criteria,
                "method" = method,
                "weights" = weights,
                "forecast_date" = max(forecast_dates)))
  }

  return(ensemble)
}
