Sys.setlocale(category = "LC_TIME", locale = "en_US.UTF8")

# setwd("/home/johannes/Documents/COVID/covid19-forecast-hub-de/evaluation")
source("../code/R/evaluation_functions.R")
source("../code/R/auxiliary_functions.R")


# select truth data ource to be used for evaluation:
truth_eval <- "ECDC"


# get truth data:
dat_truth <- list()
dat_truth$JHU <- truth_to_long(read.csv("https://raw.githubusercontent.com/KITmetricslab/covid19-forecast-hub-de/master/app_forecasts_de/data/truth_to_plot_jhu.csv",
                                        colClasses = list("date" = "Date")))
dat_truth$ECDC <- truth_to_long(read.csv("https://raw.githubusercontent.com/KITmetricslab/covid19-forecast-hub-de/master/app_forecasts_de/data/truth_to_plot_ecdc.csv",
                                         colClasses = list("date" = "Date")))

# get data on truth data use:
truth_data_use <- read.csv("https://raw.githubusercontent.com/KITmetricslab/covid19-forecast-hub-de/master/app_forecasts_de/data/truth_data_use_detailed.csv",
                           stringsAsFactors = FALSE, colClasses = list("starting_from"  ="Date"))

# get names of models:
models <- unique(truth_data_use$model)

for(truth_eval in c("ECDC", "JHU")){
  evaluations <- NULL

  for(model in models){
    cat("Starting", model, " / ", truth_eval, "\n")
    path <- paste0("../data-processed/", model)
    files <- list.files(path)
    files <- files[grepl(".csv", files) & grepl("20", files)]

    # evaluate death forecasts:
    files_death <- files[!grepl("case", files) & !grepl("ICU", files)]
    forecast_dates_death <- get_date_from_filename(files_death)
    files_death <- files_death[forecast_dates_death %in% choose_relevant_dates(forecast_dates_death)]

    for(i in seq_along(files_death)){
      # read in forecasts:
      forecasts <- read_week_ahead(paste0(path, "/", files_death[i]))
      forecasts$X <- NULL # remove row numbers if necessary

      # evaluate:
      # undebug(evaluate_forecasts)
      if(nrow(forecasts) > 0){
        eval_temp <- evaluate_forecasts(forecasts,
                                        name_truth_eval = truth_eval,
                                        dat_truth = dat_truth,
                                        truth_data_use = truth_data_use)
        eval_temp <- cbind(model = model,
                           timezero = next_monday(get_date_from_filename(files_death[i])),
                           eval_temp)

        if(is.null(eval)){
          evaluations <- eval_temp
        }else{
          evaluations <- rbind(evaluations, eval_temp)
        }
      }
    }

    # evaluate case forecasts:
    files_case <- files[grepl("case", files)]
    forecast_dates_case <- get_date_from_filename(files_case)
    files_case <- files_case[forecast_dates_case %in% choose_relevant_dates(forecast_dates_case)]

    for(i in seq_along(files_case)){
      # read in forecasts:
      forecasts <- read_week_ahead(paste0(path, "/", files_case[i]))
      forecasts$X <- NULL # remove row numbers if necessary

      # evaluate:
      if(nrow(forecasts) > 0){
        eval_temp <- evaluate_forecasts(forecasts,
                                        name_truth_eval = truth_eval,
                                        dat_truth = dat_truth, 
                                        truth_data_use = truth_data_use)
        eval_temp <- cbind(model = model,
                           timezero = next_monday(get_date_from_filename(files_case[i])),
                           eval_temp)

        if(is.null(eval)){
          evaluations <- eval_temp
        }else{
          evaluations <- rbind(evaluations, eval_temp)
        }
      }
    }
  }

  # write out:
  cat("Writing out", truth_eval, "\n")
  write.csv(evaluations, file = paste0("evaluation-", truth_eval, ".csv"), row.names = FALSE)
}
