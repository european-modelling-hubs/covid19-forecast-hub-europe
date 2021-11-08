#! /usr/bin/env RScript

# packages ---------------------------------------------------------------------
suppressMessages(library(docopt))
suppressMessages(library(here))
suppressMessages(library(dplyr))
suppressMessages(library(readr))
suppressMessages(library(scoringutils))
suppressMessages(library(rmarkdown))
suppressMessages(library(covidHubUtils))
suppressMessages(library(lubridate))
suppressMessages(library(EuroForecastHub))

options(knitr.duplicate.label = "allow")

'Compile country report
Usage:
    compile-country-report.r [--countries=<countries>] [--plot-weeks=<weeks>] [<subdir>]
    compile-country-report.r -h | --help

Options:
    -h, --help  Show this screen
    -c <countries>, --countries=<countries>  Comma-separated list of countries to generate report for (default: all)
    -p <weeks>, --plot-weeks=<weeks>  Number of recent weeks of submission to plot (default: 4)

Arguments:
    subdir Subdirectory in which to score models if not scoring
           models in the main repo' -> doc

## if running interactively can set opts to run with options
if (interactive()) {
  if (!exists("opts")) opts <- list()
} else {
  opts <- docopt(doc)
}

## default options
countries_str <-
  ifelse(is.null(opts$countries),
         paste(c("Overall", hub_locations_ecdc$location_name), sep = ","),
         opts$countries)
countries <- unlist(strsplit(countries_str, split = ","))
plot_weeks <-
  ifelse(is.null(opts$plot_weeks), 4L, as.integer(opts$plot_weeks))
subdir <- ifelse(is.null(opts$subdir), "", opts$subdir)

report_date <- today()
wday(report_date) <- get_hub_config("forecast_week_day")

suppressWarnings(dir.create(here::here("html", subdir), recursive = TRUE))

for (country in countries) {
  rmarkdown::render(here::here("code", "reports", "country",
                               "country-report.Rmd"),
                    output_format = "html_document",
                    params = list(location_name = country,
				  subdir = subdir,
                                  report_date = report_date,
                                  plot_weeks = plot_weeks),
                    output_file =
                      here::here("html", subdir,
                                 paste0("country-report-",
                                        country, ".html")),
                    envir = new.env())
}
