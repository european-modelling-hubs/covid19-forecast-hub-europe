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

model_name <- "LANL-GrowthRate"
raw_dir <- here::here("data-raw", model_name)
processed_dir <- here::here("data-processed", model_name)
last_sunday <- floor_date(today(), unit = "week", week_start = 7)
data_types <- c("cases", "deaths")

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
  paste0(last_sunday, "_global_incidence_weekly_", x, "_website.csv")
}, "")

## download

url <- vapply(c("cases", "deaths"), function(x) {
  paste0("https://covid-19.bsvgateway.org/forecast/global/", last_sunday,
         "/files/", filenames[x])
}, "")

res <- vapply(names(url), function(x) {
  download.file(url[x], file.path(raw_dir, filenames[x]))
}, 0L)

## process
country_codes <- vroom(here::here("template", "locations_eu.csv"))

df <- lapply(data_types, function(x) {
  vroom(file.path(raw_dir, filenames[x]), col_types = col_specs) %>%
    mutate(type = x)
}) %>%
  bind_rows() %>%
  filter(!is.na(week_ahead)) %>%
  rename(country = name) %>%
  inner_join(country_codes, by = "country") %>%
  mutate(scenario_id = "forecast",
         target = paste(week_ahead, "wk ahead inc", sub("s$", "", type))) %>%
  pivot_longer(starts_with("q."), names_to = "quantile") %>%
  mutate(quantile = as.numeric(sub("q\\.", "0.", quantile)),
         type = "quantile") %>%
  select(scenario_id, forecast_date = fcst_date, target,
         target_end_date = end_date, location = iso2c, type, quantile, value)

point_forecasts <- df %>%
  filter(quantile == 0.5) %>%
  mutate(type = "point",
         quantile = NA_real_)

combined <- df %>%
  bind_rows(point_forecasts) %>%
  arrange(forecast_date, target, target_end_date, location, type, quantile)

forecast_submission_date <-
  unique(df$forecast_date - 1) %>%
  ceiling_date(unit = "week", week_start = 7)

filename <-
  paste0(paste(forecast_submission_date, model_name, sep = "-"), ".csv")
vroom_write(df, file.path(processed_dir, filename), delim = ",")
