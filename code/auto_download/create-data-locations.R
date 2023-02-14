# Create data-locations.csv
library(here)
library(readr)
library(dplyr)
library(covidHubUtils)

hosp <- read_csv(here("data-truth", "OWID", "truth_OWID-Incident Hospitalizations.csv"))

locs <- covidHubUtils::hub_locations_ecdc %>%
  mutate(inc_hosp = case_when(location_name %in% hosp$location_name ~ "OWID"),
         inc_case = "JHU",
         inc_death = "JHU")

write_csv(locs, here("data-locations", "locations_eu.csv"))
