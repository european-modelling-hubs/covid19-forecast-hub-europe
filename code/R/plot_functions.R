# modify the alpha value of a given color (to generate transparent versions for prediction bands)
modify_alpha <- function(col, alpha){
  x <- col2rgb(col)/255
  rgb(x[1], x[2], x[3], alpha = alpha)
}

# function to add a forecast to the plot
# Arguments:
# forecasts_to_plot: the data.frame data_to_plot containing the relevant forecasts
# timezero: forecasts from which date are to be shown?
# model: the model from which forecasts are to be shown
# add_points: are point forecasts to be shown as dots?
# add_intervals: are forecast intervals to be shown as shaded areas?
# add_past: are last two past values to be shown if they are available?
# pch: the point shape for point forecasts
# col: the colour
# alpha.col: the degree of transparenca for shaded areas
add_forecast_to_plot <- function(forecasts_to_plot,
                                 timezero = NULL,
                                 horizon = NULL,
                                 location,
                                 target,
                                 model,
                                 shift_to = NULL,
                                 add_points = TRUE,
                                 add_intervals.95 = TRUE,
                                 add_intervals.50 = FALSE,
                                 add_past = FALSE,
                                 pch = 21,
                                 col = "blue",
                                 alpha.col = 0.3,
                                 tolerance_retrospective = 1000){

  if((is.null(timezero) & is.null(horizon)) |
     (!is.null(timezero) & ! is.null(horizon))){
    cat("Please specify exactly one out of timezero and horizon.")
  }

  # -1 wk ahead causes trouble when matching horizon 1 wk, thus remove
  if(!is.null(horizon)) forecasts_to_plot <- subset(forecasts_to_plot, !grepl("-1 wk ahead", target))

  # restrict to forecasts where difference between commit date and timezero
  # is within a certain tolerance:
  # still causes errors when commit_date NA
  # forecasts_to_plot <- forecasts_to_plot[(forecasts_to_plot$first_commit_date -
  #                                          forecasts_to_plot$timezero) < tolerance_retrospective, ]

  # shift to desired truth data source if specified:
  if(!is.null(shift_to)){
    if(shift_to == "ECDC") forecasts_to_plot$value <- forecasts_to_plot$value + forecasts_to_plot$shift_ECDC
    if(shift_to == "JHU") forecasts_to_plot$value <- forecasts_to_plot$value + forecasts_to_plot$shift_JHU
  }

  selection_target <- grepl(paste(horizon, target), forecasts_to_plot$target) # target matched target against either only "type"
  # of target (death or case) or also horizon
  selection_timezero <- if(is.null(timezero)){
    rep(TRUE, nrow(forecasts_to_plot))
  }else{
    forecasts_to_plot$timezero == timezero
  }

  # shaded areas for forecast intervals:
  # obtain transparent colour
  col_transp <- modify_alpha(col, alpha.col)

  if(add_intervals.95){
    # get upper bounds:
    subs_upper <- forecasts_to_plot[which(forecasts_to_plot$model == model &
                                            selection_target &
                                            forecasts_to_plot$location == location &
                                            selection_timezero &
                                            forecasts_to_plot$type %in% c("quantile", "observed") &
                                            (forecasts_to_plot$quantile == 0.975 | is.na(forecasts_to_plot$quantile))), ]
    subs_upper <- subs_upper[order(subs_upper$target_end_date), ]
    # get lower bounds:
    subs_lower <- forecasts_to_plot[which(forecasts_to_plot$model == model &
                                            selection_target &
                                            selection_timezero &
                                            forecasts_to_plot$location == location &
                                            forecasts_to_plot$type %in% c("quantile", "observed") &
                                            (forecasts_to_plot$quantile == 0.025 | is.na(forecasts_to_plot$quantile))), ]
    subs_lower <- subs_lower[order(subs_lower$target_end_date), ]

    plot_weekly_bands(dates = subs_upper$target_end_date, lower = subs_lower$value, upper = subs_upper$value,
                      col = col_transp, border = NA, separate_all = !is.null(horizon))
  }

  if(add_intervals.50){
    # get upper bounds:
    subs_upper <- forecasts_to_plot[which(forecasts_to_plot$model == model &
                                            selection_target &
                                            forecasts_to_plot$location == location &
                                            selection_timezero &
                                            forecasts_to_plot$type %in% c("quantile", "observed") &
                                            (forecasts_to_plot$quantile == 0.75 | is.na(forecasts_to_plot$quantile))), ]
    subs_upper <- subs_upper[order(subs_upper$target_end_date), ]
    # get lower bounds:
    subs_lower <- forecasts_to_plot[which(forecasts_to_plot$model == model &
                                            selection_target &
                                            selection_timezero &
                                            forecasts_to_plot$location == location &
                                            forecasts_to_plot$type %in% c("quantile", "observed") &
                                            (forecasts_to_plot$quantile == 0.25 | is.na(forecasts_to_plot$quantile))), ]
    subs_lower <- subs_lower[order(subs_lower$target_end_date), ]

    plot_weekly_bands(dates = subs_upper$target_end_date, lower = subs_lower$value, upper = subs_upper$value,
                      col = col_transp, border = NA, separate_all = !is.null(horizon))
  }

  # points for point forecasts:
  if(add_points){
    if(is.na(pch)) pch <- 0 # if truth data is unknown: set to squares

    # if plotting by forecast date:
    if(!is.null(timezero)){
      # select the relevant points:
      subs_points_truth <- forecasts_to_plot[which(forecasts_to_plot$model == model &
                                                     selection_target &
                                                     selection_timezero &
                                                     forecasts_to_plot$location == location &
                                                     forecasts_to_plot$type %in% c("point", "observed")), ]
      subs_points_truth <- subs_points_truth[order(subs_points_truth$target_end_date), ]
      # draw points
      points(subs_points_truth$target_end_date, subs_points_truth$value, col = col,
             pch = pch, lwd = 2, type = "b")
    }

    # if plotting by horizon:
    if(!is.null(horizon)){
      subs_points <- forecasts_to_plot[which(forecasts_to_plot$model == model &
                                               selection_target &
                                               selection_timezero &
                                               forecasts_to_plot$location == location &
                                               forecasts_to_plot$type %in% c("point")), ]
      subs_truths <- forecasts_to_plot[which(forecasts_to_plot$model == model &
                                               grepl(paste("0 wk ahead", target), forecasts_to_plot$target) &
                                               selection_timezero &
                                               forecasts_to_plot$location == location &
                                               forecasts_to_plot$type %in% c("observed")), ]
      subs_points_truths <- rbind(subs_points, subs_truths)

      lines_by_timezero(subs_points_truths, type = "b", pch = NA, col = col, lwd = 1, lty = "dotted")
      points(subs_points$target_end_date, subs_points$value, col = col, lwd = 2)
    }
  }
}

