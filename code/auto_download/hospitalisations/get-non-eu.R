library(here)
library(covidregionaldata)
library(dplyr)
library(lubridate)
data_dir <- here::here("data-truth", "ECDC")
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
         hosp_new = newAdmissions)

# Switzerland
ch <- get_regional_data("Switzerland", localise = FALSE) %>%
  filter(level_1_region != "Liechtenstein") %>% 
  mutate(location_name = "Switzerland") %>% 
  group_by(date, location_name) %>% 
  summarise(hosp_new = sum(hosp_new, na.rm = TRUE))

# Format ------------------------------------------------------------------
non_eu <- bind_rows(uk, ch) %>%
  select(date, location_name, hosp_new) %>% 
  left_join(covidHubUtils::hub_locations_ecdc %>%
              select(-population),
            by = "location_name") %>% 
  select(location_name, location, date, value = hosp_new) %>% 
  mutate(source = "Public",
         type = "National")

# Save daily data ---------------------------------------------------------
write_csv(non_eu, non_eu_filepath)
