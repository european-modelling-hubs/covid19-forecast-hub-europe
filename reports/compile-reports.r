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

date <- lubridate::floor_date(lubridate::today(), 'week', week_start = 1)

rmarkdown::render(here::here("reports", "evaluation", "evaluation-report.Rmd"),
                  output_format = "html_document",
                  output_file =
                    here::here("docs", paste0("evaluation-report-", date, ".html")),
                  envir = new.env())

rmarkdown::render(here::here("reports", "ensemble", "ensemble-report.Rmd"),
                  output_format = "html_document",
                  output_file =
                    here::here("docs", paste0("ensemble-report-", date, ".html")),
                  envir = new.env())

## to make this generalisable
# allow bits to be turned off and on
# somehow pass down the filtering
