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

models <- covidHubUtils::get_model_designations(source = "local_hub_repo",
                                                hub_repo_path = here()) %>%
  filter(designation %in% c("primary", "secondary")) %>%
  pull(model)

########TODO!! remove
# models <- models[8:10]
########

for (model in models) {
  rmarkdown::render(here::here("code", "reports", "models",
                               "model-report.Rmd"),
                    params = list(model = model,
                                  report_date = report_date,
                                  restrict_weeks = 4),
                    output_format = "html_document",
                    output_file =
                      here::here("html",
                                 paste0("model-report-",
                                        model, ".html")),
                    envir = new.env())
}
