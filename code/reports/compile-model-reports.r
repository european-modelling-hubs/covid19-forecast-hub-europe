#! /usr/bin/env RScript

# packages ---------------------------------------------------------------------
suppressMessages(library(docopt))
suppressMessages(library(here))
suppressMessages(library(dplyr))
suppressMessages(library(tidyr))
suppressMessages(library(lemon))
suppressMessages(library(scales))
suppressMessages(library(readr))
suppressMessages(library(scoringutils))
suppressMessages(library(rmarkdown))
suppressMessages(library(rmdpartials))
suppressMessages(library(lubridate))
suppressMessages(library(forcats))
suppressMessages(library(RColorBrewer))
suppressMessages(library(cowplot))
suppressMessages(library(EuroForecastHub))

# Set parameters
options(knitr.duplicate.label = "allow")

'Compile model report
Usage:
    compile-model-report.r [--models=<models>] [--plot-weeks=<weeks>] [<subdir>]
    compile-model-report.r -h | --help

Options:
    -h, --help  Show this screen
    -c <models>, --models=<models>  Comma-separated list of models to generate report for (default: all)
    -p --plot-weeks  Number of recent weeks of submission to plot (default: 1)
    -d --data-weeks  Number of recent weeks of data to consider (default: 10)

Arguments:
    subdir Subdirectory in which to score models if not scoring
           models in the main repo' -> doc

opts <- docopt(doc)

models <- covidHubUtils::get_model_metadata(source = "local_hub_repo",
                                            hub_repo_path = here()) %>%
  filter(!grepl("hub-baseline$", model)) %>%
  pull(model)

## if running interactively can set opts to run with options
if (interactive() && !exists(opts)) opts <- list()

## default options
models_str <- ifelse(is.null(opts$models), models, opts$models)
models <- unlist(strsplit(models_str, split = ","))
plot_weeks <-
  ifelse(is.null(opts$plot_weeks), 1L, as.integer(opts$plot_weeks))
data_weeks <-
  ifelse(is.null(opts$data_weeks), 10L, as.integer(opts$data_weeks))
subdir <- ifelse(is.null(opts$subdir), "", opts$subdir)

report_date <- today()
wday(report_date) <- get_hub_config("forecast_week_day")

suppressWarnings(dir.create(here::here(subdir, "html"), recursive = TRUE))

# Create function for rendering report for each model
render_report <- function(model) {
	rmarkdown::render(here::here("code", "reports", "models",
                               "model-report.Rmd"),
                    params = list(model = model,
                                  subdir = subdir,
                                  report_date = report_date,
                                  plot_weeks = plot_weeks,
                                  data_weeks = data_weeks),
                    output_format = "html_document",
                    output_file =
                      here::here("html", subdir,
                                 paste0("model-report-",
                                        model, ".html")),
                    envir = new.env())
}

# Create report for each model
purrr::walk(.x = models,
            .f = render_report)
