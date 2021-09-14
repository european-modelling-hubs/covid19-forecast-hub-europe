# Round all forecasts in data-processed
library(here)
library(purrr)
library(readr)
library(dplyr)

# Load forecast from individual file, round values, and re-write
all_files <- dir(here("data-processed"), 
                 recursive = TRUE, full.names = TRUE,
                 pattern = ".csv")

walk2(all_files, all_files,
    ~ read_csv(.x) %>%
      mutate(value = round(value)) %>%
      write_csv(.y))