lines_by_timezero <- function(forecasts, ...){
  timezeros <- unique(forecasts$timezero)
  for(i in seq_along(timezeros)){
    subs <- subset(forecasts, timezero == timezeros[i])
    subs <- subs[order(subs$target_end_date), ]
    lines(subs$target_end_date, subs$value, ...)
  }
}

# create an empty plot to which forecasts can be added
# Arguments:
# start: left xlim
# end: right xlim
# ylim
empty_plot <- function(start = as.Date("2020-03-01"), target = "cum death",
                       end = Sys.Date() + 28, ylim = c(0, 100000)){
  dats <- seq(from = round(start) - 14, to = round(end) + 14, by = 1)

  plot(NULL, ylim = ylim, xlim = c(start, end),
       xlab = "time", ylab = "", axes = FALSE)

  yl <- switch (target,
                "cum death" = "cumulative deaths",
                "inc death" = "incident deaths",
                "inc case" = "incident cases",
                "cum case" = "cumulative cases",
                "wis" = "WIS or absolute error"
  )
  title(ylab = yl, line = 3.5)
  xlabs <- dats[weekdays(dats) == "Saturday"]
  abline(v = xlabs, col = "grey")

  # horizontal ablines:
  abline(h = axTicks(2), col = "grey")

  axis(1, at = xlabs, labels = xlabs, cex = 0.7)
  axis(2)
  graphics::box()
}

