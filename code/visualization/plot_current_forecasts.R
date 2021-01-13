# setwd("/home/johannes/Documents/COVID/covid19-forecast-hub-de/code/visualization")

source("../../code/R/plot_functions.R")
source("../../code/R/auxiliary_functions.R")


# set locale to English:
Sys.setlocale(category = "LC_TIME", locale = "en_US.UTF8")

# names of models which are not to be included in visualization:
models_to_exclude <- c("LeipzigIMISE-rkiV1", "LeipzigIMISE-ecdcV1", "Imperial-ensemble1", 
                       "KITCOVIDhub-mean_ensemble", "KIT-time_series_baseline", 
                       "KITCOVIDhub-inverse_wis_ensemble", "epiforecasts-EpiNow2_secondary")

# read in forecasts:
forecasts_to_plot <- read.csv("https://raw.githubusercontent.com/KITmetricslab/covid19-forecast-hub-de/master/app_forecasts_de/data/forecasts_to_plot.csv",
                              stringsAsFactors = FALSE, colClasses = list(timezero = "Date", forecast_date = "Date", target_end_date = "Date"))
# exclude some models:
forecasts_to_plot <- subset(forecasts_to_plot, !(model %in% models_to_exclude) &
                              !grepl("-1", target) &
                                    !grepl("3", target) &
                                    !grepl("4", target))

# get timezeros, i.e. Mondays on which forecasts were made:
timezeros <- as.character(sort(unique(forecasts_to_plot$timezero), decreasing = TRUE))

# get names of models which appear in the data:
models <- sort(as.character(unique(forecasts_to_plot$model)))
target <- "inc death"


# get truth data:
dat_truth <- list()
dat_truth$JHU <- read.csv("https://raw.githubusercontent.com/KITmetricslab/covid19-forecast-hub-de/master/app_forecasts_de/data/truth_to_plot_jhu.csv",
                          colClasses = list("date" = "Date"))
colnames(dat_truth$JHU) <- gsub("inc_", "inc ", colnames(dat_truth$JHU)) # for matching with targets
colnames(dat_truth$JHU) <- gsub("cum_", "cum ", colnames(dat_truth$JHU)) # for matching with targets


dat_truth$ECDC <- read.csv("https://raw.githubusercontent.com/KITmetricslab/covid19-forecast-hub-de/master/app_forecasts_de/data/truth_to_plot_ecdc.csv",
                           colClasses = list("date" = "Date"))
colnames(dat_truth$ECDC) <- gsub("inc_", "inc ", colnames(dat_truth$ECDC)) # for matching with targets
colnames(dat_truth$ECDC) <- gsub("cum_", "cum ", colnames(dat_truth$ECDC)) # for matching with targets


# define point shapes for different truth data sources:
truths <- names(dat_truth)
pch_full <- c(17, 16)
pch_empty <- c(2, 1)
names(pch_full) <- names(pch_empty) <- truths

# get data on which model uses which truth data:
truth_data_used0 <- read.csv("https://raw.githubusercontent.com/KITmetricslab/covid19-forecast-hub-de/master/app_forecasts_de/data/truth_data_use.csv",
                             stringsAsFactors = FALSE)
truth_data_used <- truth_data_used0$truth_data
names(truth_data_used) <- truth_data_used0$model

dates <- seq(from = Sys.Date() - 7, to = Sys.Date() - 1, by = 1)
timezero <- dates[which(weekdays(dates) == "Monday")]

# subset forecasts to those for the shown forecast date:
subs_current_GM <- forecasts_to_plot[forecasts_to_plot$forecast_date >= (timezero - 7) &
                                    grepl(target, forecasts_to_plot$target) &
                                    forecasts_to_plot$location == "GM", ]
subs_current_PL <- forecasts_to_plot[forecasts_to_plot$forecast_date >= (timezero - 7) &
                                       grepl(target, forecasts_to_plot$target) &
                                       forecasts_to_plot$location == "PL", ]
