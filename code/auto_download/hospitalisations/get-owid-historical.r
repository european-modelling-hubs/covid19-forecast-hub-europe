library("gh")
library("lubridate")
library("covidHubUtils")
library("purrr")
library("dplyr")
library("vroom")

get_owid_historical <- function(earliest_date = lubridate::today()) {
  ## set path to covid data
  owner <- "owid"
  repo <- "covid-19-data"
  path <- "public/data/hospitalizations/covid-hospitalizations.csv"
  ## define locations we want to pull
  pop <- covidHubUtils::hub_locations_ecdc |>
    dplyr::select(location_name, location)

  ## query to receive past commits
  query <- "/repos/{owner}/{repo}/commits?path={path}&since={date}"

  commits <-
    gh::gh(query,
           owner = owner,
           repo = repo,
           path = path,
           date = earliest_date - 1,
           .limit = Inf)

  ## extract dates of commits
  commit_dates <- purrr::map_df(
    commits,
    ~ tibble::tibble(sha = .x$sha, date = .x$commit$author$date)
  ) |>
    dplyr::mutate(
      datetime = lubridate::ymd_hms(sub("T(.+)Z$", " \\1", date)),
      date = lubridate::date(datetime)
    )

  dl_snapshot <- function(x) {
    ## find latest commit at 12:07 each day
    data_commit <- commit_dates |>
      dplyr::filter(datetime < lubridate::ymd_hms(paste(x, "12:07:00")))

    if (nrow(data_commit) == 0) return(NULL)

    data_commit <- data_commit |>
      dplyr::filter(datetime == max(datetime))

    data <- vroom::vroom(paste(
      "https://raw.githubusercontent.com",
      owner, repo, data_commit$sha,
      path, sep = "/"
    ), show_col_types = FALSE) |>
      dplyr::rename(location_name = entity) |>
      dplyr::inner_join(pop, by = "location_name") |>
      dplyr::filter(grepl("hospital admissions$", indicator)) |>
      dplyr::select(location_name, location, date, value) %>%
      dplyr::mutate(source = "OWID")

    data_dir <- here::here("data-truth", "OWID", "snapshots")
    owid_filepath_dated <- here::here(data_dir,
      paste0("covid-hospitalizations_", x, ".csv")
    )
    vroom::vroom_write(data, owid_filepath_dated, delim = ",")
    return(data)
  }

  ## save snapshots
  snapshots <- purrr::map(
    seq(earliest_date, lubridate::today(), by = "day"),
    dl_snapshot
  )

  return(snapshots)
}
