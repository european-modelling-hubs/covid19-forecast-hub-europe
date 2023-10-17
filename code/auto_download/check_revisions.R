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
  c(Cases = "ECDC",
    Deaths = "ECDC",
    Hospitalizations = "OWID")

target_variables <-
  c(Cases = "inc case",
    Deaths = "inc death",
    Hospitalizations = "inc hosp")

owner <- "european-modelling-hubs"
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
                 show_col_types = FALSE) |>
        mutate(commit_date = dates[id])
    )
  # remove empty dataframes
  if (class(data[[source]]) == "list") {
    data[[source]] <- data[[source]][sapply(data[[source]], function(x) nrow(x)>0)]
  }
  data[[source]] <- data[[source]] |>
    bind_rows() |>
    mutate(type = {{ source }})

  ## fix needed as some hospitalisation data had a target_end_date variable
  if ("target_end_date" %in% colnames(data[[source]])) {
    data[[source]] <- data[[source]] |>
      dplyr::mutate(date = dplyr::if_else(is.na(date), target_end_date, date)) |>
      dplyr::select(-target_end_date)
  }
}

data <- data |>
  dplyr::bind_rows(.id = "variable") |>
  dplyr::mutate(target_variable = target_variables[variable]) |>
  dplyr::filter(date >= min_data) |>
  dplyr::rename(target_end_date = "date")

source_path <-
  "data-locations/locations_eu.csv"
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

source_data <- dplyr::bind_rows(source_data) |>
  tidyr::pivot_longer(
    dplyr::starts_with("inc_"), names_to = "target_variable"
  ) |>
  dplyr::mutate(target_variable = sub("_", " ", target_variable)) |>
  dplyr::group_by(location_name, location, target_variable) |>
  dplyr::filter(value == value[1]) |>
  dplyr::slice_min(commit_date) |>
  dplyr::ungroup() |>
  dplyr::select(location_name, target_variable, commit_date)

anomalies_sources <- data |>
  dplyr::mutate(anomaly = "Replaced data source") |>
  dplyr::select(
    target_end_date, target_variable, location, location_name, anomaly
  ) |>
  dplyr::inner_join(source_data, by = c("location_name", "target_variable")) |>
  dplyr::filter(target_end_date <= commit_date) |>
  dplyr::distinct() |>
  dplyr::select(-commit_date)

anomalies_file <- here::here("data-truth", "anomalies", "anomalies.csv")
existing_anomalies <- read_csv(anomalies_file, show_col_types = FALSE)

new_anomalies <- anomalies_sources |>
  anti_join(existing_anomalies,
            by = c("target_end_date", "target_variable", "location",
                   "location_name"))

all_anomalies <- rbind(existing_anomalies, new_anomalies) |>
  arrange(target_end_date, target_variable, location, location_name)

write_csv(all_anomalies, anomalies_file)

for (source in names(sources)) {
  cleaned <- data |>
    dplyr::filter(
      type == {{ source }},
      commit_date >= max(commit_date) - weeks(10)
    ) |> ## plot 10 weeks
    dplyr::mutate(target_variable = target_variables[type]) |>
    dplyr::anti_join(
      all_anomalies,
      by = c("target_end_date", "target_variable", "location", "location_name")
    )
  if (nrow(cleaned) > 0) {
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
}
