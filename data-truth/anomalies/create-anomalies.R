# Create csv with data anomalies
# 2021-06-01 placeholder before implementing automated detection
library(here)
library(dplyr)
library(tibble)

anomalies <- tribble(
  ~target_end_date, ~target_variable, ~location, ~location_name, ~anomaly,
  "2021-03-06", "inc case", "ES", "Spain", "Negative case reporting",
  "2021-05-22", "inc case", "FR", "France", "Removed double counting",
  "2021-05-22", "inc case", "IE", "Ireland", "No data reported",
  "2021-05-22", "inc death", "IE", "Ireland", "No data reported",
  "2021-05-29", "inc case", "IE", "Ireland", "No data reported",
  "2021-05-29", "inc death", "IE", "Ireland", "No data reported"
) %>%
  mutate(target_end_date = as.Date(target_end_date))

vroom_write(anomalies,
            here("data-truth", "anomalies", "anomalies.csv"),
            delim = ",")
