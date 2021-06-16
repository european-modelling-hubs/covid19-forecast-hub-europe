get_forecast_targets <- function() {
  yaml::read_yaml(here("forecasthub.yml"))$targets
}
