# Get EU + EFTA + UK country names + codes
# packages: countrycode eurostat dplyr readr

library(dplyr)

countries <- eurostat::eu_countries %>%
  bind_rows(eurostat::efta_countries) %>%
  rename(country = name, eurostat = code) %>%
  mutate(country_code = countrycode::countrycode(eurostat, "eurostat", "iso3c")) %>%
  select(country, iso3c = country_code)

readr::write_csv(countries, "template/locations_eu.csv")