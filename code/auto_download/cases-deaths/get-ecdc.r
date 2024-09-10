library("gh")
library("lubridate")
library("covidHubUtils")
library("purrr")
library("tidyr")
library("dplyr")
library("vroom")
library("tibble")
library("ISOweek")

get_ecdc <- function(earliest_date = lubridate::today() - 7,
                     latest_date = lubridate::today()) {
  ## set path to covid data
  owner <- "EU-ECDC"
  repo <- "Respiratory_viruses_weekly_data"
  snapshots_path <- "data/snapshots"
  local_path <- here::here("data-truth/ECDC/snapshots")
  if (!dir.exists(local_path)) dir.create(local_path)

  ## get snapshots
  query <- "/repos/{owner}/{repo}/contents/{path}"

  files <-
    gh::gh(query,
           owner = owner,
           repo = repo,
           path = snapshots_path,
           .limit = Inf)
  file_names <- vapply(files, `[[`, "name", FUN.VALUE = "") |>
    grep(pattern = "nonSentinel", value = TRUE)
  existing_files <- list.files(
    here::here("data-truth", "ECDC", "snapshots"),
    pattern = "nonSentinel"
  )

  process_files <- setdiff(file_names, existing_files)

  ## define locations we want to pull
  pop <- covidHubUtils::hub_locations_ecdc |>
    dplyr::select(location_name, location)

  dl_snapshot <- function(file) {
    file_date <- as.Date(
      sub("^.*([0-9]{4}-[0-9]{2}-[0-9]{2}).*$", "\\1", file)
    )
    if (file_date >= earliest_date && file_date <= latest_date)  {
      df <- vroom::vroom(paste0(
        "https://raw.githubusercontent.com/EU-ECDC/",
        "Respiratory_viruses_weekly_data/main/data/snapshots/", file
      ), show_col_types = FALSE) |>
        dplyr::filter(pathogen == "SARS-CoV-2", age == "total") |>
        dplyr::mutate(
          target_variable = recode(indicator,
            "deaths" = "inc death",
            "detections" = "inc case",
            "hospitalizations" = "inc hospitalization"
          ),
          date = ISOweek::ISOweek2date(paste0(yearweek, "-6")),
          source = "ECDC"
        ) |>
        dplyr::rename(location_name = countryname) |>
        dplyr::inner_join(pop, by = c("location_name")) |>
        dplyr::select(
          location_name, location, target_variable, date, value, source
        )
      return(df)
    } else {
      return(NULL)
    }
  }

  ## save snapshots
  snapshots <- tibble(
    file_name = process_files,
    data = purrr::map(process_files, dl_snapshot)
  ) |>
    dplyr::mutate(
      file_date = as.Date(
        sub("^.*([0-9]{4}-[0-9]{2}-[0-9]{2}).*$", "\\1", file_name)
      ),
      file = file.path(
        local_path, paste0("covid-cases-deaths_", file_date, ".csv")
      )
    ) |>
    dplyr::group_by(file) |>
    dplyr::summarise(
      x = list(bind_rows(data)),
      n = nrow(x[[1]]),
      .groups = "keep"
    ) |>
    dplyr::filter(n > 0) |>
    dplyr::select(-n) |>
    purrr::pmap(vroom::vroom_write, delim = ", ")

  return(snapshots)
}
