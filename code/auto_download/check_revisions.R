library("gh")
library("lubridate")
library("dplyr")
library("ggplot2")
library("here")
library("readr")

earliest_date <- NULL
min_data <- as.Date("2021-03-08") ## earliest date to pot in data

sources <-
  c(Cases = "JHU",
    Deaths = "JHU",
    Hospitalizations = "ECDC")

target_variables <- 
  c(Cases = "inc case",
    Deaths = "inc death",
    Hospitalizations = "inc hosp")

owner <- "epiforecasts"
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
                            shas[id], path[source], sep = "/"))) %>%
        mutate(commit_date = dates[id])
    )

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

for (source in names(sources)) {
  source_data <- data %>%
    filter(type == {{ source }},
           commit_date >= max(commit_date) - weeks(10)) ## plot 10 weeks
  p <- ggplot(source_data, aes(x = target_end_date, y = value,
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

anomalies_raw <- data %>%
  group_by(location, location_name, target_end_date, type) %>%
  summarise(abs_diff = max(value) - min(value),
            rel_diff = abs_diff / max(value),
            .groups = "drop") %>%
  filter(target_end_date >= min_data, !is.na(rel_diff), rel_diff > 0.05)
anomalies <- anomalies_raw %>%
  group_by(location, location_name, target_end_date, type) %>%
  summarise(anomaly = "large data revision", .groups = "drop") %>%
  mutate(target_variable = target_variables[type]) %>%
  select(target_end_date, target_variable, location, location_name, anomaly)

hosp_sources <-
  read_csv(here::here("code", "auto_download", "hospitalisations",
                      "check-sources", "sources.csv"))

## exclude data sources not modelled
anomalies <- anomalies %>%
  filter(!(target_variable == "inc hosp" &
           location_name %in% hosp_sources$location_name))

anomalies_file <- here::here("data-truth", "anomalies", "anomalies.csv")
existing_anomalies <- read_csv(anomalies_file)

new_anomalies <- anomalies %>%
  anti_join(existing_anomalies,
            by = c("target_end_date", "target_variable", "location",
                   "location_name"))

all_anomalies <- rbind(existing_anomalies, new_anomalies) %>%
  arrange(target_end_date, target_variable, location, location_name)

write_csv(all_anomalies, anomalies_file)
