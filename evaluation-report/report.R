# packages ---------------------------------------------------------------------
library(purrr)
library(dplyr)
library(here)
library(readr)
library(scoringutils)
library(rmarkdown)
library(data.table)
library(covidHubUtils)



rmarkdown::render(here::here("evaluation-report", "report-template.Rmd"),
                  output_format = "md_document",
                  output_file = here::here("docs", "index.md"),
                  envir = new.env(),
                  clean = TRUE)


## to make this generalisable
# allow bits to be turned off and on
# somehow pass down the filtering
