# Generate a template file for cumulative and incident death forecasts, national level
# Johannes Bracher, May 2020
# modified: Jan 2021, Kath S

# Get EU + EFTA + UK country names + codes ---------------------------------------------

# 
# packages: countrycode eurostat dplyr readr

library(dplyr)

locations <- eurostat::eu_countries %>%
  bind_rows(eurostat::efta_countries) %>%
  rename(country = name, eurostat = code) %>%
  mutate(country_code = countrycode::countrycode(eurostat, "eurostat", "iso2c")) %>%
  select(country, iso2c = country_code)

readr::write_csv(locations, path = here::here("template/locations_eu.csv"), append = FALSE)

# Template dataframe ------------------------------------------------------

# This file creates a template data frame to store the following quantities:
# - 1 through 4 week ahead forecasts of incident case + death.
# 
# Weekly forecasts are Sun-Sat with submission (forecast_date) on Mon


# define the date on which forecasts are generated:
forecast_date <- as.Date("2021-02-01")

dat <- data.frame(
  scenario_id = "EXAMPLE",
  forecast_date = forecast_date,
  target = "4 wk ahead inc case",
  target_end_date = forecast_date + 5, # forecast_date = Mon, target = Sat
  location = "EXAMPLE",
  type = "point",
  quantile = NA,
  value = 1
)

tgs <- c(paste(1:4, "wk ahead inc case"),
         paste(1:4, "wk ahead inc death"))

end_dates <- c(forecast_date + c(6, 13, 20, 27),
               forecast_date + c(6, 13, 20, 27))

quantiles <- c(0.01, 0.025, 1:19/20, 0.975, 0.99)

weekdays(end_dates)

for (loc in 1:nrow(locations)) {
  for (t in seq_along(tgs)) {
    new_dat <- data.frame(scenario_id = "forecast",
                          forecast_date = forecast_date,
                          target = tgs[t],
                          target_end_date = end_dates[t],
                          location = locations$iso3c[loc],
                          type = c("point", rep("quantile", length(quantiles))),
                          quantile = c(NA, quantiles),
                          value = 1)
    dat <- rbind(dat, new_dat)
  }
}


dat$target_end_date <- as.Date(dat$target_end_date, origin = "1970-01-01")
dat$forecast_date <- as.Date(dat$forecast_date, origin = "1970-01-01")

write.csv(dat, file = here::here("data-processed/Template-ExampleModel", paste0(forecast_date, "-Template-ExampleModel.csv")), row.names = FALSE)
write.csv(dat, file = here::here("template", paste0(forecast_date, "-Template-ExampleModel.csv")), row.names = FALSE)


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












