library("here")
library("vroom")
library("eurostat")
library("dplyr")
library("countrycode")
library("tidyr")
library("ISOweek")
library("stringi")

cat("Downloading ECDC data\n")

countries <- eurostat::eu_countries %>%
  bind_rows(eurostat::efta_countries) %>%
  rename(country = name, eurostat = code) %>%
  mutate(country_code = countrycode(eurostat, "eurostat", "iso3c")) %>%
  select(country_code)

ct <- "cc--cic---"

ecdc_dir <- here::here("data-truth", "ECDC")
file_base <- "truth_ECDC-Incident"

if (!dir.exists(ecdc_dir)) dir.create(ecdc_dir, recursive = TRUE)

df <-
  vroom::vroom("https://opendata.ecdc.europa.eu/covid19/nationalcasedeath/csv",
               col_types = ct) %>%
  inner_join(countries, by = "country_code") %>%
  separate(year_week, c("year", "week"), sep = "-") %>%
  mutate(week_start = ISOweek2date(paste0(year, "-W", week, "-1"))) %>%
  mutate(indicator = stri_trans_totitle(indicator)) %>%
  select(week_start, indicator,
         location = country_code, location_name = country,
         value = weekly_count) %>%
  group_by(indicator) %>%
  group_walk(~ write_csv(.x, file = file.path(ecdc_dir,
                                              paste0(file_base,
                                                     .y$indicator, ".csv"))))

