# Get official weekly ECDC hospitalisation data
library(dplyr)
library(covidHubUtils)
library(readr)
library(here)
library(lubridate)

# Set up
data_dir <- here("data-truth", "ECDC")
ecdc_official_filepath <- here(data_dir, "raw", paste0("official.csv"))
ecdc_official_filepath_dated <-
  here(data_dir, "raw", "snapshots", paste0("official_", today(), ".csv"))
pop <- covidHubUtils::hub_locations_ecdc

# Get ECDC published data
cat("Downloading ECDC published data\n")
official <- read_csv("https://opendata.ecdc.europa.eu/covid19/hospitalicuadmissionrates/csv/data.csv",
                     show_col_types = FALSE) %>%
  rename(unscaled_value = value,
         location_name = country) %>%
  inner_join(pop, by = "location_name") %>%
  # Rescale to count from per 100k
  mutate(value = if_else(grepl("100k", indicator),
                         round(unscaled_value * population / 1e+5),
                         unscaled_value)) %>%
  select(location_name, location, indicator, date, value, source) %>%
  mutate(source = if_else(grepl("TESSy", source), "TESSy", "Public"),
         type = "ECDC")

# Save
write_csv(official, ecdc_official_filepath)
write_csv(official, ecdc_official_filepath_dated)
