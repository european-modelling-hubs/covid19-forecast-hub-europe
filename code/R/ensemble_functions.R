# extract the date from a file name in our standardized format
get_date_from_filename <- function(filename){
  as.Date(substr(filename, start = 1, stop = 10))
}

# select correct file
select_file <- function(files, forecast_date, target_type, country, tol = 4){
  if(!target_type %in% c("case", "death")) stop("target_type needs to be from c('death', 'case').")
  # restrict to csv files:
  files <- files[grepl(".csv", files) & grepl(country, files)]

  # restrict to files for respective target:
  if(target_type == "death") files <- files[!grepl("case", files) & !grepl("ICU", files)]
  if(target_type == "case") files <- files[grepl("case", files)]

  # extract dates:
  dates <- get_date_from_filename(files)

  # restrict to dates within in the correct range:
  dates_eligible <- dates[dates %in% (forecast_date - 0:tol)]
  if(length(dates_eligible) == 0) stop("No forecast files found among ",
                                       paste(head(files, 2), collapse = ", "),
                                       "...")
  # choose most current:
  date_selected <- max(dates_eligible)
  return(files[dates == date_selected])
}

# function to get date of last Saturday:
get_last_saturday <- function(forecast_date){
  if(!weekdays(forecast_date) == "Monday") warning("forecast_date should be a Monday.")
  (forecast_date - (0:6))[weekdays(forecast_date - (0:6)) == "Saturday"]
}

# generate ensemble forecast data.frame:
compute_ensemble <- function(forecast_date,
                             location,
                             country,
                             target_type,
                             inc_or_cum,
                             dat_truth,
                             ensemble_type,
                             models_to_include,
                             truth_data_use,
                             eval = NULL,
                             directory_data_processed){
  # some checks:
  if(!ensemble_type %in% c("median", "mean", "inverse_wis")) stop("type needs to be from c('mean', 'median', 'inverse_wis').")
  if(ensemble_type == "inverse_wis" & is.null(eval)) stop("If type == 'inverse_wis', eval needs to be provided.")
  if(weekdays(forecast_date) != "Monday") stop("Forecast date needs to be a Monday (if already the case set language to English).")

  # which models should be included?
  members <- models_to_include$model[models_to_include[, paste0(location, "_", inc_or_cum, "_", target_type)]]

  # read in forecast data:
  for(i in 1:length(members)){
    # select file to load:
    selected_file <- select_file(list.files(paste0(directory_data_processed, "/", members[i])),
                                 forecast_date = forecast_date,
                                 target_type = target_type,
                                 country = country)
    # read in data:
    to_add <- read.csv(paste0("../../data-processed/", members[i], "/", selected_file),
                       colClasses = list(forecast_date = "Date", target_end_date = "Date"))
    # remove location_name as may not be present in all files
    to_add$location_name <- NULL
    # restrict to quantiles for cum death week ahead:
    to_add <- to_add[to_add$target %in% paste(1:4, "wk ahead", inc_or_cum, target_type) &
                       to_add$location %in% location &
                       to_add$type == "quantile", ]
    # add model name:
    to_add$model <- members[i]

    # shift according to truth data source:
    all_shifts <- get_shift(model = members[i],
                            dat_truth = dat_truth,
                            truth_data_use = truth_data_use,
                            date = get_last_saturday(forecast_date))
    shift <- all_shifts[all_shifts$location == location &
                          all_shifts$target == paste(inc_or_cum, target_type), "shift_ECDC"]
    if(length(shift) != 1 |
       (inc_or_cum == "inc" & shift > 0)){
      stop("Something seems to go wrong when shifting forecasts to ECDC data.")
    }
    to_add$value <- to_add$value + shift

    # add to forecasts data.frame:
    if(i == 1){
      forecasts <- to_add
    }else{
      forecasts <- rbind(forecasts, to_add)
    }
  }

  # aggregate:

  # mean ensemble:
  if(ensemble_type == "mean"){
    ensemble <- aggregate(formula = value ~ target + target_end_date + location + type + quantile,
                          data = forecasts, FUN = mean)
  }

  # median ensemble:
  if(ensemble_type == "median"){
    ensemble <- aggregate(formula = value ~ target + target_end_date + location + type + quantile,
                          data = forecasts, FUN = median)
  }

  inverse_wis_weights <- NULL

  # inverse WIS ensemble:
  if(ensemble_type == "inverse_wis"){
    inverse_wis_weights <- get_inverse_wis_weights(forecast_date = forecast_date,
                                                   members = members, eval = eval,
                                                   target_type = target_type, inc_or_cum = inc_or_cum)
    if(nrow(inverse_wis_weights) != length(members)) stop("Weights could not be computed for all member models.")
    forecasts <- merge(forecasts, inverse_wis_weights, by = "model", all.x = TRUE)
    # apply weighting:
    forecasts$value <- forecasts$value * forecasts$inverse_wis_weight
    ensemble <- aggregate(formula = value ~ target + target_end_date + location + type + quantile,
                          data = forecasts, FUN = sum)
  }

  # add point forecasts:
  ensemble_point <- subset(ensemble, abs(quantile - 0.5) < 0.01)
  ensemble_point$type <- "point"
  ensemble_point$quantile <- NA
  ensemble <- rbind(ensemble_point, ensemble)

  # some formatting:
  ensemble$forecast_date <- forecast_date
  ensemble$location_name <- country

  ensemble <- ensemble[, c("forecast_date",	"target",	"target_end_date",	"location",
                           "type",	"quantile",	"value",	"location_name")]

  return(list(ensemble = ensemble, weights = inverse_wis_weights))
}

# get the weights for the inverse WIS ensemble:
get_inverse_wis_weights <- function(forecast_date, members, eval, target_type, inc_or_cum){
  if(weekdays(forecast_date) != "Monday"){
    stop("Forecast date needs to be a Monday (if already the case set language to English).")
  }

  # subset to relevant forecasts:
  eval <- eval[eval$model %in% members &
                 eval$timezero >= forecast_date - 21 &
                 eval$target_end_date <= forecast_date &
                 grepl(inc_or_cum, eval$target) &
                 grepl(target_type, eval$target) &
                 !grepl("0 wk", eval$target) &
                 !grepl("-1 wk", eval$target) &
                 eval$location == location, ]

  # bring to wide format (adds NA for missing WIS values)
  eval$time_identifier <- paste(eval$timezero, eval$target, sep = "_")

  eval_wide <- reshape(eval[, c("model", "time_identifier", "wis")],
                       direction = "wide",
                       v.names = "wis",
                       idvar = "model",
                       timevar = "time_identifier")
  # add models which were missing:
  missing_models <- members[!(members %in% eval_wide$model)]

  eval_wide <- rbind(
    eval_wide,
    cbind(model = missing_models, NA*eval_wide[rep(1, length(missing_models)), -1])
  )


  # fill in worst WIS where missing:
  for(col in colnames(eval_wide)[grepl("wis.", colnames(eval_wide))]){
    eval_wide[is.na(eval_wide[, col]), col] <- max(eval_wide[, col], na.rm = TRUE)
  }

  # ompute averages:
  eval_wide$mean_wis <- rowMeans(eval_wide[, grepl("wis.", colnames(eval_wide)), drop = FALSE])

  # compute weights:
  eval_wide$inverse_wis_weight <- (1/eval_wide$mean_wis)/sum(1/eval_wide$mean_wis)

  # return weights:
  return(eval_wide[, c("model", "inverse_wis_weight")])
}
