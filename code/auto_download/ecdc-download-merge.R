library("readr")
library("dplyr")
library("here")
library("lubridate")
library("ggplot2")
library("janitor")
library("tidyr")
library("ISOweek")
library("stringi")
library("R.utils")
library("curl")
library("covidHubUtils")

# Set up
ecdc_dir <- here::here("data-truth", "ECDC")
if (!dir.exists(ecdc_dir)) dir.create(ecdc_dir, recursive = TRUE)
pop <- covidHubUtils::hub_locations_ecdc

# Get ECDC published data -------------------------------------------------
cat("Downloading ECDC published data\n")
official <- read_csv("https://opendata.ecdc.europa.eu/covid19/hospitalicuadmissionrates/csv/data.csv") %>%
  inner_join(pop, by = c("country" = "location_name")) %>%
  rename(unscaled_value = value) %>%
  mutate(value = if_else(grepl("100k", indicator),
                         round(unscaled_value * population / 1e+5),
                         unscaled_value)) %>%
  filter(grepl("hospital admissions", indicator)) %>%
  select(country, data_end_date = date, value, source) %>%
  mutate(source = if_else(grepl("TESSy", source), "TESSy", "Public"),
         type = "ECDC")

# Get ECDC scraped data ---------------------------------------------------
cat("Downloading ECDC scraped data\n")
ecdc_scraped_filepath <- here("ecdc-scraped.csv")
R.utils::downloadFile(Sys.getenv("DATA_URL"), # Uses set environment variables
                      ecdc_scraped_filepath,
                      username = Sys.getenv("DATA_USERNAME"),
                      password = Sys.getenv("DATA_PASSWORD"),
                      skip = FALSE, overwrite = TRUE)

scraped <- read_csv(ecdc_scraped_filepath) %>%
  clean_names() %>%
  filter(indicator == "New_Hospitalised") %>%
  select(country = country_name, date, source, value) %>%
  mutate(source = if_else(grepl("TESSy", source), "TESSy", "Public"),
         type = "Scraped",
         # Aggregate using ISO weeks: match official data source
         isoweek = paste0(isoyear(date), "-W", isoweek(date))) %>%
  group_by(isoweek, country, source, type) %>%
  summarise(value = sum(value), 
            data_end_date = max(date),
            n = n(), .groups = "drop") %>%
  filter(n == 7) %>% 
  select(-c(n, isoweek))

file.remove(ecdc_scraped_filepath)

# Merge -------------------------------------------------------------------
all <- official %>%
  bind_rows(scraped) %>%
  # Shift dates to represent Sun-Sat MMWR epiweek (all datasets biased consistently)
  mutate(target_end_date = data_end_date - 1,
         type_source = paste0(source, " (", type, ")")) %>%
  filter(target_end_date >= "2021-05-01")

# select source by country
sourced <- read_csv(here("code", "auto_download", "hospitalisation-sources.csv")) %>%
  filter(source != "None") %>% 
  left_join(all, by = c("country", "source", "type")) %>% 
  # truncate some countries
  group_by(country) %>% 
  filter(!(truncate_weeks == 1 & data_end_date == max(data_end_date))) %>%
  left_join(pop, by = c("country" = "location_name")) %>% 
  select(location_name = country,
         location,
         target_end_date,
         value)

# Write to csv
ecdc_truth_filepath <- here("data-truth", "ECDC",
                            "truth_ECDC-Incident Hospitalizations.csv")
write_csv(sourced, ecdc_truth_filepath)



