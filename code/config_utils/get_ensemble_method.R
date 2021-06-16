get_ensemble_method <- function() {
  yaml::read_yaml(here("forecasthub.yml"))$ensemble_method
}
