# Interpret ensemble for weekly report
library(vroom)
library(dplyr)
library(lubridate)
library(stringr)
library(tidyr)
library(purrr)
library(ggplot2)

# Set up ------------------------------------------------------------------
ensemble_name <- "EuroCOVIDhub-ensemble"
ensemble_method <- "mean average"
forecast_date <- floor_date(today(), "week", 1)

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
    select(location, target_end_date, value)
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
  mutate(quantile = recode(quantile, `1` = 0.25, `2` = 0.5, `3` = 0.75)) %>%
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
summarise_ensemble <- function(ensemble, target_end_date) {
  summary_ensemble <- ensemble %>%
  # keep central estimates
    filter(quantile %in% c(0.25, 0.5, 0.75)) %>%
  # calculate values per 100k and % change
    group_by(location_name, variable, quantile) %>%
    arrange(target_end_date) %>%
    mutate(value_100k = (value / population) * 100000,
           change_percent = (value - lag(value)) / lag(value) * 100) %>%
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
    filter(target_end_date == {{target_end_date}}) %>%
    arrange(desc(value_100k_0.5)) %>%
    ungroup() %>%
    mutate(across(where(is.numeric), round, -1),
           forecast_range = paste0(value_0.5," (",
                                                value_0.25, "-",
                                                value_0.75, ")"),
           forecast_100k = paste0(value_100k_0.5, " (",
                                                  value_100k_0.25, "-",
                                                  value_100k_0.75, ")"),
           date_range = paste(as.Date(target_end_date) - 6, "to", target_end_date)) %>%
    select('Region' = europe_region,
           'Country' = location_name, 
           'Population' = population,
           'Forecast period' = date_range,
           'Forecast weekly range' = forecast_range, 
           'Forecast weekly per 100,000' = forecast_100k, 
           'Trend' = trend) 
  
  trend <- summary_table %>%
    count(Trend) %>%
    arrange(desc(n))
  
  region_trend <- summary_table %>%
    group_by(Trend) %>%
    count(Region) %>%
    arrange(desc(n))
  
  region <- split(summary_table, summary_table$Region)
  
  dates <- c(as.Date(target_end_date) - 6, target_end_date)
  
  summary_region <- summary_ensemble %>%
    group_by(europe_region, target_end_date, variable) %>%
    summarise(across(value_100k_0.25:change_percent_0.75, ~ mean(., na.rm=T))) %>%
    mutate(obs = ifelse(target_end_date == forecast_date, "Observed", "Forecast"))
  
  summary_region_plot <- summary_region %>%
    mutate(variable = recode(variable, "case" = "Weekly cases", 
                             "death" = "Weekly deaths")) %>%
    ggplot(aes(colour = europe_region, fill = europe_region,
               x = target_end_date)) +
    geom_point(aes(y = value_100k_0.5)) +
    geom_line(aes(y = value_100k_0.5)) +
    geom_ribbon(aes(ymin = value_100k_0.25, ymax = value_100k_0.75), alpha = 0.1) +
    geom_vline(xintercept = forecast_date + 1, lty = 2) +
    labs(x = "Week ending", y = "Weekly incidence per 100,000",
         colour = NULL, fill = NULL) +
    scale_fill_brewer(type = "qual", palette = 6) +
    scale_colour_brewer(type = "qual", palette = 6) +
    cowplot::theme_cowplot() +
    theme(legend.position = "bottom")
  
  summary <- list(summary_ensemble, summary_table, summary_region_plot,
                  trend, region_trend, region, dates)
  names(summary) <- c("summary_ensemble", "summary_table", "summary_region_plot",
                      "trend", "region_trend", "region", "dates")
  return(summary)
}

# Describe trends -------------------------------------------------------
country1wk <- ensemble %>%
  split(.$variable) %>%
  map(~ summarise_ensemble(.x, target_end_date = forecast_date + 5))

country4wk <- ensemble %>%
  split(.$variable) %>%
  map(~ summarise_ensemble(.x, target_end_date = max(ensemble$target_end_date)))


# Meta data counts -------------------------------------------------------------------
# Number of locations
location_count <- length(unique(ensemble$location))

# Number of teams contributing
team_count <- dir("data-processed", pattern = as.character(forecast_date),
             include.dirs = TRUE, recursive = TRUE) %>%
  str_split("/") %>%
  map_chr( ~ .x[1]) %>%
  length() - 1






