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
          official = "data-truth/ECDC/raw/official.csv",
          owid = "data-truth/OWID/covid-hospitalizations.csv")

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
for (to_thin in c("scraped", "owid")) {
  shas[[to_thin]] <- shas[[to_thin]] %>%
    filter(as.integer(max(download_date) - download_date) %% 7 == 0,
           !duplicated(download_date))
}

hosp_data <-
  lapply(names(path), function(source) {
    apply(shas[[source]], 1, function(x) {
      read_csv(
        paste("https://raw.githubusercontent.com", owner, repo, x[["sha"]], path[[source]],
              sep = "/"),
        show_col_types = FALSE
      ) %>%
        mutate(download_date = as.Date(x[["download_date"]]))
    })
  })

names(hosp_data) <- names(path)
hosp_data <- lapply(hosp_data, bind_rows)

for (to_weekly in c("scraped", "owid")) {
  hosp_data[[to_weekly]] <- hosp_data[[to_weekly]] %>%
    mutate(week_end = ceiling_date(date, unit = "week", week_start = 7)) %>%
    group_by(location_name, date = week_end, source, type, download_date) %>%
    summarise(value = sum(value), n = n(), .groups = "drop") %>%
    filter(n == 7) %>%
    select(-n)
}

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

## don't use delays that would have recently resulted in
## final relative differences of >5% in the last 3 months
dont_use <- delays %>%
  filter(date >= max(date) - 12 * 7, rel_diff > 0.05) %>%
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
  ## sort to prefer: remove fewer weeks, Scraped over ECDC (because daily), ECDC over OWID
  arrange(location_name, truncate_weeks, desc(type), desc(source)) %>%
  group_by(location_name) %>%
  ## take top choice in each country
  slice(1)

# remove some countries manually
exclude_locations <- c("Poland")
final_table <- final_table %>%
  filter(!location_name %in% exclude_locations)

write_csv(final_table, here::here("code", "auto_download",
                                  "hospitalisations",
                                  "check-sources", "sources_update.csv"))
