library("readr")
library("dplyr")
library("here")
library("lubridate")
library("janitor")
library("R.utils")
library("curl")
library("covidHubUtils")

# Set up
data_dir <- here::here("data-truth", "ECDC")
ecdc_scraped_filepath <- here(data_dir, "raw", "scraped.csv")
pop <- covidHubUtils::hub_locations_ecdc %>%
  select(-population)

# Get ECDC scraped data
cat("Downloading ECDC scraped data\n")
R.utils::downloadFile(Sys.getenv("DATA_URL"), # Uses set environment variables
                      ecdc_scraped_filepath,
                      username = Sys.getenv("DATA_USERNAME"),
                      password = Sys.getenv("DATA_PASSWORD"),
                      skip = FALSE, overwrite = TRUE)
# Clean
scraped <- read_csv(ecdc_scraped_filepath) %>%
  clean_names() %>%
  filter(indicator == "New_Hospitalised") %>%
  select(location_name = country_name, date, source, value) %>%
  mutate(source = if_else(grepl("TESSy", source), "TESSy", "Public"),
         type = "Scraped") %>%
  left_join(pop) %>%
  select(location_name, location, date, value, source, type)

# Save daily
write_csv(scraped, ecdc_scraped_filepath)
