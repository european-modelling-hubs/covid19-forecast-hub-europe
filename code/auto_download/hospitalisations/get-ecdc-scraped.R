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
ecdc_scraped_filepath <- here(data_dir, "raw", paste0("scraped.csv"))
pop <- covidHubUtils::hub_locations_ecdc %>%
  select(-population)

# Get ECDC scraped data
cat("Downloading ECDC scraped data\n")
R.utils::downloadFile("https://opendata.ecdc.europa.eu/covid19/modellinghub/csv/COVID.zip",
                      ecdc_scraped_filepath,
                      username = Sys.getenv("DATA_USERNAME"),
                      password = Sys.getenv("DATA_PASSWORD"),
                      skip = FALSE, overwrite = TRUE)
# Clean
scraped <- read_csv(ecdc_scraped_filepath, show_col_types = FALSE) %>%
  clean_names() %>%
  select(location_name = country_name, indicator, date, source, value) %>%
  mutate(source = if_else(grepl("TESSy", source), "TESSy", "Public"),
         type = "Scraped") %>%
  left_join(pop) %>%
  select(location_name, location, indicator, date, value, source, type)

# Save daily
write_csv(scraped, ecdc_scraped_filepath)
