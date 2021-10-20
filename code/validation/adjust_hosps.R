library(gh)
library(purrr)
library(dplyr)

get_all_versions <- function(file, gh_repo) {

  gh(
    "/repos/{gh_repo}/commits?path={file}",
    gh_repo = gh_repo,
    file = file
  ) %>%
    map_dfr(~ c("commit_sha" = .x[["sha"]],
                "commit_date" = .x[["commit"]]$author$date)) %>%
    mutate(file_url = glue::glue(
      "https://raw.githubusercontent.com/{gh_repo}/{sha}/{file}",
      gh_repo = .env$gh_repo,
      sha = .data$commit_sha,
      file = .env$file
    ), .keep = "unused") %>%
    mutate(file_url = utils::URLencode(file_url),
           commit_date = as.Date(lubridate::ymd_hms(commit_date)))

}

all_hospdata_versions <- get_all_versions(
  "data-truth/ECDC/truth_ECDC-Incident Hospitalizations.csv",
  "epiforecasts/covid19-forecast-hub-europe"
) %>%
  mutate(df = map(file_url, readr::read_csv, show_col_types = FALSE, progress = FALSE),
         .keep = "unused")

adjusted_hospdata <- all_hospdata_versions %>%
  mutate(df = map(df, group_by, location)) %>%
  mutate(df = map(df, summarise, cum_value = sum(value), .groups = "drop")) %>%
  tidyr::unnest(df) %>%
  arrange(location, commit_date) %>%
  group_by(location) %>%
  mutate(value = cum_value - lag(cum_value), .keep = "unused") %>%
  group_by(location, commit_week = lubridate::epiweek(commit_date)) %>%
  summarise(weekly_value = sum(value), .groups = "drop")

write_csv(
  adjusted_hospdata,
  "data-truth/ECDC/corrected_truth_ECDC-Incident Hospitalizations.csv"
)

