setwd("/home/johannes/Documents/COVID/covid19-forecast-hub-de/app_forecasts_de")
source("code/app_functions.R")

Sys.setlocale(category = "LC_TIME", locale = "en_US.UTF8")

# get overview on processed files:
models <- list.dirs("../data-processed", recursive = FALSE, full.names = FALSE)
models <- c("Geneva-DeterministicGrowth", "LANL-GrowthRate", "MIT-CovidAnalytics-DELPHI",
            "Imperial-ensemble1", "Imperial-ensemble2", "YYG-ParamSearch")

available_dates <- relevant_dates <- list()

for(m in models){
  temp <- get_date_from_filename(list.files(paste0("../data-processed/", m)))
  available_dates[[m]] <- temp[!is.na(temp)]
  relevant_dates[[m]] <- choose_relevant_dates(available_dates[[m]])
}

# read in forecasts from relevant files:
forecasts_to_plot <- NULL
for(m in models){
  for(d in seq_along(relevant_dates[[m]])){
    temp <- read.csv(paste0("../data-processed/", m, "/",
                            relevant_dates[[m]][d], "-Germany-", m, ".csv"),
                     stringsAsFactors = FALSE)
    temp$forecast_date <- as.Date(temp$forecast_date)
    temp$target_end_date <- as.Date(temp$target_end_date)
    temp <- subset(temp, target %in% paste(-1:4, "wk ahead cum death") &
                     (quantile %in% c(0.025, 0.975) | type == "point" | type == "observed"))
    temp$timezero <- next_monday(temp$forecast_date)
    temp$model <- m

    if(is.null(forecasts_to_plot)){
      forecasts_to_plot <- temp
      forecasts_to_plot <-
        forecasts_to_plot[, colnames(forecasts_to_plot)[colnames(forecasts_to_plot) != "location_name"]]
    }else{
      temp <- temp[, colnames(forecasts_to_plot)]
      forecasts_to_plot <- rbind(forecasts_to_plot, temp)
    }
    print(nrow(forecasts_to_plot))
  }
}

write.csv(forecasts_to_plot, file = "data/forecasts_to_plot.csv", row.names = FALSE)
