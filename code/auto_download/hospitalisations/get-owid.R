# Get official weekly ECDC hospitalisation data
library(dplyr)
library(readr)
library(here)
library(lubridate)

# Set up
data_dir <- here("data-truth", "OWID")
owid_filepath <- here(data_dir, paste0("covid-hospitalizations.csv"))
owid_filepath_dated <-
  here(data_dir, paste0("covid-hospitalizations_", today(), ".csv"))
pop <- covidHubUtils::hub_locations_ecdc

# Get ECDC published data
cat("Downloading OWID published data\n")
owid <- read_csv(
  paste0(
    "https://raw.githubusercontent.com/owid/covid-19-data/master/",
    "public/data/hospitalizations/covid-hospitalizations.csv"
  ), show_col_types = FALSE) %>%
  filter(grepl("hospital admissions$", indicator)) %>%
  rename(location_name = entity) %>%
  inner_join(pop |>
             select(location_name, location),
             by = "location_name") %>%
  # Rescale to count from per 100k
  select(location_name, location, date, value) %>%
  mutate(source = "OWID",
         type = "Scraped")

# Save
write_csv(owid, owid_filepath)
write_csv(owid, owid_filepath_dated)
