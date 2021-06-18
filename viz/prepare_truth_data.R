library(here)
library(dplyr)
library(readr)
library(lubridate)

df1 <- read_csv(here("data-truth", "JHU", "truth_JHU-Incident Deaths.csv")) %>%
  rename(inc_death = value)

df2 <- read_csv(here("data-truth", "JHU", "truth_JHU-Incident Cases.csv")) %>%
  rename(inc_case = value)

# merge cases and deaths into one dataframe
df <- full_join(df1, df2, by = c("date", "location", "location_name"))

# add epi weeks for aggregation
df <- df %>%
  mutate(epi_week = epiweek(date),
         epi_year = epiyear(date))

# aggregate to weekly incidence
df <- df %>%
  group_by(location, location_name, epi_year, epi_week) %>%
  summarise(date = max(date),
            inc_death = sum(inc_death),
            inc_case = sum(inc_case),
            .groups = "drop")

# only keep Saturdays
df <- df %>%
  filter(wday(date, label = TRUE, abbr = FALSE) == "Saturday")

# reformat
df <- df %>%
  select(date, location, location_name, inc_case, inc_death) %>%
  arrange(date, location)

write_csv(df, here("viz", "truth_to_plot.csv"))
