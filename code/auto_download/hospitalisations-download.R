# Download and save all hospitalisations data
#  plus save a "truth" file with only the selected source for each country

library(here)
script_dir <- here("code", "auto_download", "hospitalisations")

# Download and save minimally processed data files
source(here(script_dir, "get-ecdc-official.R"))
source(here(script_dir, "get-ecdc-scraped.R"))
source(here(script_dir, "get-non-eu.R"))

# Combine sources across countries, plot, and save as "Hospitalizations - truth"
source(here(script_dir, "save-selected-sources.R"))

# Update countries with hosp data source (used by validation) in data-locations.csv
source(here("code", "auto_download", "create-data-locations.R"))
