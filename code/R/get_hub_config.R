#' Get the value of setting from config file
#'
#' @param setting Setting for which to return the value. All values are returned
#' in a list if missing.
#' @param config_file Path to the config file
#'
#' @export
#'
#' @examples
#' # Get config for European COVID-19 forecast hub
#' get_hub_config(config_file = "https://raw.githubusercontent.com/epiforecasts/covid19-forecast-hub-europe/main/forecasthub.yml")
#'
get_hub_config <- function(setting, config_file = here::here("forecasthub.yml")) {

  if (missing(setting)) {
    yaml::read_yaml(config_file)
  }

  else {
    yaml::read_yaml(config_file)[[setting]]
  }
}
