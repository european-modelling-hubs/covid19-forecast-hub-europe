# packages ---------------------------------------------------------------------
library(rlang)
library(dplyr)
library(here)
library(readr)
library(scoringutils)
library(rmarkdown)
library(covidHubUtils)
library(lubridate)
library(EuroForecastHub)

options(knitr.duplicate.label = "allow")

report_date <- today()
wday(report_date) <- get_hub_config("forecast_week_day")

suppressWarnings(dir.create(here::here("html")))

models <- list.files(
  here::here("model-metadata"),
  full.names = TRUE
) |>
  purrr::map(yaml::read_yaml) |>
  purrr::map_chr("model_abbr")

last_4_forecast_dates <- report_date - weeks(seq(1, 4))

recently_submitted <- models |>
  purrr::map_lgl(\(model) any(file.exists(
    here::here("data-processed", model, paste0(
      last_4_forecast_dates, "-", model, ".csv"
    )
  )))
)

models <- models[recently_submitted]

for (country in c("Overall", hub_locations_ecdc$location_name)) {
  message("Generating report for ", country)
  rmarkdown::render(here::here("code", "reports", "country",
                               "country-report.Rmd"),
                    output_format = "html_document",
                    params = list(location_name = country,
                                  report_date = report_date,
                                  plot_weeks = 4,
                                  report_models = models),
                    output_file =
                      here::here("html",
                                 paste0("country-report-",
                                        country, ".html")),
                    output_options = list(lib_dir = here::here("html", "libs")),
                    envir = new.env())
}
