library(dplyr)
library(here)
library(readr)
library(purrr)
library(tidyr)

# FIXME: find a way to get this information directly from the config file
# without hardcoding target types
truth <- c(
  "inc_death" = "JHU/truth_JHU-Incident Deaths.csv",
  "inc_case" = "JHU/truth_JHU-Incident Cases.csv",
  "inc_hosp" = "ECDC/truth_ECDC-Incident Hospitalizations.csv"
) %>%
  imap(~ read_csv(here("data-truth", .x)) %>% mutate(name = .y)) %>%
  bind_rows()

truth <- truth %>%
  # add epi weeks for aggregation
  mutate(date = lubridate::ymd(date),
         epi_week = lubridate::epiweek(date),
         epi_year = lubridate::epiyear(date)) %>%
  group_by(location, location_name, epi_year, epi_week, name) %>%
  # aggregate to weekly incidence
  summarise(date = max(date),
            value = sum(value),
            .groups = "drop") %>%
  # only keep Saturdays
  pivot_wider() %>%
  filter(lubridate::wday(date, label = TRUE) == "Sat") %>%
  # reformat
  arrange(date, location) %>%
  as.data.frame()

write_csv(truth, "viz/truth_to_plot.csv", quote = "needed")
save(truth, file = "viz/truth.RData")
