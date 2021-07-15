#' Create ensemble using mean or median average.
#'
#' @param forecasts `data.frame` containing all the forecasts to be summarised
#' as an ensemble.
#' @param method One of `mean` (default) or `median`.
#'
#' @details
#' Steps:
#' Takes forecasts which should come from [load_ensemble_forecasts()]
#' Averages by mean or median
#' Formats in submission format
#'
#' @return ensemble model
#'
#' @importFrom dplyr group_by %>% summarise n
#' @importFrom stats median
#'
#' @export

create_ensemble_average <- function(forecasts,
                                    method = c("mean", "median")) {

  method <- match.arg(method)

  # Mean
  if (method == "mean") {
    ensemble <- forecasts %>%
      group_by(target_variable, horizon, temporal_resolution,
               target_end_date, location, type, quantile) %>%
      summarise(forecasts = n(),
                value = mean(value),
                .groups = "drop")
    # Median
  } else if (method == "median") {
    ensemble <- forecasts %>%
      group_by(target_variable, horizon, temporal_resolution,
               target_end_date, location, type, quantile) %>%
      summarise(forecasts = n(),
                value = median(value),
                .groups = "drop")
  }

  # Return ensemble
  return(ensemble)
}



