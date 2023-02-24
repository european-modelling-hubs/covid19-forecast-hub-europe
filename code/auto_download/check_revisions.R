library("gh")
library("lubridate")
library("dplyr")
library("ggplot2")
library("here")
library("readr")
library("svglite")

earliest_date <- NULL
min_data <- as.Date("2021-03-08") ## earliest date to pot in data

sources <-
  c(Cases = "JHU",
    Deaths = "JHU",
    Hospitalizations = "OWID")

target_variables <-
  c(Cases = "inc case",
    Deaths = "inc death",
    Hospitalizations = "inc hosp")

owner <- "covid19-forecast-hub-europe"
repo <- "covid19-forecast-hub-europe"
path <- vapply(names(sources), function(x) {
  paste("data-truth", sources[[x]],
        paste0("truth_", sources[[x]], "-Incident ", x, ".csv"),
        sep = "/")
}, "")
names(path) <- names(sources)

data <- list()
for (source in names(sources)) {
  query <- "/repos/{owner}/{repo}/commits?path={path}"
  if (!is.null(earliest_date)) {
    query <- paste0(query, "&since={date}")
  }
  commits <-
    gh::gh(query,
      owner = owner,
      repo = repo,
      path = path[source],
      date = earliest_date,
      .limit = Inf
    )
  shas <- vapply(commits, "[[", "", "sha")
  dates <- vapply(commits, function(x) x[["commit"]][["author"]][["date"]], "")
  dates <- as_date(ymd_hms(dates))
  ## keep multiples of 7 since today
  select_commits <- which(as.integer(max(dates) - dates) %% 7 == 0)
  data[[source]] <-
    lapply(
      select_commits,
      function(id)
        readr::read_csv(
                 URLencode(
                      paste("https://raw.githubusercontent.com", owner, repo,
                            shas[id], path[source], sep = "/")),
                 show_col_types = FALSE) %>%
        mutate(commit_date = dates[id])
    )
  # remove empty dataframes
  if (class(data[[source]]) == "list") {
    data[[source]] <- data[[source]][sapply(data[[source]], function(x) nrow(x)>0)]
  }
  data[[source]] <- data[[source]] %>%
    bind_rows() %>%
    mutate(type = {{ source }})
}

data <- data %>%
  bind_rows() %>%
  filter(date >= min_data) %>%
  mutate(target_end_date = ceiling_date(date, "week", week_start = 6),
         source = if_else(is.na(source), "JHU", source)) %>%
  group_by(location, location_name, target_end_date, commit_date, type) %>%
  summarise(value = sum(value), n = n(), .groups = "drop") %>%
  filter(n == 7 | type == "Hospitalizations") %>% ## only complete weeks
  select(-n)

source_path <-
  "code/auto_download/hospitalisations/check-sources/sources.csv"
source_commits <-
  gh::gh(query,
    owner = owner,
    repo = repo,
    path = source_path,
    date = earliest_date,
    .limit = Inf
    )
source_shas <- vapply(source_commits, "[[", "", "sha")
source_dates <-
  vapply(source_commits, function(x) x[["commit"]][["author"]][["date"]], "")
source_dates <- as_date(ymd_hms(source_dates))

source_data <-
  lapply(
    seq_along(source_commits),
    function(id) {
      tryCatch(
        readr::read_csv(URLencode(
          paste("https://raw.githubusercontent.com", owner, repo,
            source_shas[id], source_path, sep = "/")),
          show_col_types = FALSE) |>
          mutate(commit_date = source_dates[id]),
        error = function(e) NULL
      )
    }
  )

source_data <- bind_rows(source_data) |>
  group_by(location_name, source, type, truncate_weeks) |>
  filter(commit_date == min(commit_date)) |>
  group_by(location_name) |>
  filter(commit_date == max(commit_date)) |>
  ungroup() |>
  select(location_name, commit_date) |>
  distinct()

anomalies_sources <- data |>
  filter(type == "Hospitalizations") |>
  mutate(target_variable = "inc hosp",
         anomaly = "Replaced data source") |>
  select(target_end_date, target_variable, location, location_name, anomaly) |>
  inner_join(source_data, by = "location_name") |>
  filter(target_end_date <= commit_date) |>
  distinct() |>
  select(-commit_date)

anomalies_raw <- data %>%
  filter(type != "Hospitalizations") %>%
  group_by(location, location_name, target_end_date, type) %>%
  summarise(abs_diff = max(value) - min(value),
            rel_diff = abs_diff / max(value),
            .groups = "drop") %>%
  filter(target_end_date >= min_data, !is.na(rel_diff), rel_diff > 0.05)
anomalies_revisions <- anomalies_raw %>%
  group_by(location, location_name, target_end_date, type) %>%
  summarise(anomaly = "large data revision", .groups = "drop") %>%
  mutate(target_variable = target_variables[type]) %>%
  select(target_end_date, target_variable, location, location_name, anomaly)

anomalies <- bind_rows(anomalies_sources, anomalies_revisions) |>
  group_by(target_end_date, target_variable, location, location_name) |>
  slice(1) |>
  ungroup()

anomalies_file <- here::here("data-truth", "anomalies", "anomalies.csv")
existing_anomalies <- read_csv(anomalies_file, show_col_types = FALSE)

new_anomalies <- anomalies %>%
  anti_join(existing_anomalies,
            by = c("target_end_date", "target_variable", "location",
                   "location_name"))

all_anomalies <- rbind(existing_anomalies, new_anomalies) %>%
  arrange(target_end_date, target_variable, location, location_name)

write_csv(all_anomalies, anomalies_file)

for (source in names(sources)) {
  cleaned <- data %>%
    filter(type == {{ source }},
           commit_date >= max(commit_date) - weeks(10)) %>% ## plot 10 weeks
    mutate(target_variable = target_variables[type]) %>%
    anti_join(
      all_anomalies,
      by = c("target_end_date", "target_variable", "location", "location_name")
    )
  p <- ggplot(cleaned, aes(x = target_end_date, y = value,
                          colour = factor(commit_date), group = commit_date)) +
    scale_colour_brewer("Commit date", palette = "Paired") +
    facet_wrap(~ location_name, scales = "free") +
    geom_line() +
    theme_minimal() +
    ylab(source) + xlab("End of MMWR week")
  ggsave(here::here("data-truth", "plots",
                    paste0("revisions-", source, ".svg")),
         p,  width = 20, height = 12)
}


