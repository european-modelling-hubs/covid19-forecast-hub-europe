# read in week-ahead forecasts from a file
read_week_ahead <- function(file){
  dat <- read.csv(file, colClasses = c(location = "character", forecast_date = "Date", target_end_date = "Date"), stringsAsFactors = FALSE)
  return(subset(dat, target %in% c(paste(1:4, "wk ahead inc death"), paste(1:4, "wk ahead cum death"),
                                   paste(1:4, "wk ahead inc case"), paste(1:4, "wk ahead cum case"))))
}

# get the subset of a forecast file needed for plotting:
subset_forecasts_for_plot <- function(forecasts, forecast_date = NULL, target_type, horizon, location, type = NULL){
  check_target <- if(is.null(horizon)){
    grepl(target_type, forecasts$target)
  } else{
    grepl(horizon, forecasts$target) & grepl(target_type, forecasts$target)
  }
  check_forecast_date <- if(is.null(forecast_date)) TRUE else forecasts$forecast_date == forecast_date
  
  forecasts <- forecasts[check_target &
                           check_forecast_date &
                           forecasts$location == location &
                           (forecasts$quantile %in% c(0.025, 0.25, 0.5, 0.75, 0.975) |
                              forecasts$type == "point"), ]
  if(!is.null(type)) forecasts <- forecasts[forecasts$type == type, ]
  return(forecasts)
}

# helper function to deterine y-limit
determine_ylim <- function(forecasts, forecast_date = NULL, target_type, horizon, location, truth, start_at_zero = TRUE){
  truth <- subset(truth, date >= forecast_date - 28)
  forecasts <- subset_forecasts_for_plot(forecasts = forecasts, forecast_date = forecast_date,
                            target_type = target_type, horizon = horizon, location = location)
  lower <- if(start_at_zero){
    0
  }else{
    0.95*min(c(forecasts$value, truth[, target_type]))
  }
  truth <- truth[truth$location == location, ]
  ylim <- c(lower, 1.05* max(c(forecasts$value, truth[, target_type])))
}

# create an empty plot to which forecasts can be added:
empty_plot <- function(xlim, ylim, xlab, ylab){
  plot(NULL, xlim = xlim, ylim = ylim,
       xlab = xlab, ylab = "", axes = FALSE)
  axis(2, las = 1)
  title(ylab = ylab, line = 4)
  all_dates <- seq(from = as.Date("2020-02-01"), to = Sys.Date() + 28, by  =1)
  saturdays <- all_dates[weekdays(all_dates) == "Saturday"]
  axis(1, at = saturdays, labels = as.Date(saturdays, origin = "1970-01-01"))
  box()
}

# add a single prediction interval:
draw_prediction_band <- function(forecasts, forecast_date = NULL, target_type, horizon,
                                 location, coverage, col = "lightgrey"){
  if(!coverage %in% c(1:9/10, 0.95, 0.98)) stop("Coverage needs to be from 0.1, 0.2, ..., 0.9, 0.95, 0.98")

  forecasts <- subset_forecasts_for_plot(forecasts  =forecasts, forecast_date = forecast_date,
                            target_type = target_type, horizon = horizon, location = location,
                            type = "quantile")

  # select points to draw polygon:
  lower <- subset(forecasts, abs(quantile - (1 - coverage)/2) < 0.01)
  lower <- lower[order(lower$target_end_date), ]
  upper <- subset(forecasts, abs(quantile - (1 - (1 - coverage)/2)) < 0.01)
  upper <- upper[order(upper$target_end_date, decreasing = TRUE), ]
  # draw:
  polygon(x = c(lower$target_end_date, upper$target_end_date),
          y = c(lower$value, upper$value), col = col, border = NA)
}

