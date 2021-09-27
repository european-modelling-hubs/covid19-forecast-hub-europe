library("here")
library("readr")
library("dplyr")
library("tidyr")
library("ISOweek")
library("stringi")
library("lubridate")
library("R.utils")
library("curl")
library("covidHubUtils")

cat("Downloading ECDC data\n")

locations <- covidHubUtils::hub_locations_ecdc %>%
  select(location, location_name)

# Case and death data
ct <- "cc--cic---"

ecdc_dir <- here::here("data-truth", "ECDC")
file_base <- "truth_ECDC-Incident"

if (!dir.exists(ecdc_dir)) dir.create(ecdc_dir, recursive = TRUE)

# Hospitalisation data
ecdc_hosp_filepath <- here("data-truth", "ECDC",
                      paste(file_base, "Hospitalizations.csv")) # covidHubUtils format

temp_ecdc <- R.utils::downloadFile(Sys.getenv("DATA_URL"), # Uses set environment variables
                      tempfile(fileext = ".csv"),
                      username = Sys.getenv("DATA_USERNAME"),
                      password = Sys.getenv("DATA_PASSWORD"),
                      skip = FALSE,
                      overwrite = TRUE)

public_sources <- c("Country_Website", "Country_API", "Country_Github")

ecdc_present <- read_csv(temp_ecdc) %>%
  filter(Indicator %in% c("New_Hospitalised") &
           Source %in% public_sources) %>%
  rename(location_name = CountryName) %>%
  mutate(target_variable = "inc hosp") %>%
  left_join(locations, by = "location_name") %>%
  select(date = Date, location, location_name, value = Value) %>%
  group_by(location, location_name) %>%
  summarise(tot_value = sum(value))

ecdc_past <- read_csv(ecdc_hosp_filepath) %>%
  group_by(location, location_name) %>%
  summarise(old_tot_value = sum(value))

ecdc_hosp <- full_join(ecdc_past, ecdc_present) %>%
  mutate(value = tot_value - old_tot_value, .keep = "unused")

write_csv(ecdc_hosp, file = ecdc_hosp_filepath, append = FALSE)

