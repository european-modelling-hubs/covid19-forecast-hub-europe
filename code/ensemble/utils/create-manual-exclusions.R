library(here)

exclude <- readr::read_csv(here("code/ensemble/EuroCOVIDhub/manual-exclusions.csv"),
                           col_types = "ccc")

exclude_new <- tibble::tribble(
  
  # Replace NAs here to add models as necessary
  
  ~forecast_date, ~model, ~reason_for_exclusion,
  
  NA, NA, NA
  
)

exclude <- dplyr::bind_rows(exclude, exclude_new)

readr::write_csv(exclude, here("code/ensemble/EuroCOVIDhub/manual-exclusions.csv"))