# add a truth curve to plot:
# Arguments:
# truth: data.frame containing dates and truth values
# timezero: the forecast date considered (truths to the right of this date are shown in grey)
# pch: the point shape
add_truth_to_plot <- function(truth, target, location, timezero, pch){
  truth <- truth[weekdays(truth$date) == "Saturday" &
                   truth$location == location, ]
  inds_obs <-  if(is.null(timezero)){
    rep(TRUE, nrow(truth))
  }else{
    which(truth$date < timezero)
  }
  inds_unobs <- which(truth$date > timezero)
  ind_last <- which(truth$date == timezero - 2)
  lines(truth$date[c(ind_last, inds_unobs)], truth[c(ind_last, inds_unobs), target],
        col = "grey25", lwd = 2)
  points(truth$date[c(ind_last, inds_unobs)], truth[c(ind_last, inds_unobs), target],
         pch = pch, col = "grey25", bg = "white", lwd = 2)
  lines(truth$date[inds_obs], truth[inds_obs, target], lwd = 2)
  points(truth$date[inds_obs], truth[inds_obs, target],
         pch = pch, bg = "white", lwd = 2)
}

# add a lighgrey bar to highlight the forecast date:
highlight_timezero <- function(timezero, ylim = c(-1000, 100000)){
  rect(xleft = timezero - 3, xright = timezero, ybottom = ylim[1], ytop = ylim[2],
       col = "grey90", border = NA)
  abline(v = timezero - 2, col = "grey")
  abline(v = timezero, lty = 2)
}

# wrapper function to generate entire plot
# Arguments:
# forecasts_to_plot: the data.frame data_to_plot containing the relevant forecasts
# truth: named list containing truth data.frames
# timezero: the timezero if showing forecasts by when they were issued
# horizon: the horizon if showing forecasts by horizon
# NOTE; Only one out of timezero and horizon can be specified
# location: which location is to be shown?
# models: the model sfrom which forecasts are to be shown
# selected_truth: names of the truth data sets to be shown
# start: left xlim
# end: right xlim
# ylim
# show_pi: should forecast bands be shown?
# add_model_past: are last two past values to be shown if they are available?
# truth_data_used: data.frame mapping models to the used truth data
# cols: colours
# alpha.col: the degree of transparenca for shaded areas
# pch.truths: the point shape for point forecasts
# legend: should a legend be added
# add_points: are point forecasts to be shown as dots?
# highlight_target_end_date: target_end_date to highlight (when user hovers over it)
# point_pred_legend: text to paste into the legend (can be used to show point forecasts)
plot_forecasts <- function(forecasts_to_plot, truth,
                           target = "cum death",
                           timezero = NULL,
                           horizon = NULL,
                           models,
                           selected_truth = "both",
                           location = "GM",
                           start = as.Date("2020-03-01"), end = Sys.Date() + 28,
                           ylim = c(0, 100000),
                           add_intervals.95 = TRUE,
                           add_intervals.50 = FALSE,
                           add_model_past = FALSE,
                           truth_data_used = NA,
                           cols, alpha.col = 0.5,
                           pch_truths,
                           pch_forecasts,
                           legend = TRUE,
                           highlight_target_end_date = NULL,
                           point_pred_legend = NULL,
                           tolerance_retrospective = 1000){
  # fresh plot:
  empty_plot(start = start, target = target, end = end, ylim = ylim)
  # highlight the forecast date:
  if(!is.null(timezero)){
    highlight_timezero(timezero, ylim = ylim + c(-1, 1)*diff(ylim))
  }
  abline(v = highlight_target_end_date)

  # should forecasts be shifted in plot and if yes, to which truth data source?
  shift_to <- if(selected_truth == "both") NULL else selected_truth

  # add forecast bands:
  if(length(models) > 0){
    for(i in seq_along(models)){
      add_forecast_to_plot(forecasts_to_plot = forecasts_to_plot,
                           target = target,
                           timezero = timezero,
                           horizon = horizon,
                           shift_to = shift_to,
                           location = location,
                           model = models[i],
                           add_intervals.95 = add_intervals.95,
                           add_intervals.50 = add_intervals.50,
                           add_past = FALSE, add_points = FALSE,
                           col = cols[i],
                           tolerance_retrospective = tolerance_retrospective)
    }
  }

  # add truths:
  if(selected_truth %in% c("ECDC", "both")){
    add_truth_to_plot(truth = truth[["ECDC"]], target = target,
                      location = location, timezero = timezero,
                      pch = pch_truths["ECDC"])
  }
  if(selected_truth %in% c("JHU", "both")){
    add_truth_to_plot(truth = truth[["JHU"]], target = target,
                      location = location, timezero = timezero,
                      pch = pch_truths["JHU"])
  }

  # add point forecasts:
  if(length(models) > 0){
    for(i in seq_along(models)){
      add_forecast_to_plot(forecasts_to_plot = forecasts_to_plot,
                           target = target,
                           timezero = timezero,
                           location = location,
                           horizon = horizon,
                           shift_to = shift_to,
                           model = models[i],
                           add_points = TRUE,
                           add_intervals.95 = FALSE,
                           add_intervals.50 = FALSE,
                           pch = pch_forecasts[truth_data_used[models[i]]],
                           add_past = add_model_past, col = cols[i],
                           tolerance_retrospective = tolerance_retrospective)
    }
  }

  # add legends:
  if(legend){
    legend("topleft", col = cols, pch = 21, legend = paste0(models, ":", point_pred_legend),
           lwd = 2, lty = 0, bty = "n")
  }

}

