library(dplyr)
library(here)
library(readr)
library(purrr)
library(tidyr)

# FIXME: find a way to get this information directly from the config file
# without hardcoding target types
var_files <- c(
  "inc_death" = "ECDC/truth_ECDC-Incident Deaths.csv",
  "inc_case" = "ECDC/truth_ECDC-Incident Cases.csv",
  "inc_hosp" = "OWID/truncated_OWID-Incident Hospitalizations.csv"
)
truth <- var_files |>
  imap(~ read_csv(here("data-truth", .x)) %>% mutate(name = .y)) |>
  bind_rows()

# get legacty data
legacy <- c("ECDC/final/", "OWID/final") |>
  map(~ tail(list.files(here("data-truth", .x), full.names = TRUE), 1)) |>
  map(~ read_csv(.x, show_col_types = FALSE)) |>
  bind_rows() |>
  mutate(name = gsub(" ", "_", target_variable)) |>
  filter(name %in% names(var_files)) |>
  anti_join(truth, by = c("location_name", "location", "date", "name"))

truth <- truth |>
  bind_rows(legacy) |>
  # add epi weeks for aggregation
  mutate(date = lubridate::ymd(date),
         epi_week = lubridate::epiweek(date),
         epi_year = lubridate::epiyear(date)) |>
  group_by(location, epi_year, epi_week, name) |>
  # aggregate to weekly incidence
  summarise(date = max(date),
            value = sum(value),
            .groups = "drop") |>
  # only keep Saturdays
  pivot_wider() |>
  filter(lubridate::wday(date, label = TRUE) == "Sat") |>
  # reformat
  arrange(date, location) |>
  select(-epi_week, -epi_year) |>
  as.data.frame()

write_csv(truth, "viz/truth_to_plot.csv", quote = "needed")
save(truth, file = "viz/truth.RData")
