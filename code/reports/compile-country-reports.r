# packages ---------------------------------------------------------------------
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

for (country in c("Overall", hub_locations_ecdc$location_name)) {
  rmarkdown::render(here::here("code", "reports", "country",
                               "country-report.Rmd"),
                    output_format = "html_document",
                    params = list(location_name = country,
                                  report_date = report_date,
                                  plot_weeks = 4),
                    output_file =
                      here::here("html",
                                 paste0("country-report-",
                                        country, ".html")),
                    output_options = list(lib_dir = here::here("html", "libs")),
                    envir = new.env())
}
