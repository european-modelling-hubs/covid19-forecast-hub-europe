library(covidHubUtils)
library(dplyr)
library(vroom)
library(here)

# also required for identify_outlier():
library(forecast)
library(purrr)
library(lubridate)
library(zoo)

# Set outlier detection method --------------------------------------------
# Get US covidData identify_outlier()
source("https://raw.githubusercontent.com/reichlab/covidData/master/R/identify_outliers.R")

# Use simplest rolling median
methods <- data.frame(method = c("rolling_median"),
                      transform = c("none"))

# Get data ----------------------------------------------------------------
daily <- vroom(here("data-truth", "JHU",
                           "truth_JHU-Incident Cases.csv")) %>%
  rename(inc = value)

daily_by_location <- split(daily, daily$location_name)

# Run detection ----------------------------------------------------------
# Rolling median with no transform and 1 iteration
outliers_detected <- map(daily_by_location,
                         ~ identify_outliers(.x,
                                             methods = methods,
                                             max_iter = 1))

outliers <- bind_rows(outliers_detected, .id = "location_name") %>%
  filter(method_transform == "rolling_median_none")

# Compare -----------------------------------------------------------------
compare <- rename(outliers_detected,
                  imputed = inc) %>%
  left_join(daily, by = c("location", "date")) %>%
  mutate(diff = (imputed - inc) / inc)


# Note: US covidData default is
# outliers_detected <- identify_outliers(
#   data,
#   methods = data.frame(
#     method = c(rep("weekly_extrema_loess_loo", 3), rep("rolling_median", 2)),
#     transform = c("none", "sqrt", "log", "none", "log")
#   ),
#   max_iter = 10
# )
