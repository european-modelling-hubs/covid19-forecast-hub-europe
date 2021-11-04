# Get official weekly ECDC hospitalisation data
library(dplyr)
library(covidHubUtils)

# Set up
data_dir <- here::here("data-truth", "ECDC")
ecdc_official_filepath <- here(data_dir, "raw", "official.csv")
pop <- covidHubUtils::hub_locations_ecdc

# Get ECDC published data
cat("Downloading ECDC published data\n")
official <- read_csv("https://opendata.ecdc.europa.eu/covid19/hospitalicuadmissionrates/csv/data.csv") %>%
  filter(grepl("hospital admissions", indicator)) %>%
  rename(unscaled_value = value,
         location_name = country) %>%
  inner_join(pop, by = "location_name") %>%
  # Rescale to count from per 100k
  mutate(value = if_else(grepl("100k", indicator),
                         round(unscaled_value * population / 1e+5),
                         unscaled_value)) %>%
  select(location_name, location, date, value, source) %>%
  mutate(source = if_else(grepl("TESSy", source), "TESSy", "Public"),
         type = "ECDC")

# Save
write_csv(official, ecdc_official_filepath)
