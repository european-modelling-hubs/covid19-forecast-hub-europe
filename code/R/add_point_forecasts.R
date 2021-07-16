#' Add point forecasts to a quantile forecasts data.frame
#'
#' @param data The `data.frame` containing quantile forecasts
#'
#' @return
#' The `data.frame` from `data` with additional rows containing the point
#' forecasts
#'
#' @importFrom dplyr %>% filter mutate
#'
#' @export
add_point_forecasts <- function(data) {

  data %>%
    filter(quantile == 0.5) %>%
    mutate(type = "point",
           quantile = NA_real_) %>%
    rbind(data)

}
