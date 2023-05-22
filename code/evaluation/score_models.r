#! /usr/bin/env RScript
suppressMessages(library("here"))
suppressMessages(library("lubridate"))
suppressMessages(library("docopt"))

source(here("code", "evaluation", "load_and_score_models.r"))

## can call either without argument or with subdir as an argument
## e.g. Rscript code/evaluation/score_models.r ensembles
'Produce date-by-date and model-by-model scores
Usage:
    score_models.r [<subdir>] [-l limit]

Options:
    -h --help Show this screen
    -l --limit Limit to the recent "limit" number of weeks

Arguments:
    subdir Subdirectory in which to score models if not scoring
           models in the main repo' -> doc

## if running interactively can set opts to run with options
if (interactive()) {
  if (!exists("opts")) opts <- list()
} else {
  opts <- docopt(doc)
}

subdir <- ifelse(is.null(opts$subdir), "", opts$subdir)
limit <- opts$limit

suppressWarnings(dir.create(here(subdir, "evaluation")))
scores <- load_and_score_models(subdir, limit = limit)
write_csv(scores, here(subdir, "evaluation", "scores.csv"))
