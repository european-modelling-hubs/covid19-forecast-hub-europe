# get shift between truth data used in a model and the ECDC and JHU data
get_shift <- function(model, dat_truth, truth_data_use, date){

  # merge both truth data sources together:
  both <- merge(dat_truth$ECDC[dat_truth$ECDC$date == date, ],
                dat_truth$JHU[dat_truth$JHU$date == date, ],
                by = c("date", "location", "target"),
                all.x = TRUE, all.y = TRUE)
  colnames(both)[grepl("value", colnames(both))] <- c("value.ECDC", "value.JHU")

  # fill in truth data source used by model and implied truth values
  both$truth_data_source <- both$value_model <- NA
  for(i in 1:nrow(both)){
    truth_used_temp <- get_used_truth(truth_data_use = truth_data_use,
                                      model = model,
                                      location = both$location[i],
                                      date = date)
    both$truth_data_source[i] <- truth_used_temp
    if(!is.na(truth_used_temp)) both$value_model[i] <- both[i, paste0("value.", truth_used_temp)]
  }

  # compute shifts:
  both$shift_ECDC <-  both$value.ECDC - both$value_model
  both$shift_JHU <- both$value.JHU - both$value_model
  ind_cum <- which(grepl("inc", both$target))
  both$shift_ECDC[ind_cum] <- both$shift_JHU[ind_cum] <- 0

  # remove unnecessary columns:
  both$value.ECDC <- both$value.JHU <- NULL
  return(both)
}

# evaluate predictive quantiles:
evaluate_quantiles <- function(forecasts, name_truth_eval, dat_truth,
                               truth_data_use, detailed = FALSE){

  # check that only forecasts from one date are present:
  forecast_date <- unique(forecasts$forecast_date)
  if(length(forecast_date) > 1) stop("multiple forecast dates detected, aborting")

  # subset to quantiles:
  forecasts <- subset(forecasts, type == "quantile")
  if(length(unique(forecasts$quantile)) != 23) stop("Not all quantiles available.")

  # bring into wide format:
  forecasts_wide <- reshape(forecasts, direction = "wide", timevar = "quantile",
                            v.names = "value", idvar = c("location", "target_end_date", "target"))

  # add column stating type of target
  forecasts_wide$target_type <- get_target_type(forecasts_wide$target)
  forecasts_wide$type <- NULL

  # get shift between model and evaluation truth at last observed values:
  last_saturday <- get_last_saturday(forecast_date)
  shift <- get_shift(model = model, dat_truth = dat_truth,
                     truth_data_use = truth_data_use, date = last_saturday)
  shift <- shift[, c("date", "location", "target", "truth_data_source",
                     paste0("shift_", name_truth_eval))]
  colnames(shift)[4:5] <- c("truth_data_model", "shift")

  # add evaluation truths and shift:
  truth_eval <- dat_truth[[name_truth_eval]]
  colnames(truth_eval)[colnames(truth_eval) == "value"] <- "truth"
  forecasts_wide <- merge(forecasts_wide, truth_eval[, c("date", "location", "truth", "target")],
                          by.x = c("target_end_date", "location", "target_type"),
                          by.y = c("date", "location", "target"), all.x = TRUE)
  forecasts_wide <- merge(forecasts_wide, shift,
                          by.x = c("location", "target_type"),
                          by.y = c("location", "target"), all.x = TRUE)

  # shift quantile values for cumulative targets to align with last observed truths:
  forecasts_wide[, grepl("value", colnames(forecasts_wide))] <-
    forecasts_wide[, grepl("value", colnames(forecasts_wide))] + forecasts_wide$shift

  # add name of truth data:
  forecasts_wide$truth_data_eval <- name_truth_eval

  coverage_levels <- c(0:9/10, 0.95, 0.98) # median can be treated like the 0% PI

  # get weighted interval widths. Note that this already contains the weighting with alpha/2
  for(coverage in coverage_levels){
    forecasts_wide[, paste0("wgt_iw_", coverage)] <-
      ifelse(coverage == 0, 0.5, 1)* # need to downweight absolute error here to avoid counting it twice
      (1 - coverage)/2*(
        forecasts_wide[paste0("value.", 1 - (1 - coverage)/2)] -
          forecasts_wide[paste0("value.", (1 - coverage)/2)]
      )
  }

  # get weighted penalties. Note that this already contains the weighting with alpha/2,
  # which makes the terms simpler
  for(coverage in coverage_levels){
    # need to downweight absolute error here to avoid counting it twice
    q_u <- 1 - (1 - coverage)/2
    forecasts_wide[, paste0("wgt_pen_u_", coverage)] <-
      ifelse(coverage == 0, 0.5, 1)*pmax(0, forecasts_wide$truth - forecasts_wide[, paste0("value.", q_u)])

    # need to downweight absolute error here to avoid counting it twice
    q_l <- (1 - coverage)/2
    forecasts_wide[, paste0("wgt_pen_l_", coverage)] <-
      ifelse(coverage == 0, 0.5, 1)*pmax(0, forecasts_wide[, paste0("value.", q_l)] - forecasts_wide$truth)
  }

  # averages:
  forecasts_wide$wgt_iw <- rowSums(forecasts_wide[, grepl("wgt_iw", colnames(forecasts_wide))])/11.5
  forecasts_wide$wgt_pen_u <- rowSums(forecasts_wide[, grepl("wgt_pen_u", colnames(forecasts_wide))])/11.5
  forecasts_wide$wgt_pen_l <- rowSums(forecasts_wide[, grepl("wgt_pen_l", colnames(forecasts_wide))])/11.5
  forecasts_wide$wis <- forecasts_wide$wgt_iw + forecasts_wide$wgt_pen_u + forecasts_wide$wgt_pen_l

  # get PIT values:
  forecasts_wide$pit_lower <- forecasts_wide$pit_upper <- NA
  for(i in 1:nrow(forecasts_wide)){
    pit_temp <- compute_pit_values(truth = forecasts_wide$truth[i],
                                   quantiles = unlist(forecasts_wide[i, grepl("value.0", colnames(forecasts_wide))]),
                                   quantile_levels = c(0.01, 0.025, 1:19/20, 0.975, 0.99))
    forecasts_wide$pit_lower[i] <- pit_temp$pit_lower
    forecasts_wide$pit_upper[i] <- pit_temp$pit_upper
  }

  # select relevant columns:
  if(!detailed) forecasts_wide <- forecasts_wide[, c("forecast_date", "target_end_date", "target", "location",
                                                     "value.0.025", "value.0.25", "value.0.5", "value.0.75", "value.0.975",
                                                     "truth", "truth_data_eval", "truth_data_model", "shift",
                                                     "wgt_iw", "wgt_pen_u", "wgt_pen_l", "wis",
                                                     "pit_lower", "pit_upper")]
  return(forecasts_wide)
}

