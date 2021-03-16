library(here)
library(vroom)
library(purrr)
library(dplyr)
library(stringr)
library(lubridate)

team_name <- "EuroCOVIDhub-ensemble"
forecast_date <- floor_date(today(), "week", 1)

files <- dir(here("data-processed"), pattern = as.character(forecast_date),
             include.dirs = TRUE, recursive = TRUE,
             full.names = TRUE)

models <- files %>%
  map(~ vroom(.x))

teams <- files %>%
  str_remove_all(here("data-processed")) %>%
  str_split("/") %>%
  map_chr( ~ .x[2])

names(models) <- teams

models <- bind_rows(models, .id = "team")

quantiles <- round(c(0.01, 0.025, seq(0.05, 0.95, by = 0.05), 0.975, 0.99), 3)

ensemble <- models %>%
  filter(type == "quantile") %>%
  mutate(type_forecast = sub("^.* ([a-z]+)$", "\\1", target),
         quantile = round(quantile, 3)) %>%
  group_by(team, type_forecast, location) %>%
  mutate(four_weeks = any(grepl("^4 wk", target))) %>%
  group_by(team, type_forecast, location, target_end_date) %>%
  mutate(all_quantiles = length(setdiff(quantiles, quantile)) == 0) %>%
  group_by(team, type_forecast, location) %>%
  mutate(all_quantiles = all(all_quantiles == TRUE)) %>%
  ungroup() %>%
  filter(all_quantiles == TRUE,
         four_weeks == TRUE) %>%
  select(-all_quantiles, -four_weeks) %>%
  group_by(target, target_end_date, location, type, quantile) %>%
  summarise(forecasts = n(),
            value = mean(value),
            .groups = "drop") %>%
  mutate(forecast_date = forecast_date) %>%
  select(forecast_date, target, target_end_date,
         location, type, quantile, value)

ensemble_point <- ensemble %>%
  filter(quantile == 0.5) %>%
  mutate(type = "point",
         quantile = NA_real_)

ensemble_with_point <- ensemble %>%
  bind_rows(ensemble_point)

vroom_write(ensemble_with_point,
            here::here("data-processed", team_name,
                       paste0(forecast_date, "-", team_name, ".csv")),
            delim = ",")