# helper function to split a vector into a list of vectors, splitting
# whenever diff > step
# needed to plot band which are interrupted when teams do not forecast a given week
# Arguments:
# x: the vector
# step: the "usual" difference between two subsequent values usually 7 days. Split if exceeded.
split_indices_at_gaps <- function(x, step = 7){
  indices <- seq_along(x)
  ret <- list()
  i <- 1
  while(any(diff(x) > step)){
    ret[[i]] <- indices[1:(min(which(diff(x) > step)))]
    x <- tail(x, length(x) - length(ret[[i]]))
    indices <- tail(indices, length(indices) - length(ret[[i]]))
    i <- i + 1
  }
  ret[[i]] <- indices
  return(ret)
}

# Plot one connected forecast band, i.e. where all forecasts are available for a
# row of consecutive weeks
# Arguments:
# dates: the dates, i.e. x-values
# lower, upper: coordinates of the lower and upper end of the forecast band.
plot_one_band <- function(dates, lower, upper, width = 4, shift = 0, ...){
  if(length(dates) == 1){
    dates <- c(dates - width/2, dates, dates + width/2) + shift
    lower <- rep(lower, 3)
    upper <- rep(upper, 3)
  }
  polygon(c(dates, rev(dates)), c(lower, rev(upper)), ...)
}

# Plot forecast bands for weekly forecasts where there is potentially a gap in covered
# forecast dates
# Arguments:
# dates: the dates
# lower, upper: coordinates of the lower and upper end of the forecast band.
# separate_all: Show separate rectangles for each forecast rather than a connected band
# This is currently used when displaying forecasts by horizon
plot_weekly_bands <- function(dates, lower, upper, separate_all = FALSE, ...){
  indices <- split_indices_at_gaps(as.numeric(dates),
                                   step = ifelse(separate_all, 1, 7))
  for(i in 1:length(indices)){
    plot_one_band(dates[indices[[i]]],
                  lower[indices[[i]]],
                  upper[indices[[i]]], ...)
  }
}


