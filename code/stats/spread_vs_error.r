library(covidHubUtils)
library(readr)
library(lubridate)
library(dplyr)
library(tidyr)

report_date <- today()
horizons <- 1:4

raw_forecasts <- load_forecasts(
  source = "local_hub_repo",
  hub_repo_path = here(),
  hub = "ECDC",
  models = "EuroCOVIDhub-ensemble"
) %>%
  # set forecast date to corresponding submission date
  mutate(forecast_date =
           ceiling_date(forecast_date, "week", week_start = 2) - 1) %>%
  filter(between(forecast_date, ymd("2021-03-08"), ymd(report_date))) %>%
  rename(prediction = value) %>%
  filter(horizon %in% horizons) %>%
  filter(!is.na(quantile)) %>%
  pivot_wider(names_from = "quantile", values_from = "prediction") %>%
  mutate(cv = (`0.975` - `0.025`) / (2 * `0.5`)) %>%
  select(-starts_with(`0`))

scores_filename <-
  here::here("evaluation", "scores.csv")

table <- read_csv(scores_filename) %>%
  filter(model == "EuroCOVIDhub-ensemble")

df <- table %>%
  select(target_variable, forecast_date, target_end_date, location_name, wis)

df <- df %>%
  left_join(raw_forecasts, by = c("target_variable", "forecast_date",
                                  "target_end_date", "location_name"))

ggplot(df, aes(x = cv, y = wis)) +
  geom_jitter()

df <- df %>%
  filter(is.finite(cv))

cor.test(df$cv, df$wis, method = "spearman")
