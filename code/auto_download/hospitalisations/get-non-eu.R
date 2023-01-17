library(here)
library(dplyr)
library(lubridate)
library(readr)
library(httr)
library(jsonlite)

data_dir <- here("data-truth", "ECDC")
non_eu_filepath <- here(data_dir, "raw", paste0("non-eu.csv"))
non_eu_filepath_dated <-
  here(data_dir, "raw", paste0("non-eu_", today(), ".csv"))

# Get data ----------------------------------------------------------------
cat("Downloading non-EU public data\n")
# UK
#   Using direct dashboard link to avoid downloading all case/death/etc data
#   Dashboard data is also truncated (necessary as Scotland reports weekly)
uk <- "https://coronavirus.data.gov.uk/api/v1/data?filters=areaType=overview&structure=%7B%22areaType%22:%22areaType%22,%22areaName%22:%22areaName%22,%22areaCode%22:%22areaCode%22,%22date%22:%22date%22,%22newAdmissions%22:%22newAdmissions%22,%22cumAdmissions%22:%22cumAdmissions%22%7D&format=csv"
uk <- read_csv(uk) %>%
  select(location_name = areaName,
         date,
         value = newAdmissions) %>%
  mutate(location = "GB")

# Switzerland
# Retrieve hospitalization data from Swiss FOPH
foph <- GET("https://www.covid19.admin.ch/api/data/context")
foph <- fromJSON(rawToChar(foph$content))
ch <- read.csv(foph$sources$individual$csv$daily$hosp)
ch$datum <- ymd(ch$datum)
ch <- subset(ch, geoRegion == "CH", c("datum", "entries"))
names(ch) <- c("date", "value")
ch$location_name <- "Switzerland"
ch$location <- "CH"


# Format ------------------------------------------------------------------
non_eu <- bind_rows(uk, ch) %>%
  select(location_name, location, date, value) %>%
  mutate(source = "Hub",
         type = "Scraped")

# Save daily data ---------------------------------------------------------
write_csv(non_eu, non_eu_filepath)
write_csv(non_eu, non_eu_filepath_dated)