# Plot scores (WIS and AE)
# Arguments:
# scores: the data.frame containing all scores
# target: the target
# timezero: the timezero if showing forecasts by when they were issued
# horizon: the horizon if showing forecasts by horizon
# NOTE; Only one out of timezero and horizon can be specified
# models: the models to be shown
# location: the selected location
# start: left xlim
# end: right xlim
# cols: colours
# alpha.col: the degree of transparenca for shaded areas
#mshifts: the horizontal shifts for scores from different models
plot_scores <- function(scores,
                        target  ="cum death",
                        timezero = NULL, horizon = NULL,
                        selected_truth,
                        models,
                        location = "GM",
                        start = as.Date("2020-03-01"), end = Sys.Date() + 28,
                        cols,
                        alpha.col = 0.5,
                        width = 0.8,
                        location_legend = "left",
                        display = "temporal",
                        shifts = c(0, 2, -2, 1, -1),
                        shift.coverage = 0.2){


  if(!selected_truth %in% names(scores)){
    plot(NULL, xlim = 0:1, ylim = 0:1, axes = FALSE, xlab = "", ylab = "")
    legend("center", legend = "Evaluation requires selecting a preferred truth data source.")
  }else{
    # select scores for the chosen truth data source:
    scores <- scores[[selected_truth]]

    # some subsetting to be able to compute ylim:

    # logic vector describing which rows contain correct target; removing 0 wk ahead
    selection_target <- grepl(paste(horizon, target), scores$target) &
      !grepl("0 wk ahead", scores$target)
    # logic vector describing which rows contain correct timezero
    # all TRUE if forecasts shown by horizon
    selection_timezero <- if(is.null(timezero)){
      rep(TRUE, nrow(scores))
    }else{
      scores$timezero == timezero
    }

    # select relevant subset of scores data:
    scores <- scores[which(scores$model %in% models &
                             selection_target &
                             scores$location == location &
                             scores$target_end_date >= start & # restrict to selected window
                             scores$target_end_date <= end &
                             selection_timezero), ]

    if(display == "temporal"){
      # compute ylim:
      yl <- c(0, 1.2*max(c(10, scores$wis, scores$ae), na.rm = TRUE))

      # initialize empty plot:
      empty_plot(start = start, target = "wis", end = end, ylim = yl)

      # add scores per model:
      if(length(models) <= 5){
        for(i in seq_along(models)){
          add_scores_to_plot(scores = scores,
                             target = target,
                             timezero = timezero, horizon = horizon,
                             model = models[i],
                             location = location,
                             col = cols[i], alpha.col = alpha.col,
                             shift = shifts[i], width = width)
        }
      }else{
        # message to select less models if too many selected
        legend("center", legend = "Evaluation can be shown for at most five models. Please select fewer models.")
      }

      # add legend:
      legend(location_legend, legend = c("Absolute error", "",
                                         "Decomposition of WIS:", "penalties for under-prediction",
                                         "spread of forecasts", "penalties for over-prediction"),
             pch = c(5, NA, NA, 22, 22, 22),
             pt.bg = c(NA, NA, NA, modify_alpha("black", 0.3), "black", "white"), bty = "n")
    }

    if(display == "PIT"){
      if(length(models) > 1) stop("Please select exactly one model if display == 'PIT'")
      hist((scores$pit_lower + scores$pit_upper)/2, main = "", xlab = "PIT",
           ylab = "rel. frequency", freq = TRUE, breaks = 0:10/10, col = cols)
    }

    if(display == "coverage"){
      # define variables for coverage per forecast:
      scores$coverage.0.5 <- (scores$truth >= scores$value.0.25 & scores$truth <= scores$value.0.75)
      scores$coverage.0.95 <- (scores$truth >= scores$value.0.025 & scores$truth <= scores$value.0.975)

      # compute coverage proportion:
      mean_scores <- aggregate(cbind(coverage.0.5, coverage.0.95) ~ model,
                               data = scores,
                               FUN = mean)

      # initialize plot
      plot(NULL, xlim = c(-2, length(models) + 3), ylim = c(0, 1),
           xlab = "model", ylab = "empirical coverage", axes = FALSE)
      axis(2); graphics::box()
      abline(h = c(0.5, 0.95), lty = 3)
      # add coverages:
      for(i in 1:length(models)){
        ind <- which(mean_scores$model == models[i])
        points(i - shift.coverage, mean_scores$coverage.0.5[ind], col = cols[i], type = "h", lwd = 5)
        points(i + shift.coverage, mean_scores$coverage.0.95[ind], col = modify_alpha(cols[i], alpha = alpha.col), type = "h", lwd = 5)
      }
    }

    if(display == "average_scores"){
      mean_scores <- aggregate(cbind(wgt_iw, wgt_pen_l, wgt_pen_u, wis, ae) ~ model,
                data = scores,
                FUN = mean, na.action = na.pass, na.rm = TRUE)
      plot(NULL, xlim = c(-2, length(models) + 3), ylim = c(0, 1.3*max(c(mean_scores$ae, mean_scores$wis), na.rm = TRUE)),
           xlab = "model", ylab = "average WIS or AE", axes = FALSE)
      # horizontal ablines:
      abline(h = axTicks(2), col = "grey")
      axis(2); graphics::box()

      for(i in 1:length(models)){
        ind <- which(mean_scores$model == models[i])
        if(length(ind > 0)){
          add_score_decomp(x = i, pen_l = mean_scores$wgt_pen_l[ind],
                           pen_u = mean_scores$wgt_pen_u[ind],
                           iw = mean_scores$wgt_iw[ind],
                           col = cols[i])
          points(i, mean_scores$ae[ind], col = cols[i], lwd = 2, pch = 23, bg = "white")
        }
      }
    }

  }
}

