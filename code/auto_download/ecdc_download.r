library("here")
library("readr")
library("dplyr")
library("tidyr")
library("ISOweek")
library("stringi")
library("lubridate")

cat("Downloading ECDC data\n")

locations <- read_csv(here("data-locations", "locations_eu.csv")) %>%
  select(location, location_name)

# Case and death data
ct <- "cc--cic---"

ecdc_dir <- here::here("data-truth", "ECDC")
file_base <- "truth_ECDC-Incident"

if (!dir.exists(ecdc_dir)) dir.create(ecdc_dir, recursive = TRUE)

df <-
  read_csv("https://opendata.ecdc.europa.eu/covid19/nationalcasedeath/csv",
               col_types = ct) %>%
  inner_join(locations, by = c("country" = "location_name")) %>%
  separate(year_week, c("year", "week"), sep = "-") %>%
  mutate(week_start = ISOweek2date(paste0(year, "-W", week, "-1"))) %>%
  mutate(indicator = stri_trans_totitle(indicator)) %>%
  select(week_start, indicator,
         location, location_name = country,
         value = weekly_count) %>%
  group_by(indicator) %>%
  group_walk(~ write_csv(.x,
                           file = file.path(ecdc_dir,
                                            paste0(file_base, " ",
                                                   .y$indicator, ".csv"))))

# Hospitalisation data
ecdc_hosp_filepath <- here("data-truth", "ECDC", 
                      "truth_ecdc-Incident Hospitalizations.csv") # covidHubUtils format

R.utils::downloadFile(Sys.getenv("DATA_URL"), # Uses set environment variables
                      ecdc_hosp_filepath, 
                      username = Sys.getenv("DATA_USERNAME"), 
                      password = Sys.getenv("DATA_PASSWORD"),
                      skip = FALSE,
                      overwrite = TRUE)

public_sources <- c("Country_Website", "Country_API", "Country_Github")

ecdc_hosp <- read_csv(ecdc_hosp_filepath) %>%
  filter(Indicator %in% c("New_Hospitalised") &
           Source %in% public_sources) %>%
  rename(location_name = CountryName) %>%
  mutate(target_variable = "inc hosp") %>%
  left_join(locations, by = "location_name") %>%
  select(date = Date, location, location_name, value = Value) %>%
  write_csv(file = ecdc_hosp_filepath, append = FALSE)
