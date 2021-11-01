library(here)
library(covidregionaldata)
library(dplyr)
library(lubridate)

# Get data
uk <- get_regional_data("UK", localise = FALSE) %>%
  filter(level_1_region %in% c("England", "Scotland", "Wales", "Northern Ireland")) %>% 
  mutate(location_name = "United Kingdom")

ch <- get_regional_data("Switzerland", localise = FALSE) %>%
  filter(level_1_region != "Liechtenstein") %>% 
  mutate(location_name = "Switzerland")

# Format
uk_ch <- bind_rows(uk, ch) %>%
  select(date, location_name, level_1_region, hosp_new) %>%
  # Set ISO weeks (same as ECDC week definition)
  mutate(iso_year = isoyear(date),
         iso_week = isoweek(date)) %>% 
  # Aggregate
  group_by(location_name, iso_year, iso_week) %>% 
  summarise(na = sum(is.na(hosp_new)),
            value = sum(hosp_new, na.rm = TRUE), 
            full_week = length(unique(date)),
            # shift date to use epiweek target_end_date
            target_end_date = max(date) - 1,
            .groups = "drop") %>%
  # remove incomplete weeks
  filter((full_week == 7) &
           (target_end_date >= "2021-05-01")) %>% 
  left_join(covidHubUtils::hub_locations_ecdc, by = "location_name") %>%
  select(location_name, location, 
         date = target_end_date, 
         value)
  


