# read in week ahead forecasts from a given file
read_week_ahead <- function(path){
  dat <- read.csv(path, colClasses = c(location = "character", forecast_date = "Date", target_end_date = "Date"),
                  stringsAsFactors = FALSE)

    return(subset(dat, target %in% c(paste(1:4, "wk ahead inc death"),
                                     paste(1:4, "wk ahead cum death"),
                                     paste(1:4, "wk ahead inc case"),
                                     paste(1:4, "wk ahead cum case"))))
}

# transform incidence data to weekly scale:
inc_truth_to_weekly <- function(truth_inc0){
  truth_inc0 <- subset(truth_inc0, nchar(location) == 2)
  truth_inc0$epi_week <- MMWRweek::MMWRweek(truth_inc0$date)$MMWRweek
  truth_inc <- aggregate(truth_inc0$value,
                         by = list(epi_week = truth_inc0$epi_week, location = truth_inc0$location),
                         FUN = sum)
  colnames(truth_inc)[3] <- "value"
  truth_inc <- merge(truth_inc,
                     truth_inc0[weekdays(truth_inc0$date) == "Saturday", c("date", "epi_week", "location", "location_name")],
                     by = c("epi_week", "location"))
  truth_inc <- truth_inc[order(truth_inc$date), ]
  return(truth_inc)
}

# extract the date from a file name in our standardized format
get_date_from_filename <- function(filename){
  as.Date(substr(filename, start = 1, stop = 10))
}

# get the date of the next Monday following after a given date
next_monday <- function(date){
  nm <- rep(NA, length(date))
  for(i in seq_along(date)){
    nm[i] <- date[i] + (0:6)[weekdays(date[i] + (0:6)) == "Monday"]
  }
  return(as.Date(nm, origin = "1970-01-01"))
}

# get last Saturday:
get_last_saturday <- function(forecast_date){
  # if(!weekdays(forecast_date) == "Monday") warning("forecast_date should be a Monday.")
  (forecast_date - (0:6))[weekdays(forecast_date - (0:6)) == "Saturday"]
}

# get the truth data source which was used by a certain model on a given date and for a given location
get_used_truth <- function(truth_data_use, model, location, date){
  subs <- truth_data_use[truth_data_use$model == model &
                           truth_data_use$location == location &
                           truth_data_use$starting_from < date, ]
  subs <- subs[order(subs$starting_from), ]
  truth_used <- tail(subs$truth_data_source, 1)
  if(length(truth_used) == 0){
    return(NA)
  }else{
    return(truth_used)
  }
}

# among a set of forecast dates: choose those which are Mondays and those which are Sundays,
# Saturdays or Fridays if no forecast is available from Monday (or a day closer to Monday)
choose_relevant_dates <- function(dates){
  wds <- weekdays(dates)
  next_mondays <- next_monday(dates)
  relevant_dates <- c()
  for(day in c("Monday", "Sunday", "Saturday", "Friday")){
    relevant_dates <- c(relevant_dates, dates[wds == day &
                                                !(next_mondays %in% relevant_dates) &
                                                !((next_mondays - 1) %in% relevant_dates) &
                                                !((next_mondays - 2) %in% relevant_dates)
                                              ])
  }
  relevant_dates <- as.Date(relevant_dates, origin = "1970-01-01")
  return(as.Date(relevant_dates, origin = "1970-01-01"))
}

# modify the alpha value of a given color (to generate transparent versions for prediction bands)
modify_alpha <- function(col, alpha){
  x <- col2rgb(col)/255
  rgb(x[1], x[2], x[3], alpha = alpha)
}


get_target_type <- function(target){
  ret <- sapply(target, function(x) paste(strsplit(x, " ")[[1]][-1:-3], collapse = " "))
  names(ret) <- NULL
  return(ret)
}

truth_to_long <- function(truth_wide){
  data.frame(date = rep(truth_wide$date, 4),
             location = rep(truth_wide$location, 4),
             target = c(rep("inc death", nrow(truth_wide)),
                        rep("cum death", nrow(truth_wide)),
                        rep("inc case", nrow(truth_wide)),
                        rep("cum case", nrow(truth_wide))),
             value = c(truth_wide$inc_death, truth_wide$cum_death,
                       truth_wide$inc_case, truth_wide$cum_case))
}
