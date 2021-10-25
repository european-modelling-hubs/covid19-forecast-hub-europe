library("readr")
library("dplyr")
library("here")
library("lubridate")
library("ggplot2")
library("janitor")

scraped_previous <- read_csv(here::here("data", "COVID-2021-10-17.csv")) %>%
  clean_names()

scraped <- read_csv(here::here("data", "COVID-2021-10-24.csv")) %>%
  clean_names()

pop <- scraped %>%
  select(country = country_name, population) %>%
  distinct()

official <- read_csv("https://opendata.ecdc.europa.eu/covid19/hospitalicuadmissionrates/csv/data.csv") %>%
  inner_join(pop, by = "country") %>%
  rename(unscaled_value = value) %>%
  mutate(value = if_else(grepl("100k", indicator),
                         round(unscaled_value * population / 1e+5),
                         unscaled_value)) %>%
  filter(grepl("hospital admissions", indicator)) %>%
  select(country, date, value, source) %>%
  mutate(source = if_else(grepl("TESSy", source), "TESSy", "Public"),
         type = "ECDC")

official_previous <- read_csv(here::here("data", "official-2021-10-07.csv")) %>%
  inner_join(pop, by = "country") %>%
  rename(unscaled_value = value) %>%
  mutate(value = if_else(grepl("100k", indicator),
                         round(unscaled_value * population / 1e+5),
                         unscaled_value)) %>%
  filter(grepl("hospital admissions", indicator)) %>%
  select(country, date, value, source) %>%
  mutate(source = if_else(grepl("TESSy", source), "TESSy", "Public"),
         type = "ECDC old")


scraped <- scraped %>%
  filter(indicator == "New_Hospitalised") %>%
  select(country = country_name, date, source, value) %>%
  mutate(source = if_else(grepl("TESSy", source), "TESSy", "Public"),
         type = "Scraped")

scraped_previous <- scraped_previous %>%
  filter(indicator == "New_Hospitalised") %>%
  select(country = country_name, date, source, value) %>%
  mutate(source = if_else(grepl("TESSy", source), "TESSy", "Public"),
         type = "Scraped old")

## shift +1 for comparison with weeks ending on the same weekday
scraped_shifted <- scraped %>%
  mutate(date = date + 1,
         type = "Scraped, MMWR week")

scraped_weekly <- scraped %>%
  bind_rows(scraped_shifted) %>%
  bind_rows(scraped_previous) %>%
  mutate(week_end = ceiling_date(date, unit = "week", week_start = 7)) %>%
  group_by(country, date = week_end, source, type) %>%
  summarise(value = sum(value), .groups = "drop")

all <- official %>%
  bind_rows(official_previous) %>%
  bind_rows(scraped_weekly) %>%
  mutate(type_source = paste0(source, " (", type, ")")) %>%
  filter(date >= "2021-05-01")

p <- ggplot(all %>%
            filter(!grepl("MMWR", type)),
            aes(x = date, y = value, colour = type_source)) +
  geom_line(alpha = 0.5) +
  geom_point(alpha = 0.5) +
  scale_colour_brewer("", palette = "Set1") +
  facet_wrap(~country, scale = "free_y") +
  theme_minimal()

ggsave(here::here("figures", "hosp_data_type_source.pdf"), p, width = 18, height = 12)

p <- ggplot(all %>%
            filter(!grepl("MMWR", type)),
            aes(x = date, y = value, colour = type)) +
  geom_line(alpha = 0.5) +
  geom_point(alpha = 0.5) +
  scale_colour_brewer("", palette = "Set1") +
  facet_wrap(~country, scale = "free_y") +
  theme_minimal()

ggsave(here::here("figures", "hosp_data_type.pdf"), p, width = 18, height = 12)

p <- ggplot(all %>%
            filter(grepl("Scraped", type)),
            aes(x = date, y = value, colour = type)) +
  geom_line(alpha = 0.5) +
  geom_point(alpha = 0.5) +
  scale_colour_brewer("", palette = "Dark2") +
  facet_wrap(~country, scale = "free_y") +
  theme_minimal()

ggsave(here::here("figures", "hosp_data_week_def.pdf"), p, width = 18, height = 12)
