# Generate a template file for cumulative and incident death forecasts, national level
# Johannes Bracher, May 2020
# modified: Jan 2021, Kath S

# This file creates a template data frame to store the following quantities:
# - last two observed values of cumulative and incident deaths on a weekly and daily scale (-1 and 0 day/week ahead "forecasts")
# - 1 through 30 day and 1 through 4 week ahead forecasts of incident and cumulative deaths.
# 
# Weekly forecasts are Mon-Sun


# define the date on which forecasts are generated:
forecast_date <- as.Date("2021-02-01")

locations <- read.csv("template/locations_eu.csv")

dat <- data.frame(
  scenario = "EXAMPLE",
  forecast_date = forecast_date,
  target = "4 wk ahead inc case",
  target_end_date = forecast_date + 6,
  location = "EXAMPLE",
  type = "point",
  quantile = NA,
  value = 1
)

tgs <- c(paste(1:4, "wk ahead inc case"),
         paste(1:4, "wk ahead inc death"))

end_dates <- c(forecast_date + c(6, 13, 20, 27),
               forecast_date + c(6, 13, 20, 27))

quantiles <- c(0.01, 0.025, 1:19/20, 0.975, 0.99)

weekdays(end_dates)

for(loc in 1:nrow(locations)){
  for(t in seq_along(tgs)){
    new_dat <- data.frame(scenario = "forecast",
                          forecast_date = forecast_date,
                          target = tgs[t],
                          target_end_date = end_dates[t],
                          location = locations$iso3c[loc],
                          type = c("point", rep("quantile", length(quantiles))),
                          quantile = c(NA, quantiles),
                          value = 1)
    dat <- rbind(dat, new_dat)
  }
}


dat$target_end_date <- as.Date(dat$target_end_date, origin = "1970-01-01")
dat$forecast_date <- as.Date(dat$forecast_date, origin = "1970-01-01")

write.csv(dat, file = paste0("data-processed/Template-ExampleModel/", forecast_date, "-Template-ExampleModel.csv"), row.names = FALSE)
