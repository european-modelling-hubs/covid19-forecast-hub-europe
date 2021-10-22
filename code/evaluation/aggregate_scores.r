#! /usr/bin/env RScript
suppressMessages(library("here"))
suppressMessages(library("docopt"))
suppressMessages(library("lubridate"))
suppressMessages(library("dplyr"))
suppressMessages(library("readr"))
suppressMessages(library("EuroForecastHub"))

'Aggregate model scores by model
Usage:
    aggregate_scores.r [--histories=<histories] [--restrict-weeks=<weeks>] [--re-run] [<subdir>]
    aggregate_scores.r -h | --help

Options:
    -h, --help  Show this screen
    -s <histories>, --histories=<histories>  Weeks of history to produce, separated by commas (default: 10,Inf)
    -w --restrict-weeks  Number of recent weeks of submission to require (default: 4)
    -r --re-run  If given, will re-run all dates instead of just the latest

Arguments:
    subdir Subdirectory in which to score models if not scoring
           models in the main repo' -> doc

opts <- docopt(doc)

## if running interactively can set opts to run with options
if (interactive() && !exists(opts)) opts <- list()

## default options
histories_str <- ifelse(is.null(opts$histories), "10,Inf", opts$histories)
histories <- as.numeric(unlist(strsplit(histories_str, split = ",")))
restrict_weeks <-
  ifelse(is.null(opts$restrict_weeks), 4L, as.integer(opts$restrict_weeks))
subdir <- ifelse(is.null(opts$subdir), "", opts$subdir)
re_run <- opts$re_run

latest_date <- today()
wday(latest_date) <- get_hub_config("forecast_week_day")

## can modify manually if wanting to re-run past evaluation
if (re_run) {
  start_date <- as.Date(get_hub_config("launch_date")) + 4 * 7
} else {
  start_date <- latest_date
}
report_dates <- seq(start_date, latest_date, by = "week")

scores <- read_csv(here::here(subdir, "evaluation", "scores.csv"))
## get default baseline if not included in the scores
if (!(get_hub_config("baseline")[["name"]] %in% unique(scores$model))) {
  baseline_scores <- read_csv(here::here("evaluation", "scores.csv")) %>%
    filter(model == get_hub_config("baseline")[["name"]])
  scores <- scores %>%
    bind_rows(baseline_scores)
}

suppressWarnings(dir.create(here(subdir, "evaluation", "weekly-summary")))

for (chr_report_date in as.character(report_dates)) {
  tables <- list()
  for (history in histories) {
    report_date <- as.Date(chr_report_date)

    use_scores <- scores %>%
      filter(target_end_date > report_date - history * 7)

    str <- paste("Evaluation as of", report_date)
    if (history < Inf) {
      str <- paste(str, "keeping", history, "weeks of history")
    }
    message(paste0(str, "."))

    tables[[as.character(history)]] <- summarise_scores(
      scores = use_scores,
      report_date = report_date,
      restrict_weeks = restrict_weeks
    )
  }

  combined_table <- bind_rows(tables, .id = "weeks_included") %>%
    mutate(weeks_included = recode(weeks_included, `Inf` = "All"))
  eval_filename <-
    here::here(subdir, "evaluation", "weekly-summary",
	       paste0("evaluation-", report_date, ".csv"))

  write_csv(combined_table, eval_filename)
}