# compute upper and lower bounds on PIT values
compute_pit_values <- function(truth, quantiles, quantile_levels, tol = 0.001){
  if(is.na(truth)){
    pit_lower <- pit_upper <- NA
  }else{
    quantiles <- c(-Inf, quantiles, Inf)
    quantile_levels <- c(0, quantile_levels, 1)
    ind_lower <- max(which(quantiles + tol < truth))
    pit_lower <- quantile_levels[ind_lower]
    tied <- which(abs(truth - quantiles) < tol)
    if(length(tied) > 0){
      pit_upper <- quantile_levels[max(tied) + 1]
    }else{
      pit_upper <- quantile_levels[ind_lower + 1]
    }
  }
  return(list(pit_lower = pit_lower,
              pit_upper = pit_upper))
}

# evaluate point forecasts
evaluate_point <- function(forecasts, name_truth_eval, dat_truth, truth_data_use){

  # check that only forecasts from one date are present:
  forecast_date <- unique(forecasts$forecast_date)
  if(length(forecast_date) > 1) stop("multiple forecast dates detected, aborting")

  # subset to point forecasts:
  forecasts <- subset(forecasts, type == "point")
  if(nrow(forecasts) == 0) return(NULL) # stop here if no point forecasts available.
  colnames(forecasts)[colnames(forecasts) == "value"] <- "value.point"
  forecasts$target_type <- get_target_type(forecasts$target)
  forecasts$type <- NULL

  # get shift between model and evaluation truth at last observed values:
  last_saturday <- get_last_saturday(forecast_date)
  shift <- get_shift(model = model,
                     dat_truth = dat_truth,
                     truth_data_use = truth_data_use,
                     date = last_saturday)
  shift <- shift[, c("date", "location", "target", "truth_data_source", paste0("shift_", name_truth_eval))]
  colnames(shift)[4:5] <- c("truth_data_model", "shift")

  # add evaluation truths and shift:
  truth_eval <- dat_truth[[name_truth_eval]]
  colnames(truth_eval)[colnames(truth_eval) == "value"] <- "truth"
  forecasts <- merge(forecasts, truth_eval[, c("date", "location", "truth", "target")],
                     by.x = c("target_end_date", "location", "target_type"),
                     by.y = c("date", "location", "target"), all.x = TRUE)
  forecasts <- merge(forecasts, shift,
                     by.x = c("location", "target_type"),
                     by.y = c("location", "target"), all.x = TRUE)

  # shift quantile values:
  forecasts$value.point <- forecasts$value.point + forecasts$shift

  # add name of truth data:
  forecasts$truth_data_eval <- name_truth_eval

  # compute AE:
  forecasts$ae <- abs(forecasts$value.point - forecasts$truth)

  # restrict to relevant columns:
  forecasts <- forecasts[, c("forecast_date", "target_end_date", "target", "location",
                             "value.point",
                             "truth", "truth_data_eval", "truth_data_model", "shift",
                             "ae")]
  return(forecasts)
}

