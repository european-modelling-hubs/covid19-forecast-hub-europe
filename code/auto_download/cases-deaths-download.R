# Download and save all case/death data
#  plus save a "truth" file with only the selected source for each country

library(here)
script_dir <- here("code", "auto_download")

# Download and save minimally processed data files
source(here(script_dir, "hospitalisations", "get-owid.R"))
source(here(script_dir, "cases-deaths", "get-ecdc.r"))

cat("Downloading OWID data\n")
owid <- get_owid()
cat("Downloading ECDC data\n")
ecdc <- get_owid()

# Update countries with hosp data source (used by validation) in data-locations.csv
source(here("code", "auto_download", "create-data-locations.R"))
