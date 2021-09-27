library(gh)
library(purrr)

get_all_versions <- function(file, gh_repo) {

  gh(
    "/repos/{gh_repo}/commits?path={file}",
    gh_repo = gh_repo,
    file = file
  ) %>%
    map_chr("sha") %>%
    map_chr(~ glue::glue(
      "https://raw.githubusercontent.com/{gh_repo}/{sha}/{file}",
      gh_repo = gh_repo,
      sha = .x,
      file = file
    )) %>%
    map_chr(utils::URLencode)

}

all_hospdata_versions <- get_all_versions(
  "data-truth/ECDC/truth_ECDC-Incident Hospitalizations.csv",
  "epiforecasts/covid19-forecast-hub-europe"
) %>%
  map(readr::read_csv, show_col_types = FALSE, progress = FALSE)

library(dplyr)
adjusted_hospdata <- all_hospdata_versions %>%
  map(group_by, location) %>%
  map(arrange, date) %>%
  map(mutate, cum_value = cumsum(value), .keep = "unused") %>%
  map(filter, date == max(date)) %>%
  bind_rows() %>%
  distinct() %>%
  arrange(location, date) %>%
  mutate(value = cum_value - lag(cum_value), .keep = "unused")

write_csv(
  adjusted_hospdata,
  "data-truth/ECDC/truth_ECDC-Incident Hospitalizations.csv"
)

