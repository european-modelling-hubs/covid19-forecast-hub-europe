library(here)
library(dplyr)
library(readr)
library(lubridate)

locations <- read_csv(here("data-locations", "locations_eu.csv")) %>%
  select(location, location_name)

cases <- covidData::load_jhu_data(
  issue_date = lubridate::today(),
  location_code = locations$location,
  spatial_resolution = "national",
  geography = "global",
  measure = "cases"
) %>%
  select(date, location, inc_case = inc) %>%
  left_join(locations)

deaths <- covidData::load_jhu_data(
  issue_date = lubridate::today(),
  location_code = locations$location,
  spatial_resolution = "national",
  geography = "global",
  measure = "deaths"
) %>%
  select(date, location, inc_death = inc) %>%
  left_join(locations)

# merge cases and deaths into one dataframe
df <- full_join(cases, deaths, by = c("date", "location", "location_name"))

# reformat
df <- df %>%
  select(date, location, location_name, inc_case, inc_death) %>%
  arrange(date, location)

write_csv(df, here("viz", "truth_to_plot.csv"))
