# Re run evaluation comparing all ensembles against all models
library(here)

# copy ensemble files into the all-model data-processed file
file_copy <- function(from, to) {
  todir <- dirname(to)
  if (!dir.exists(todir)) {
    dir.create(todir)
  }
  file.copy(from = from,  to = to)
}

all_files <- dir(here("ensembles", "data-processed"), recursive = TRUE,
                 full.names = TRUE)
from_files <- all_files[!grepl("baseline", all_files)]
to_files <- gsub("europe\\/ensembles\\/", "europe\\/", from_files)


purrr::walk2(.x = from_files, .y = to_files,
            ~ file_copy(.x, .y))

# Re run evaluation using the fresh re-run code from the forecast-eval paper
all_model_eval <- here("code", "papers", "forecast-eval", "data", "2021-08-23-evaluation-all-forecasts.csv")
all_model_eval2 <- gsub("\\.csv", "-original\\.csv", all_model_eval)
file_copy(all_model_eval, all_model_eval2)

# run evaluation
source(here("code", "papers", "forecast-eval", "R", "re-run-eval.R"))

# save evaluation + ensembles to ensemble file
ensemble_eval <- gsub("forecast-eval", "ensemble-eval", all_model_eval)
ensemble_eval <- gsub("all-forecasts\\.csv", "all-models-and-ensembles\\.csv", ensemble_eval)
file.rename(all_model_eval, ensemble_eval)

# remove ensemble eval from forecast file + preserve original forecast eval
file.rename(from = all_model_eval2, to = all_model_eval)