# Adding scores for a given model to the plot:
# Arguments:
# scores: the data.frame containing the scores
# target: the target
# timezero: the timezero if showing forecasts by when they were issued
# horizon: the horizon if showing forecasts by horizon
# NOTE; Only one out of timezero and horizon can be specified
# model: the model for which to add scores to plot
# location: the selected location
# col: color
# alpha.col: alpha value for lighter/transparent colur used in upper "bin"
# shift: horizontal shift to avoid overplotting
add_scores_to_plot <- function(scores, target  ="cum death",
                               timezero = NULL, horizon = NULL,
                               model,
                               location = "GM",
                               col = "black", alpha.col = 0.5, shift = 0, width = 0.8){

  # logic vector indicating which rows contain relevant target
  # target matched against either only "type" of target (death or case) or also horizon.
  # moreover exclude 0 wk ahead
  selection_target <- grepl(paste(horizon, target), scores$target) &!grepl("0 wk ahead", scores$target)
  # logic vector indicating which rows contain relevant timezero
  selection_timezero <- if(is.null(timezero)){
    rep(TRUE, nrow(scores))
  }else{
    scores$timezero == timezero
  }

  # select relevant rows of score data:
  scores <- scores[which(scores$model == model &
                           selection_target &
                           scores$location == location &
                           selection_timezero), ]

  # add little barplots for scores
  for(i in seq_along(scores$target_end_date)){
    add_score_decomp(x = scores$target_end_date[i] + shift,
                     pen_l = scores$wgt_pen_l[i],
                     pen_u = scores$wgt_pen_u[i],
                     iw = scores$wgt_iw[i], col = col, width = width)
  }
  # add points for absolute errors:
  points(scores$target_end_date + shift, scores$ae, pch = 23, col = col, bg = "white",
         lwd = 3, cex = 1.1)
}

# Helper function to show WIS decomposition using little stackec barplots.
# Arguments:
# x: the x values, typically dates
# pen_l: penalties for overprediction
# pen_u: penalties for underprediction
# iw: average interval widths
# col: color
# alpha.col: alpha value for lighter/transparent colur used in upper "bin"
# width: the width of the bar
add_score_decomp <- function(x, pen_l, pen_u, iw, col, alpha.col = 0.3, width = 0.8){
  # generate transparent color
  col_transp <- modify_alpha(col, alpha.col)
  if(!is.na(pen_u)){ # plot only when pen_u is available. Otherwise wi can get plotted even though the others are NA
    # bottom bar: penalty for overprediction
    if(pen_l > 0) rect(xleft = x - width/2, ybottom = 0, xright = x + width/2, ytop = pen_l,
                       col = "white", border = col)
    # middle bar: width of prediction intervals
    rect(xleft = x - width/2, ybottom = pen_l, xright = x + width/2, ytop = pen_l + iw,
         col = col, border = col)
    # top bar: penalty for underprediction
    if(pen_u > 0){
      rect(xleft = x - width/2, ybottom = pen_l + iw, xright = x + width/2, ytop = pen_l + iw + pen_u,
           col = col_transp, border = col)
    }
  }
}