# extract last truths; used to append these to evaluation data.frame
get_last_truths <- function(forecasts, name_truth_eval, dat_truth, truth_data_use){
  # find date of 0 wk ahead forecasts
  last_saturday <- forecasts$target_end_date[grepl("1 wk ahead", forecasts$target)][1] - 7
  # find relevant subset
  targets_to_include <- unique(get_target_type(forecasts$target))
  locations_to_include <- unique(forecasts$location)
  subs_truth <- subset(dat_truth[[name_truth_eval]], date == last_saturday &
                         target %in% targets_to_include &
                         location %in% locations_to_include)

  if(nrow(subs_truth) == 0) return(NULL)

  # initialize data.frame
  ret <- data.frame(forecast_date = forecasts$forecast_date[1],
                    target_end_date = last_saturday,
                    target = paste("0 wk ahead", subs_truth$target),
                    target_type = subs_truth$target,
                    location = subs_truth$location,
                    truth_data_eval = name_truth_eval,
                    truth = subs_truth$value)

  # get shift between model and evaluation truth at last observed values:
  shift <- get_shift(model = model,
                     dat_truth = dat_truth,
                     truth_data_use = truth_data_use,
                     date = last_saturday)
  shift <- shift[, c("date", "location", "target", "truth_data_source", paste0("shift_", name_truth_eval))]
  colnames(shift)[4:5] <- c("truth_data_model", "shift")

  # merge
  ret <- merge(ret, shift,
               by.x = c("location", "target_type"),
               by.y = c("location", "target"), all.x = TRUE)
  ret$target_type <- NULL

  # re-order columns
  ret[, c("value.point", "value.0.025", "value.0.25", "value.0.5", "value.0.75",
          "value.0.975", "ae", "wgt_iw", "wgt_pen_u", "wgt_pen_l", "wis",
          "pit_lower", "pit_upper")] <- NA

  return(ret)
}

# wrapper around evaluation functions for point and quantile forecasts
evaluate_forecasts <- function(forecasts, name_truth_eval, dat_truth, truth_data_use){

  # evaluate point forecasts:
  eval_point <- evaluate_point(forecasts = forecasts,  name_truth_eval = name_truth_eval,
                               dat_truth = dat_truth, truth_data_use = truth_data_use)
  # evaluate quantile forecasts, if any:
  if(any(forecasts$type == "quantile" & length(unique(forecasts$quantile)) >= 23)){
    eval_quantiles <- evaluate_quantiles(forecasts = forecasts,
                                         name_truth_eval = name_truth_eval,
                                         dat_truth = dat_truth,
                                         truth_data_use = truth_data_use,
                                         detailed = FALSE)

    eval_point <- merge(eval_point, eval_quantiles, by = c("forecast_date", "target_end_date", "target",
                                                           "location", "truth_data_eval",
                                                           "truth_data_model", "truth", "shift"),
                        all.x = TRUE, all.y = TRUE)
  }else{
    # add empty columns if no quantile forecasts available:
    eval_point$value.0.025 <- eval_point$value.0.25 <- eval_point$value.0.5 <-
      eval_point$value.0.75 <- eval_point$value.0.975 <- eval_point$wgt_iw <-
      eval_point$wgt_pen_u <- eval_point$wgt_pen_l <-
      eval_point$wis <- eval_point$pit_lower <- eval_point$pit_upper <- NA
  }
  # re-order columns
  eval_point <- eval_point[, c("forecast_date", "target_end_date", "target", "location",
                               "truth_data_eval", "truth_data_model", "truth", "shift",
                               paste0("value.", c("point", "0.025", "0.25", "0.5", "0.75", "0.975")),
                               "ae", "wgt_iw", "wgt_pen_u", "wgt_pen_l", "wis",
                               "pit_lower", "pit_upper")]

  # add last observed values:
  last_truths <- get_last_truths(forecasts = forecasts, name_truth_eval = name_truth_eval,
                                 dat_truth = dat_truth, truth_data_use = truth_data_use)
  last_truths <- last_truths[, colnames(eval_point)]

  eval_point <- rbind(last_truths, eval_point)

  return(eval_point)
}