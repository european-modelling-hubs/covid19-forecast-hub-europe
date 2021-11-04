# Create data-locations.csv
library(here)
library(readr)
library(dplyr)

hosp <- read_csv(here("code", "auto_download", "hospitalisation-sources.csv")) %>%
  filter(!is.na(source))

locs <- read_csv(here("data-locations", "locations_eu.csv")) %>%
  mutate(inc_hosp = case_when(location_name %in% hosp$country ~ "ECDC",
                              location %in% c("GB", "CH") ~ "covidregionaldata"))