# draw many prediction intervals (resulting in a fanplot)
draw_fanplot <- function(forecasts, target_type, forecast_date, horizon, location, levels_coverage = c(1:9/10, 0.95, 0.98),
                         cols = colorRampPalette(c("deepskyblue4", "lightgrey"))(length(levels_coverage) + 1)[-1]){
  for(i in rev(seq_along(levels_coverage))){
    draw_prediction_band(forecasts = forecasts,
                         target_type = target_type,
                         horizon = horizon,
                         forecast_date = forecast_date,
                         location = location,
                         coverage = levels_coverage[i],
                         col = cols[i])
  }
}

# add points for point forecasts:
draw_points <- function(forecasts, target_type, horizon, forecast_date, location, col = "deepskyblue4"){
  forecasts <- subset_forecasts_for_plot(forecasts = forecasts, forecast_date = forecast_date,
                                         target_type = target_type, horizon = horizon, location = location,
                                         type = "point")
  lines(forecasts$target_end_date, forecasts$value, col = col)
  points(forecasts$target_end_date, forecasts$value, pch = 21, col = col, bg = "white")
}

# add smaller points for truths:
draw_truths <- function(truth, location, target_type){
  truth <- truth[weekdays(truth$date) == "Saturday" &
                   truth$location == location, ]
  points(truth$date, truth[, target_type], pch = 20, type = "b")
}

# wrap it all up into one plotting function:
# Arguments:
# forecasts a data.frame containing forecasts from one model in he standard long format
# needs to contain forecasts from different forecast_dates to plot forecats by "horizon"
# target_type: "inc death" or "cum death"
# horizon: "1 wk ahead", "2 wk ahead", "3 wk ahead" or "4 wk ahead"; if specified forecasts at this horizon
# are plotted for different forecast dates. Has to be NULL if forecast_date is specified
# forecast_date: the date at which forecasts were issued; if specified, 1 though 4 wk ahead forecasts are shown
# Has to be NULL if horizon is specified
# location: the location for which to plot forecasts
# truth: the truth data set
# levels_coverage: which intervals are to be shown? Defaults to all, c(0.5, 0.95) is a reasonable
# parsimonious choice.
# start, end: beginning and end of the time period to plot
# ylim: the y limits of the plot. If NULL chosen automatically.
# cols: a vector of colors of the same length as levels_coverage
plot_forecast <- function(forecasts,
                          target_type = "cum death",
                          horizon = NULL,
                          forecast_date = NULL,
                          location,
                          truth,
                          levels_coverage = c(1:9/10, 0.95, 0.98),
                          start = as.Date("2020-04-01"),
                          end = Sys.Date() + 28,
                          ylim = NULL,
                          cols_intervals = colorRampPalette(c("deepskyblue4", "lightgrey"))(length(levels_coverage) + 1)[-1],
                          col_point = "deepskyblue4",
                          xlab = "date",
                          ylab = target_type,
                          start_at_zero = TRUE){

  if(is.null(horizon) & is.null(forecast_date)) stop("Exactly one out of horizon and forecast_date needs to be specified")

  forecasts <- subset(forecasts, target_end_date >= start & target_end_date <= end)
  truth <- truth[truth$date >= start & truth$location == location, ]
  xlim <- c(start, end)

  if(is.null(ylim)) ylim <- determine_ylim(forecasts = forecasts, forecast_date = forecast_date,
                                           target_type = target_type, horizon = horizon,
                                           location = location, truth = truth, start_at_zero = start_at_zero)

  empty_plot(xlim = xlim, ylim = ylim, xlab = xlab, ylab = ylab)
  if(!is.null(forecast_date)) abline(v = forecast_date, lty = "dashed")
  draw_fanplot(forecasts = forecasts, target_type = target_type,
               horizon = horizon, forecast_date = forecast_date,
               location = location, levels_coverage = levels_coverage,
               cols = cols_intervals)
  draw_points(forecasts = forecasts, target_type = target_type,
              horizon = horizon, forecast_date = forecast_date,
              location = location, col = col_point)
  draw_truths(truth = truth, location = location, target_type = target_type)
}
