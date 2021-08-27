################################################################################
###### Download and process European forecasts from LANL
################################################################################

library("lubridate")
library("here")
library("vroom")
library("dplyr")
library("tidyr")
library("readr")
library("janitor")
library("EuroForecastHub")

model_name <- "LANL-GrowthRate"
raw_dir <- file.path(tempdir(), "data-raw", model_name)
processed_dir <- here::here("data-processed", model_name)
last_sunday <- floor_date(today(), unit = "week", week_start = 7)
data_types <- c("inc case", "inc death")

suppressWarnings(dir.create(raw_dir, recursive = TRUE))
suppressWarnings(dir.create(processed_dir, recursive = TRUE))
col_specs <- cols(
  fcst_hub_epiweek = col_integer(),
  epiyear = col_integer(),
  key = col_character(),
  q.01 = col_double(),
  q.025 = col_double(),
  q.05 = col_double(),
  q.10 = col_double(),
  q.15 = col_double(),
  q.20 = col_double(),
  q.25 = col_double(),
  q.30 = col_double(),
  q.35 = col_double(),
  q.40 = col_double(),
  q.45 = col_double(),
  q.50 = col_double(),
  q.55 = col_double(),
  q.60 = col_double(),
  q.65 = col_double(),
  q.70 = col_double(),
  q.75 = col_double(),
  q.80 = col_double(),
  q.85 = col_double(),
  q.90 = col_double(),
  q.95 = col_double(),
  q.975 = col_double(),
  q.99 = col_double(),
  obs = col_double(),
  week_ahead = col_double(),
  fcst_date = col_date(format = ""),
  name = col_character(),
  big_group = col_character(),
  start_date = col_date(format = ""),
  end_date = col_date(format = "")
)

filenames <- vapply(data_types, function(x) {
  paste0(last_sunday, "_global_incidence_weekly_",
         gsub("^inc (\\w+)$", "\\1s", x),
         "_website.csv")
}, "")

## download

url <- vapply(data_types, function(x) {
  paste0("https://covid-19.bsvgateway.org/forecast/global/", last_sunday,
         "/files/", filenames[x])
}, "")

out <- tryCatch({
  vapply(names(url), function(x) {
    download.file(url[x], file.path(raw_dir, filenames[x]))
  }, 0L)},
  error = function(cond) {
    quit()
  }
)

## process
country_codes <- vroom(here::here("data-locations", "locations_eu.csv"))

df <- lapply(data_types, function(x) {
  vroom(file.path(raw_dir, filenames[x]), col_types = col_specs) %>%
    mutate(type = x)
}) %>%
  bind_rows() %>%
  filter(!is.na(week_ahead)) %>%
  rename(location_name = name) %>%
  inner_join(country_codes, by = "location_name") %>%
  mutate(scenario_id = "forecast",
         target = paste(week_ahead, "wk ahead", type)) %>%
  pivot_longer(starts_with("q."), names_to = "quantile") %>%
  mutate(quantile = as.numeric(sub("q\\.", "0.", quantile)),
         type = "quantile",
         value = round(value)) %>%
  select(scenario_id, forecast_date = fcst_date, target,
         target_end_date = end_date, location, type, quantile, value)

combined <- EuroForecastHub::add_point_forecasts(df)

forecast_submission_date <-
  unique(df$forecast_date)

filename <-
  paste0(paste(forecast_submission_date, model_name, sep = "-"), ".csv")

combined  %>%
  arrange(forecast_date, target, target_end_date, location, type, quantile) %>%
  vroom_write(file.path(processed_dir, filename), delim = ",")