# get last truth values shown in plot:
last_truths_GM <- dat_truth[["ECDC"]][[target]][dat_truth$ECDC$date >= Sys.Date() - 32 &
                                                 dat_truth$ECDC$location == "GM"]
last_truths_PL <- dat_truth[["ECDC"]][[target]][dat_truth$ECDC$date >= Sys.Date() - 32 &
                                                  dat_truth$ECDC$location == "PL"]

# compute ylim from these values:
ylim_GM <- c(0, 1.05*min(max(subs_current_GM$value, na.rm = TRUE),
                                                1.5*max(subs_current_GM$value[subs_current_GM$type == "point"], na.rm = TRUE)))
ylim_PL <- c(0, 1.05*min(max(subs_current_PL$value, na.rm = TRUE),
                                                1.5*max(subs_current_PL$value[subs_current_GM$type == "point"], na.rm = TRUE)))

# get model names:
models_GM <- unique(subs_current_GM$model)
models_PL <- unique(subs_current_PL$model)

# re-order to bring ensemble to the end:
models_GM <- c(models_GM[!grepl("KITCOVIDhub", models_GM)], "KITCOVIDhub-median_ensemble")
models_PL <- c(models_PL[!grepl("KITCOVIDhub", models_PL)], "KITCOVIDhub-median_ensemble")

# colors:
cols_GM <- ifelse(grepl("KITCOVIDhub", models_GM), "red", "lightgrey")
cols_PL <- ifelse(grepl("KITCOVIDhub", models_PL), "red", "lightgrey")

png("current_forecasts.png", width = 800, height = 800)
par(mar = c(4.5, 5.5, 4.5, 2), mfrow = 2:1, las = 1)
# plot:
plot_forecasts(forecasts_to_plot = forecasts_to_plot,
               truth = dat_truth,
               target = target,
               timezero = timezero,
               models = models_GM,
               location = "GM",
               truth_data_used = truth_data_used,
               selected_truth = c("both"),
               start = Sys.Date() - 32,
               end = Sys.Date() + 28,
               ylim = ylim_GM,
               col = cols_GM,
               alpha.col = 0.5,
               pch_truths = pch_full,
               pch_forecasts = pch_empty,
               legend = FALSE,
               add_intervals.95 = TRUE,
               add_intervals.50 = FALSE,
               add_model_past = FALSE)
title("Forecasts of weekly incident deaths from COVID19 in Germany")
# add legends manually:
legend("topleft", col = c("red", "lightgrey"), legend = c("median ensemble", "contributed forecasts"), lty = 0, bty = "n",
       pch = pch_full[truth_data_used[models_PL]],
       pt.cex = 1.3, ncol = 2)

legend("left", col = "black", legend = c("ECDC/RKI", "JHU"), lty = 0, bty = "n",
       pch = pch_full, pt.cex = 1.3)

plot_forecasts(forecasts_to_plot = forecasts_to_plot,
               truth = dat_truth,
               target = target,
               timezero = timezero,
               models = models_PL,
               location = "PL",
               truth_data_used = truth_data_used,
               selected_truth = c("both"),
               start = Sys.Date() - 32,
               end = Sys.Date() + 28,
               ylim = ylim_PL,
               col = cols_PL,
               alpha.col = 0.5,
               pch_truths = pch_full,
               pch_forecasts = pch_empty,
               legend = FALSE,
               add_intervals.95 = TRUE,
               add_intervals.50 = FALSE,
               add_model_past = FALSE)

# add legends manually:
legend("topleft", col = c("red", "lightgrey"), legend = c("median ensemble", "contributed forecasts"), lty = 0, bty = "n",
       pch = pch_full[truth_data_used[models_PL]],
       pt.cex = 1.3, ncol = 2)

legend("left", col = "black", legend = c("ECDC/RKI", "JHU"), lty = 0, bty = "n",
       pch = pch_full, pt.cex = 1.3)
title("Forecasts of weekly incident deaths from COVID19 in Poland")
dev.off()

