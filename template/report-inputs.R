# Interpret ensemble for weekly report
library(vroom)
library(dplyr)
library(lubridate)
library(stringr)
library(tidyr)
library(purrr)

# Set up ------------------------------------------------------------------
ensemble_name <- "EuroCOVIDhub-ensemble"
ensemble_method <- "mean average"
# forecast_date <- floor_date(today(), "week", 1)
forecast_date <- floor_date(today()-1, "week", 1)

# Get current country data ------------------------------------------------
# Population counts and European regions
country_pop <- vroom("data-locations/locations_eu.csv") %>%
  left_join(select(countrycode::codelist, 
                   location = iso2c,
                   europe_region = un.regionsub.name),
            by = "location") %>%
  # adjust region for Cyprus
  mutate(europe_region = str_replace_all(europe_region, 
                                         "Western Asia", "Southern Europe"))
# Truth data for preceding epiweek
get_latest_truth <- function(truth_data, forecast_date) {
  truth_data <- truth_data %>%
    mutate(value = ifelse(value < 0, 0, value),
           epiyear = epiyear(date), 
           epiweek = epiweek(date)) %>%
    group_by(location, epiyear, epiweek) %>%
    summarise(value = sum(value),
            date = max(date), 
            .groups = "drop") %>%
    filter(date < forecast_date) %>%
    filter(date == max(date)) %>%
    mutate(target_end_date = forecast_date) %>%
    select(location, target_end_date, quantile, value)
}

latest_truth_deaths <- vroom(paste("data-truth", "JHU", "truth_JHU-Incident Deaths.csv",
                                   sep = "/")) %>%
  get_latest_truth(forecast_date = forecast_date) %>%
  mutate(variable = "death")

latest_truth_cases <- vroom(paste("data-truth", "JHU", "truth_JHU-Incident Cases.csv",
                                   sep = "/")) %>%
  get_latest_truth(forecast_date = forecast_date) %>%
  mutate(variable = "case")

latest_truth <- bind_rows(latest_truth_deaths, latest_truth_cases) 
latest_truth <- bind_rows(latest_truth, latest_truth, latest_truth,
                            .id = "quantile") %>%
  mutate(quantile = recode(quantile, 0.25 = 1, 0.5 = 2, 0.75 = 3)) %>%
  left_join(country_pop, by = "location")

# Get latest ensemble -----------------------------------------------------
ensemble <- vroom(paste("data-processed", ensemble_name,
                       paste0(forecast_date, "-", ensemble_name, ".csv"),
                       sep = "/")) %>%
  filter(!is.na(quantile)) %>%
  mutate(variable = ifelse(str_detect(target, "case"),
                           "case", "death")) %>%
  # Join to latest data
  left_join(country_pop, by = "location") %>%
  bind_rows(latest_truth) 

# Calculate trends ---------------------------------------
summary_ensemble <- ensemble %>%
  # keep central estimates
    filter(quantile %in% c(0.25, 0.5, 0.75)) %>%
  # calculate values per 100k and % change
    group_by(location_name, variable, quantile) %>%
    arrange(target_end_date) %>%
    mutate(value_100k = (value / population) * 100000,
           change_percent = (value - lag(value)) / lag(value) * 100)


#%>%
    # get trend
    pivot_wider(names_from = quantile, 
                values_from = c(value, value_100k, 
                                change_percent)) %>%
    mutate(trend = ifelse(change_percent_0.25 > 0 &
                            change_percent_0.75 > 0 &
                            !change_percent_0.5 == Inf,
                          "increase",
                          ifelse(change_percent_0.25 < 0 &
                                   change_percent_0.75 < 0 &
                                   !change_percent_0.5 == Inf,
                          "decrease",
                          "remain stable or uncertain")))



  # Add a neater table
  summary_table <- summary_ensemble %>%
    ungroup() %>%
    mutate(forecast_range = paste0(forecast_0.5," (",
                                                forecast_0.25, "-",
                                                forecast_0.75, ")"),
           forecast_100k = paste0(forecast_100k_0.5, " (",
                                                  forecast_100k_0.25, "-",
                                                  forecast_100k_0.75, ")"),
           date_range = paste(as.Date(target_end_date) - 6, "to", target_end_date)) %>%
    arrange(desc(latest_100k)) %>%
    select('Region' = europe_region,
           'Country' = location_name, 
           'Population' = population,
           # 'Latest weekly incidence' = latest, 
           # 'Latest weekly incidence per 100,000' = latest_100k,
           'Forecast period' = date_range,
           'Forecast weekly range' = forecast_range, 
           'Forecast weekly per 100,000' = forecast_100k, 
           'Trend' = trend,
           variable) 
  
  trend <- summary_table %>%
    count(Trend) %>%
    arrange(desc(n))
  
  region_trend <- summary_table %>%
    group_by(Trend) %>%
    count(Region) %>%
    arrange(desc(n))
  
  region <- split(summary_table, summary_table$Region)
  
  dates <- c(as.Date(week_end) - 6, week_end)
  
  summary <- list(summary_table, trend, region_trend, region, dates)
  names(summary) <- c("summary_table", "trend", "region_trend", "region", "dates")
  return(summary)
}

# Describe trends -------------------------------------------------------
country1wk <- ensemble %>%
  split(.$variable) %>%
  map(~ summarise_ensemble(.x, week_end = min(ensemble$target_end_date)))

country4wk <- ensemble %>%
  split(.$variable) %>%
  map(~ summarise_ensemble(.x, week_end = max(ensemble$target_end_date)))



# Meta data counts -------------------------------------------------------------------
# Number of locations
location_count <- length(unique(ensemble$location))

# Number of teams contributing
team_count <- dir("data-processed", pattern = as.character(forecast_date),
             include.dirs = TRUE, recursive = TRUE) %>%
  str_split("/") %>%
  map_chr( ~ .x[1]) %>%
  length() - 1






