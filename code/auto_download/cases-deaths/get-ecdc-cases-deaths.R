# Get official weekly ECDC hospitalisation data
library(dplyr)
library(covidHubUtils)
library(readr)
library(here)
library(lubridate)
library(ISOweek)

# Set up
data_dir <- here("data-truth", "ECDC")
locations <- read_csv(
  here::here("data-locations", "locations_eu.csv"), show_col_types = FALSE
) |>
  select(location, country = location_name)

# Get ECDC published data
cat("Downloading ECDC published data\n")
official <- read_csv(
  "https://opendata.ecdc.europa.eu/covid19/nationalcasedeath/csv/data.csv",
  show_col_types = FALSE
) |>
  inner_join(locations, by = "country") |>
  mutate(target_end_date = ISOweek2date(
           sub("([0-9]{4})-([0-9]+)$", "\\1-W\\2-7", year_week))
         ) |>
  select(
    location_name = country, target_variable = indicator,
    value = weekly_count, target_end_date
  ) |>
  mutate(target_variable = paste("inc", sub(".$", "", target_variable)))

last_data_day <- max(official$target_end_date)
snapshot_day <- ceiling_date(
  last_data_day, unit = "week", week_start = 5, change_on_boundary = FALSE
)

# Save
ecdc_filepath_dated <- here(
  data_dir, "raw", "snapshots", paste0("cases-deaths_", snapshot_day, ".csv")
)
write_csv(official, ecdc_filepath_dated)
