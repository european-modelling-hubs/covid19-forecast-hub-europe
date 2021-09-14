library(dplyr)
library(here)
library(readr)

df_case <- read_csv(here("data-truth/JHU/truth_JHU-Incident Deaths.csv")) %>%
  rename(inc_death = value)

df_death <- read_csv(here("data-truth/JHU/truth_JHU-Incident Cases.csv")) %>%
  rename(inc_case = value)

df_hosp <- read_csv(here("data-truth/ECDC/truth_ECDC-Incident Hospitalizations.csv")) %>%
  rename(inc_hosp = value)

df <- full_join(df_case, df_death, by = c("date", "location", "location_name"))
df <- full_join(df, df_hosp, by = c("date", "location", "location_name"))

df <- df %>%
  # add epi weeks for aggregation
  mutate(date = lubridate::ymd(date),
         epi_week = lubridate::epiweek(date),
         epi_year = lubridate::epiyear(date)) %>%
  group_by(location, location_name, epi_year, epi_week) %>%
  # aggregate to weekly incidence
  summarise(date = max(date),
            inc_death = sum(inc_death),
            inc_case = sum(inc_case),
            inc_hosp = sum(inc_hosp)) %>%
  ungroup() %>%
  # only keep Saturdays
  filter(lubridate::wday(date, label = TRUE) == "Sat") %>%
  # reformat
  select(date, location, location_name, inc_case, inc_death, inc_hosp) %>%
  arrange(date, location)

write_csv(df, "viz/truth_to_plot.csv", quote = "needed")
