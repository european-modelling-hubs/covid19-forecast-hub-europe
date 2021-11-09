library(here)
library(dplyr)
library(lubridate)
library(readr)
data_dir <- here("data-truth", "ECDC")
non_eu_filepath <- here(data_dir, "raw", "non-eu.csv")

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
#   https://opendata.swiss/en/dataset/covid-19-schweiz

ch <- "https://www.covid19.admin.ch/api/data/20211109-zps7qksn/sources/COVID19Hosp_geoRegion.csv" 
ch <- read_csv(ch) %>%
  select(location = geoRegion, date = datum, value = entries) %>%
  filter(location == "CH") %>%
  mutate(location_name = "Switzerland")

# Format ------------------------------------------------------------------
non_eu <- bind_rows(uk, ch) %>%
  select(location_name, location, date, value) %>%
  mutate(source = "Hub",
         type = "Scraped")

# Save daily data ---------------------------------------------------------
write_csv(non_eu, non_eu_filepath)
