# Create data-locations.csv
library("here")
library("readr")
library("dplyr")
library("covidHubUtils")

hosp <- readr::read_csv(
  here::here("data-truth", "OWID", "truth_OWID-Incident Hospitalizations.csv")
)

locs <- covidHubUtils::hub_locations_ecdc %>%
  dplyr::mutate(
    inc_hosp = case_when(location_name %in% hosp$location_name ~ "OWID"),
    inc_case = "ECDC",
    inc_death = "ECDC"
  )

readr::write_csv(locs, here::here("data-locations", "locations_eu.csv"))
