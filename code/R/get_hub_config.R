#' Get the value of setting from config file
#'
#' @param setting Setting for which to return the value. All values are returned
#' in a list if missing.
#' @param config_file Path to the config file
#'
#' @export
get_hub_config <- function(setting, config_file = here::here("forecasthub.yml")) {

  if (missing(setting)) {
    yaml::read_yaml(config_file)
  }

  else {
    yaml::read_yaml(config_file)[[setting]]
  }
}
