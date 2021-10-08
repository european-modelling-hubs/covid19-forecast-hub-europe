# packages ---------------------------------------------------------------------
library(dplyr)
library(here)
library(readr)
library(scoringutils)
library(rmarkdown)
library(lubridate)
library(EuroForecastHub)

# Set parameters
options(knitr.duplicate.label = "allow")

report_date <- today()
wday(report_date) <- get_hub_config("forecast_week_day")

suppressWarnings(dir.create(here::here("html")))
suppressWarnings(dir.create(here::here("html", "report-model-files")))

models <- covidHubUtils::get_model_designations(source = "local_hub_repo",
                                                hub_repo_path = here()) %>%
  filter(designation %in% c("primary", "secondary")) %>%
  pull(model)

models <- models[c(14,20,38)]

# Create safe function for rendering report for each model
safely_render <- purrr::safely(.f = ~ rmarkdown::render(here::here("code", "reports", "models",
                                                              "model-report.Rmd"),
                                                   params = list(model = .,
                                                                 report_date = report_date,
                                                                 restrict_weeks = 4),
                                                   output_format = "html_document",
                                                   output_file =
                                                     here::here("html",
                                                                paste0("model-report-",
                                                                       ., ".html")),
                                                   envir = new.env()),
                              otherwise = NA_real_)

# Create report for each model
purrr::walk(.x = models, 
            .f = safely_render)
