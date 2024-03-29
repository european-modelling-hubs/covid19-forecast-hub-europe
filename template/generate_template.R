## Generate a template file for cumulative and incident death forecasts, national level,  and locations
# Johannes Bracher, May 2020
# modified: Jan 2021, Kath S

# Get EU + EFTA + UK country names + codes ---------------------------------------------

#
# packages: countrycode eurostat dplyr readr

library(dplyr)
library(tidyr)
library(eurostat)
library(stringr)
# devtools::install_github("reichlab/covidHubUtils")

data(world_bank_pop)

pop <- world_bank_pop %>%
  filter(indicator == "SP.POP.TOTL") %>%
  select(iso3c = country, population = `2017`)

locations <- eurostat::eu_countries %>%
  bind_rows(eurostat::efta_countries) %>%
  rename(location_name = name, eurostat = code) %>%
  mutate(location =
           countrycode::countrycode(eurostat, "eurostat", "iso2c"),
         iso3c =
           countrycode::countrycode(eurostat, "eurostat", "iso3c")) %>%
  left_join(pop, by = "iso3c") %>%
  select(location_name, location, population)

# add truth source by target variable
truth_source <- covidHubUtils::load_truth(data_location = "local_hub_repo",
                                          local_repo_path = here(),
                                          hub = "ECDC") %>%
  # clean source name
  mutate(source = str_extract(model, "\\(.+$"),
         source = str_remove_all(source, "\\(|\\)")) %>%
  # unique source-location-variable
  distinct(source, location, target_variable) %>%
  # pivot so that each country's sources are in columns by target variable
  mutate(target_variable = str_replace_all(target_variable, "\\s", "_")) %>%
  pivot_wider(names_from = target_variable,
              values_from = source)
locations <- left_join(locations, truth_source, by = "location")

readr::write_csv(locations,
                 file = here::here("data-locations", "locations_eu.csv"),
                 append = FALSE)

# Submission dates & epiweeks ------------------------------------

forecast_date <- tibble::tibble(
  forecast_date	= seq.Date(as.Date("2021-02-01"), as.Date("2023-01-02"), by = 7),
  epidemic_week	= paste0(lubridate::year(forecast_date), "-", "ew", lubridate::epiweek(forecast_date)),
  forecast_1_wk_ahead_start = forecast_date - 1,
  forecast_1_wk_ahead_end = forecast_1_wk_ahead_start + 6)

write.csv(forecast_date, file = paste0(here::here("template/forecast-dates.csv")), row.names = FALSE)
