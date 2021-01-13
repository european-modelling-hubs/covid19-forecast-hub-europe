# Generate a template file for cumulative and incident death forecasts, national level
# Johannes Bracher, May 2020

# This file creates a template data frame to store the following quantities:
# - last two observed values of cumulative and incident deaths on a weekly and daily scale (-1 and 0 day/week ahead "forecasts")
# - 1 through 30 day and 1 through 4 week ahead forecasts of incident and cumulative deaths.

# Note that weekly incidence forecasts are always from Sunday (included) to Saturday (included; this is target_end_date)

# define the date on which forecasts are generated:
forecast_date <- as.Date("2020-07-13")

locations <- read.csv("state_codes_germany.csv")

dat <- data.frame(
  forecast_date = forecast_date,
  target = NA,
  target_end_date = NA,
  location = "GM",
  location_name	= "Germany",
  type = NA,
  quantile = NA,
  value = NA
)

tgs <- c(paste(-1:30, "day ahead inc death"),
         paste(-1:30, "day ahead cum death"),
         paste(-1:4, "wk ahead inc death"),
         paste(-1:4, "wk ahead inc death"))

end_dates <- c(forecast_date + (-1:30),
               forecast_date + (-1:30),
               forecast_date + c(-9, -2, 5, 12, 19, 26),
               forecast_date + c(-9, -2, 5, 12, 19, 26))

quantiles <- c(0.01, 0.025, 1:19/20, 0.975, 0.99)

weekdays(end_dates)

for(loc in 1:nrow(locations)){
  for(t in seq_along(tgs)){
    new_dat <- data.frame(forecast_date = forecast_date,
                          target = tgs[t],
                          target_end_date = end_dates[t],
                          location = locations$state_code[loc],
                          location_name = locations$state_name[loc],
                          type = c("point", rep("quantile", length(quantiles))),
                          quantile = c(NA, quantiles),
                          value = NA)
    dat <- rbind(dat, new_dat)
  }
}


dat$target_end_date <- as.Date(dat$target_end_date, origin = "1970-01-01")
# set type = "observed" for past dates:
dat$type[dat$type == "point" & dat$target_end_date <= forecast_date] <- "observed"
dat <- subset(dat, type == "observed" | target_end_date > forecast_date)

write.csv(dat, file = paste0(forecast_date, "-Germany-ABC-exampleModel1.csv"), row.names = FALSE)
