# packages ---------------------------------------------------------------------
library(dplyr)
library(here)
library(readr)
library(scoringutils)
library(rmarkdown)
library(data.table)
library(covidHubUtils)
library(lubridate)
source(here("code", "config_utils", "get_hub_config.R"))

options(knitr.duplicate.label = "allow")

report_date <- update(today(), wday = get_hub_config("forecast_week_day"),
                      week_start = 1, roll = TRUE)

dir.create(here::here("html"))

rmarkdown::render(here::here("code", "reports", "ensemble",
                             "ensemble-report.Rmd"),
                  params = list(report_date = report_date,
                                restrict_weeks = 4),
                  output_format = "html_document",
                  output_file =
                    here::here("html", paste0("ensemble-report.html")),
                  envir = new.env())

## to make this generalisable
# allow bits to be turned off and on
# somehow pass down the filtering
