# Generate a simple equally weighted ensemble forecast for cumulative deaths:

# Johannes Bracher, August 2020

# setwd("/home/johannes/Documents/COVID/fork_de/covid19-forecast-hub-de/code/ensemble")

Sys.setlocale(category = "LC_TIME", locale = "en_US.UTF8") # set locale to English
source("functions_ensemble.R") # read in functions

# basic settings:
country <- "Poland"
location <- "PL"
forecast_date <- as.Date("2020-10-05")
if(!weekdays(forecast_date) == "Monday") stop("forecast_date should be a Monday.")

# read in which models to include:
models_to_include0 <- read.csv(paste0("included_models/included_models-", forecast_date, ".csv"), stringsAsFactors = FALSE)
models_to_include <- models_to_include0$model[models_to_include0[, location]]

# read in truth data:
if(country == "Germany"){
  ecdc <- read.csv("../../data-truth/RKI/truth_RKI-Cumulative Deaths_Germany.csv", colClasses = list("date" = "Date"))
  ecdc$truth_data <- "ECDC"
  jhu <- read.csv("../../data-truth/JHU/truth_JHU-Cumulative Deaths_Germany.csv", colClasses = list("date" = "Date"))
  jhu$truth_data <- "JHU"
}

if(country == "Poland"){
  ecdc <- read.csv("../../data-truth/ECDC/truth_ECDC-Cumulative Deaths_Poland.csv", colClasses = list("date" = "Date"))
  ecdc$truth_data <- "ECDC"
  jhu <- read.csv("../../data-truth/JHU/truth_JHU-Cumulative Deaths_Poland.csv", colClasses = list("date" = "Date"))
  jhu$truth_data <- "JHU"
}


# extract last observed values in both truth data sets:
last_saturday <- get_last_saturday(forecast_date)
last_observations <- rbind(
  subset(ecdc, date == last_saturday & location %in% location),
  subset(jhu, date == last_saturday & location %in% location)
)
last_observations <- last_observations[, c("location", "truth_data", "value")]
colnames(last_observations)[3] <- "last_observed"

# read in csv on truth data use for different models:
truth_data_use <- read.csv("../../app_forecasts_de/data/truth_data_use.csv")

# read in forecast data
for(i in 1:length(models_to_include)){
  # select file to load:
  selected_file <- select_file(list.files(paste0("../../data-processed/", models_to_include[i])),
                               forecast_date = forecast_date,
                               target_type = "death",
                               country = country)
  # read in data:
  to_add <- read.csv(paste0("../../data-processed/", models_to_include[i], "/", selected_file))
  # remove location_name as may not be present in all files
  to_add$location_name <- NULL
  # restrict to quantiles for cum death week ahead:
  to_add <- to_add[to_add$target %in% paste(1:4, "wk ahead cum death") &
                     to_add$location %in% location &
                     to_add$type == "quantile", ]
  # add model name:
  to_add$model <- models_to_include[i]
  # add truth data source:
  to_add$truth_data <- truth_data_use$truth_data[truth_data_use$model == models_to_include[i]]
  # add last observed value
  to_add <- merge(to_add, last_observations, by = c("location", "truth_data"), all.x = TRUE)

  if(i == 1){
    forecasts <- to_add
  }else{
    forecasts <- rbind(forecasts, to_add)
  }
}

# format dates:
forecasts$forecast_date <- as.Date(forecasts$forecast_date)
forecasts$target_end_date <- as.Date(forecasts$target_end_date)

# move to scale of "deaths since last observed value":
forecasts$cum_since_last_observed <- forecasts$value - forecasts$last_observed

# take averages:
ensemble<- aggregate(forecasts$cum_since_last_observed,
                  by = list(target_end_date = forecasts$target_end_date,
                            target = forecasts$target,
                            location = forecasts$location,
                            quantile = forecasts$quantile), FUN = mean)
colnames(ensemble)[colnames(ensemble) == "x"] <- "cum_since_last_observed"
ensemble$truth_data <- "ECDC"

# merge last observed values from ECDC/RKI:
ensemble <- merge(ensemble, last_observations, by = c("location", "truth_data"))

# compute quantiles for cumulative deaths:
ensemble$value <- ensemble$last_observed + ensemble$cum_since_last_observed

# merge in location names:
state_codes <- rbind(read.csv("../../template/state_codes_germany.csv")[, c("state_code", "state_name")],
                     read.csv("../../template/state_codes_poland.csv")[, c("state_code", "state_name")])
state_codes <- state_codes[, c("state_code", "state_name")]
colnames(state_codes) <- c("location", "location_name")
ensemble <- merge(ensemble, state_codes, by = "location")

# add type and forecast_date variables:
ensemble$type <- "quantile"
ensemble$forecast_date <- forecast_date

# conservative rounding:
ensemble$value[ensemble$quantile < 0.5] <- floor(ensemble$value[ensemble$quantile < 0.5])
ensemble$value[ensemble$quantile == 0.5] <- round(ensemble$value[ensemble$quantile == 0.5])
ensemble$value[ensemble$quantile > 0.5] <- ceiling(ensemble$value[ensemble$quantile > 0.5])

# restrict to relevant columns:
ensemble <- ensemble[, c("forecast_date", "target", "target_end_date", "location", "type", "quantile", "value", "location_name")]
head(ensemble)

# add point forecasts:
point_forecasts <- subset(ensemble, quantile == 0.5)
point_forecasts$type <- "point"
point_forecasts$quantile <- NA

# add last observed values:
observed <- ecdc[ecdc$date %in% (last_saturday - c(0, 7)) & ecdc$location %in% location, ]
observed$target_end_date <- observed$date
observed$type <- "observed"
observed$quantile <- NA
observed$target <- NA
observed$forecast_date <- forecast_date
observed$target[observed$date == last_saturday] <- "0 wk ahead cum death"
observed$target[observed$date == last_saturday - 7] <- "-1 wk ahead cum death"
# re-order columns:
observed <- observed[, colnames(ensemble)]

# put everything together:
ensemble <- rbind(ensemble, point_forecasts, observed)
head(ensemble)
tail(ensemble)

# store
write.csv(ensemble, file = paste0("../../data-processed/KITCOVIDhub-mean_ensemble/", forecast_date,
                                  "-", country, "-KITCOVIDhub-mean_ensemble.csv"), row.names = FALSE)
