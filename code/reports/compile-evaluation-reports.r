# packages ---------------------------------------------------------------------
library(dplyr)
library(here)
library(readr)
library(scoringutils)
library(rmarkdown)
library(data.table)
library(covidHubUtils)
library(lubridate)

options(knitr.duplicate.label = "allow")

report_date <- today()
wday(report_date) <- get_hub_config("forecast_week_day")

suppressWarnings(dir.create(here::here("html")))

last_forecast_date <- report_date

for (i in 1:nrow(hub_locations_ecdc)) {
  country_code <- hub_locations_ecdc$location[i]
  country <- hub_locations_ecdc$location_name[i]

  rmarkdown::render(here::here("code", "reports", "evaluation",
                               "evaluation-by-country.Rmd"),
                    output_format = "html_document",
                    params = list(location_code = country_code,
                                  location_name = country,
                                  report_date = report_date,
                                  restrict_weeks = 4),
                    output_file =
                      here::here("html",
                                 paste0("evaluation-report-",
                                        country, ".html")),
                    envir = new.env())
}

rmarkdown::render(here::here("code", "reports", "evaluation",
                             "evaluation-report.Rmd"),
                  params = list(report_date = report_date,
                                restrict_weeks = 4),
                  output_format = "html_document",
                  output_file =
                    here::here("html", paste0("evaluation-report-",
                                              "Overall.html")),
                  envir = new.env())

## to make this generalisable
# allow bits to be turned off and on
# somehow pass down the filtering
