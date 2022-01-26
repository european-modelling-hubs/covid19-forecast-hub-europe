# Create csv with data anomalies
library(here)
library(dplyr)
library(tibble)
library(readr)
library(EuroForecastHub)
library(covidHubUtils)
library(tidyr)

# Enter anomalies manually as they occur
anomalies <- tribble(
  ~target_end_date, ~target_variable, ~location, ~location_name, ~anomaly,
  # By week target end date
  "2021-03-06", "inc case", "ES", "Spain", "Negative case reporting",
  #
  "2021-05-22", "inc case", "FR", "France", "Removed double counting",
  #
  "2021-05-22", "inc case", "IE", "Ireland", "No data reported",
  "2021-05-22", "inc death", "IE", "Ireland", "No data reported",
  #
  "2021-05-29", "inc case", "IE", "Ireland", "No data reported",
  "2021-05-29", "inc death", "IE", "Ireland", "No data reported",
  #
  "2021-06-05", "inc death", "IE", "Ireland", "No data reported",
  "2021-06-05", "inc case", "IE", "Ireland", "2 days missing, 1 day spike",
  #
  "2021-06-12", "inc death", "IE", "Ireland", "No data reported",
  "2021-06-12", "inc case", "IE", "Ireland", "Spike removed after case count backdistributed",
  #
  "2021-06-12", "inc case", "ES", "Spain", "Historic cases added but not backdistributed in Catalonia",
  #
  "2021-06-20", "inc death", "SE", "Sweden", "No data reported",
  "2021-06-20", "inc case", "SE", "Sweden", "No data reported",
  #
  "2021-11-07", "inc hosp", "CH", "Switzerland", "Problem in data source",
  #
  "2021-12-18", "inc hosp", "DK", "Denmark", "No data reported",
  "2021-12-25", "inc hosp", "DK", "Denmark", "No data reported",
  "2021-01-01", "inc hosp", "DK", "Denmark", "No data reported",
  "2021-01-08", "inc hosp", "DK", "Denmark", "No data reported",
  "2021-01-15", "inc hosp", "DK", "Denmark", "No data reported",
) %>%
  mutate(target_end_date = as.Date(target_end_date))

# Exclude hospitalisations for all locations
#    before re-launch of "inc hosp" target on 2021-11-07
hub_launch <- as.Date("2021-03-08")
hosp <- tibble(target_end_date = 
                 seq.Date(hub_launch,
                          as.Date("2021-11-06"), by = 7)) %>%
  bind_rows(covidHubUtils::hub_locations_ecdc %>% select(-population)) %>%
  expand(nesting(location_name, location), target_end_date) %>%
  drop_na() %>%
  mutate(target_variable = "inc hosp",
         anomaly = "Replaced data source")

anomalies <- bind_rows(anomalies, hosp)

write_csv(anomalies, here("data-truth", "anomalies", "anomalies.csv"))
