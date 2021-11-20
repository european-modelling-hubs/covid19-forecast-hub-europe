library("readr")
library("dplyr")
library("here")
library("lubridate")
library("ggplot2")
library("janitor")
library("tidyr")
library("gh")

owner <- "epiforecasts"
repo <- "covid19-forecast-hub-europe"
path <- c(scraped = "data-truth/ECDC/raw/scraped.csv",
          official = "data-truth/ECDC/raw/official.csv")

commits <-
  lapply(path, function(x) {
    gh("/repos/{owner}/{repo}/commits?path={path}",
       owner = owner,
       repo = repo,
       path = x,
       .limit = Inf)
  })

shas <- lapply(commits, lapply, function(x) {
  return(tibble(sha = x$sha,
                download_date = as.Date(x$commit$author$date)))
})
shas <- lapply(shas, bind_rows)

## thin scraped
shas$scraped <- shas$scraped %>%
  filter(as.integer(max(download_date) - download_date) %% 7 == 0,
         !duplicated(download_date))

hosp_data <-
  lapply(names(path), function(source) {
    apply(shas[[source]], 1, function(x) {
      read_csv(
        paste("https://raw.githubusercontent.com", owner, repo, x[["sha"]], path[[source]],
              sep = "/")
      ) %>%
        mutate(download_date = as.Date(x[["download_date"]]))
    })
  })

names(hosp_data) <- names(path)
hosp_data <- lapply(hosp_data, bind_rows)

hosp_data$scraped <- hosp_data$scraped %>%
  mutate(week_end = ceiling_date(date, unit = "week", week_start = 7)) %>%
  group_by(location_name, date = week_end, source, type, download_date) %>%
  summarise(value = sum(value), n = n(), .groups = "drop") %>%
  filter(n == 7) %>%
  select(-n)

all <- bind_rows(hosp_data) %>%
  filter(date >= "2021-05-01") %>%
  ## download delay in days
  mutate(download_delay = as.integer(download_date - date)) %>%
  group_by(location_name, source, type, download_date) %>%
  mutate(data_delay = as.integer(max(date) - date)) %>%
  ungroup() %>%
  ## download_delay in weeks
  mutate(download_delay = ceiling(download_delay / 7),
         data_delay = data_delay / 7)

delays <- all %>%
  select(-download_date) %>%
  group_by(location_name, date, source, type) %>%
  mutate(final_value = value[which.max(download_delay)]) %>%
  ungroup() %>%
  mutate(rel_diff = (final_value - value) / final_value)

## don't use delays that would have recently resulted in final relative differences of >5%
dont_use <- delays %>%
  filter(date >= "2021-10-10", rel_diff > 0.05) %>%
  select(location_name, source, type, download_delay) %>%
  distinct() %>%
  arrange(location_name)

## filter out delays with unacceptable revisions
filtered <- all %>%
  anti_join(dont_use, by = c("location_name", "source", "type", "download_delay")) %>%
  group_by(location_name) %>%
  filter(date == max(date)) %>%
  filter(download_date == max(download_date))

## filter out delays of > 2 weeks
filtered <- filtered %>%
  filter(download_delay <= 2)

final_table <- filtered %>%
  select(location_name, source, type, truncate_weeks = data_delay) %>%
  ## sort to prefer: remove fewer weeks, Scraped over ECDC (because daily)
  arrange(location_name, truncate_weeks, desc(type)) %>%
  group_by(location_name) %>%
  ## take top choice in each country
  slice(1)

# remove some countries manually
exclude_locations <- c("Poland")
final_table <- final_table %>%
  filter(!location_name %in% exclude_locations)

write_csv(final_table, here::here("code", "auto_download",
                                  "hospitalisations",
                                  "check-sources", "sources.csv"))

## main plot: hospitalisation data
plot_data <- all %>%
  inner_join(final_table, by = c("location_name", "type")) %>%
  group_by(location_name) %>%
  filter(download_date == max(download_date)) %>%
  ungroup() %>%
  filter(download_delay >= truncate_weeks)

p <- ggplot(plot_data, aes(x = date, y = value, colour = type)) +
  scale_colour_brewer("", palette = "Set1") +
  facet_wrap(~location_name, scale = "free_y") +
  theme_minimal() +
  theme(legend.position = "bottom") +
  geom_point() +
  geom_line() +
  xlab("Last day of week shown (Saturday)") +
  ylab("Number of weekly hospitalisations")

ggsave(here::here("code", "auto_download", "hospitalisations.png"), p, width = 14, height = 10)
