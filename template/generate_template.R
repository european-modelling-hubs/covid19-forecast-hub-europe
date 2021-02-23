## Generate a template file for cumulative and incident death forecasts, national level,  and locations
# Johannes Bracher, May 2020
# modified: Jan 2021, Kath S

# Get EU + EFTA + UK country names + codes ---------------------------------------------

# 
# packages: countrycode eurostat dplyr readr

library(dplyr)
library(tidyr)
library(eurostat)

data(world_bank_pop)

pop <- world_bank_pop %>%
  filter(indicator == "SP.POP.TOTL") %>%
  select(iso3c = country, population = `2017`)

locations <- eurostat::eu_countries %>%
  bind_rows(eurostat::efta_countries) %>%
  rename(country = name, eurostat = code) %>%
  mutate(location =
           countrycode::countrycode(eurostat, "eurostat", "iso2c"),
         iso3c =
           countrycode::countrycode(eurostat, "eurostat", "iso3c")) %>%
  left_join(pop, by = "iso3c") %>%
  select(country, location, population)

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


# Daily to epiweek conversion ---------------------------------------------

library(magrittr)

epiweeks <- tibble::tibble(
    date = seq.Date(as.Date("2019-12-29"), as.Date("2023-01-02"), by = 1),
    epi_week	= paste0("ew", lubridate::epiweek(date)),
    epi_year = ifelse(weekdays(date) == "Sunday", lubridate::year(date), NA)) %>%
  tidyr::fill(epi_year, .direction = "down") %>%
  dplyr::mutate(epi_week = paste0(epi_year, "_", epi_week),
                epi_year = NULL)

write.csv(epiweeks, file = here::here("template/date-to-epiweek.csv"), row.names = FALSE)












