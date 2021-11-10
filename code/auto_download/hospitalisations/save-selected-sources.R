# Select data sources, combine, and save as single truth file
library(dplyr)
library(readr)
library(here)
library(lubridate)
library(ggplot2)
library(tidyr)
library(scales)

data_dir <- here("data-truth", "ECDC")

cat("Combining and selecting hospitalisation sources and saving\n")

# ECDC data ---------------------------------------------------------------
# Get downloaded ECDC data
official <- read_csv(here(data_dir, "raw", "official.csv"))
scraped <- read_csv(here(data_dir, "raw", "scraped.csv"))

# Aggregate scraped daily data into weekly
#    using ISO weeks (Monday-Sunday), to match official data source
scraped_weekly <- scraped %>%
  mutate(week_end = ceiling_date(date, unit = "week", week_start = 7)) %>%
  group_by(location_name, location,
           date = week_end, source, type) %>%
  summarise(value = sum(value), n = n(), .groups = "drop") %>%
  filter(n == 7) %>%
  select(-n)

# Select appropriate source (pre-set)
sources <- read_csv(here("code", "auto_download", "hospitalisations", 
                         "check-sources", "sources.csv")) %>%
  mutate(selected_source = TRUE)

# Combine all ECDC sources
ecdc_all <- bind_rows(official, scraped_weekly) %>%
  # Identify the named source-type combination for each country
  left_join(sources, by = c("location_name", "source", "type")) %>% 
  # Truncate weeks
  group_by(location_name, source, type) %>% 
  mutate(week_order = row_number(desc(date))) %>%
  ungroup() %>%
  filter((selected_source == TRUE & week_order > truncate_weeks) | 
           is.na(selected_source))

# Non-ECDC data -----------------------------------------------------------
# Aggregate to weekly: Mon-Sun
non_eu <- read_csv(here(data_dir, "raw", "non-eu.csv")) %>% 
  # Set ISO weeks (same as ECDC week definition)
  mutate(iso_year = isoyear(date),
         iso_week = isoweek(date)) %>% 
  # Aggregate
  group_by(location_name, location, source, type,
           iso_year, iso_week) %>% 
  summarise(value = sum(value, na.rm = TRUE), 
            date = max(date),
            n = n(),
            .groups = "drop") %>%
  filter(n == 7)

# Plot all countries/sources ----------------------------------------------
all <- bind_rows(ecdc_all, 
                 non_eu %>%
                   mutate(selected_source = TRUE)) %>%
  mutate(origin = paste(source, type, sep = "-")) %>%
  select(location_name, location, date, value, selected_source, origin)

plot_all <- all %>%
  filter(date >= Sys.Date() - 6*7 &
           location_name %in% c(sources$location_name, non_eu$location_name)) %>%
  mutate(selected_source = replace_na(selected_source, FALSE)) %>%
  ggplot(aes(x = date, y = value, 
             colour = origin, 
             shape = selected_source)) +
  geom_line(aes(alpha = selected_source)) +
  geom_point() +
  scale_y_continuous(labels = scales::label_comma(accuracy = 1)) +
  facet_wrap(~ location_name, scales = "free_y") +
  labs(x = NULL, y = NULL, 
       shape = "Selected for hub",
       alpha = "Selected for hub",
       colour = "Origin",
       subtitle = "Weekly incident hospital admissions") +
  theme_classic() + 
  theme(legend.position = "bottom")

ggsave(here("data-truth", "plots", "hospitalisations.jpg"), 
       plot_all, width = 13, height = 7)

# Combine + save ------------------------------------------------------------
# Include only countries with a selected source
ecdc <- ecdc_all %>%
  filter(selected_source)
hosp_data <- bind_rows(ecdc, non_eu) %>%
  select(location_name, location, date, value, source, type)

# Shift dates to represent Sun-Sat MMWR epiweek 
#   - all hosp data so far (daily/weekly) are consistently Mon-Sun aggregated
#   - but case/death week definitions are Sat-Sun aggregated
#   - shift all hosp data (weekly) back by 1 day; all countries consistent
hosp_data <- hosp_data %>%
  mutate(date = date - 1)

# Save as "truth" file, covidHubUtils format
write_csv(hosp_data, 
          file = here("data-truth", "ECDC",
                      "truth_ECDC-Incident Hospitalizations.csv"), 
          append = FALSE)
