# packages ---------------------------------------------------------------------
library(purrr)
library(dplyr)
library(here)
library(readr)
library(scoringutils)
library(rmarkdown)
library(data.table)
library(covidHubUtils)
library(lubridate)

options(knitr.duplicate.label = "allow")

report_date <-
  lubridate::floor_date(lubridate::today(), "week", week_start = 7) + 1

dir.create(here::here("html"))

rmarkdown::render(here::here("code", "reports", "ensemble",
                             "ensemble-report.Rmd"),
                  params = list(report_date = report_date),
                  output_format = "html_document",
                  output_file =
                    here::here("html", paste0("ensemble-report-", report_date,
                                              ".html")),
                  envir = new.env())

## to make this generalisable
# allow bits to be turned off and on
# somehow pass down the filtering
