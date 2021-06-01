# Create csv with data anomalies
# 2021-06-01 placeholder before implementing automated detection
library(here)
library(dplyr)
library(tibble)

anomalies <- tribble(
  ~forecast_date, ~target_variable, ~location, ~location_name, ~problem,
  "2021-05-24", "case", "FR", "France", "Removed double counting",
  "2021-05-24", "case", "IE", "Ireland", "No data reported",
  "2021-05-24", "death", "IE", "Ireland", "No data reported",
  "2021-05-31", "case", "IE", "Ireland", "No data reported",
  "2021-05-31", "death", "IE", "Ireland", "No data reported"
)

vroom_write(anomalies,
            here("data-truth", "anomalies", "anomalies.csv"),
            delim = ",")
