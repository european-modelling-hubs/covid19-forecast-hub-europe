get_hub_config <- function(setting, config_file = "forecasthub.yml") {
  
  if (missing(setting)) {
    yaml::read_yaml(here::here(config_file))
  }
  
  else {
    yaml::read_yaml(here::here(config_file))[[setting]]
  }
}
