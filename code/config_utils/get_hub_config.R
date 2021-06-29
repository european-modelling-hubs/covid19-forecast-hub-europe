get_hub_config <- function(setting, config_file = "forecasthub.yml") {
  yaml::read_yaml(here::here(config_file))[[setting]]
}
