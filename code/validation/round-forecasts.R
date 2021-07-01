# Round all forecasts in data-processed
library(here)
library(purrr)

# Load forecast from individual file, round values, and re-write
all_files <- dir(here("data-processed"), recursive = TRUE,
                 pattern = ".csv")

walk2(all_files, all_files,
    ~ read_csv(here("data-processed", .x)) %>%
      mutate(value = round(value)) %>%
      write_csv(here("data-processed", .y)))
