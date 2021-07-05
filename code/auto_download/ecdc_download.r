library("here")
library("vroom")
library("eurostat")
library("dplyr")
library("countrycode")
library("tidyr")
library("ISOweek")
library("stringi")
library("lubridate")

cat("Downloading ECDC data\n")

countries <- eurostat::eu_countries %>%
  bind_rows(eurostat::efta_countries) %>%
  rename(country = name, eurostat = code) %>%
  mutate(country_code = countrycode(eurostat, "eurostat", "iso3c")) %>%
  select(country_code)

ct <- "cc--cic---"

ecdc_dir <- here::here("data-truth", "ECDC")
file_base <- "truth_ECDC-Incident"

if (!dir.exists(ecdc_dir)) dir.create(ecdc_dir, recursive = TRUE)

df <-
  vroom::vroom("https://opendata.ecdc.europa.eu/covid19/nationalcasedeath/csv",
               col_types = ct) %>%
  inner_join(countries, by = "country_code") %>%
  separate(year_week, c("year", "week"), sep = "-") %>%
  mutate(week_start = ISOweek2date(paste0(year, "-W", week, "-1"))) %>%
  mutate(indicator = stri_trans_totitle(indicator)) %>%
  select(week_start, indicator,
         location = country_code, location_name = country,
         value = weekly_count) %>%
  group_by(indicator) %>%
  group_walk(~ vroom_write(.x, delim = ",",
                           path = file.path(ecdc_dir,
                                            paste0(file_base, " ",
                                                   .y$indicator, ".csv"))))

# Hospitalisation data
# Get file
data_filepath <- here("data-truth", "ECDC", 
                      "truth_ecdc-Incident Hospitalizations.csv") # covidHubUtils format

R.utils::downloadFile(Sys.getenv("DATA_URL"), 
                      data_filepath, 
                      username = Sys.getenv("DATA_USERNAME"), 
                      password = Sys.getenv("DATA_PASSWORD"),
                      skip = FALSE,
                      overwrite = TRUE)

locations <- read_csv(here("data-locations", "locations_eu.csv")) %>%
  select(location, location_name)

# Format
public_sources <- c("Country_Website", "Country_API", "Country_Github")
ecdc <- vroom(data_filepath) %>%
  filter(Indicator %in% c("New_Hospitalised") &
           Source %in% public_sources) %>%
  rename(location_name = CountryName) %>%
  mutate(target_variable = "inc hosp") %>%
  left_join(locations, by = "location_name") %>%
  select(date = Date, location, location_name, value = Value) %>%
  write_csv(file = data_filepath, append = FALSE)
