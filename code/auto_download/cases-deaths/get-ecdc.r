library("gh")
library("lubridate")
library("covidHubUtils")
library("purrr")
library("tidyr")
library("dplyr")
library("vroom")
library("ISOweek")

get_ecdc <- function(earliest_date = lubridate::today() - 7,
                     latest_date = lubridate::today()) {
  ## set path to covid data
  owner <- "EU-ECDC"
  repo <- "COVID-19_weekly-data"
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
  file_names <- vapply(files, `[[`, "name", FUN.VALUE = "")

  existing_files <- list.files(
    here::here("data-truth", "ECDC", "snapshots"),
    pattern = "COVID_19_weekly_cases_and_deaths"
  )

  process_files <- setdiff(file_names, existing_files)

  ## define locations we want to pull
  pop <- covidHubUtils::hub_locations_ecdc |>
    dplyr::select(location_name, location)

  dl_snapshot <- function(file) {
    file_date <- as.Date(
      sub("^.*([0-9]{4}-[0-9]{2}-[0-9]{2}).*$", "\\1", file)
    )
    if (file_date > earliest_date && file_date <= latest_date)  {
      df <- vroom::vroom(paste0(
        "https://raw.githubusercontent.com/EU-ECDC/COVID-19_weekly-data/",
        "main/data/snapshots/", file
      ), show_col_types = FALSE) |>
        tidyr::separate(year_week, c("year", "week"), sep = "-") |>
        dplyr::mutate(
          target_variable = paste(
            "inc", substr(indicator, 1, nchar(indicator) - 1)
          ),
          date = ISOweek::ISOweek2date(paste0(year, "-W", week, "-6")),
          source = "ECDC"
        ) |>
        dplyr::inner_join(pop, by = c("location_name", "location")) |>
        dplyr::select(
          location_name, location, target_variable, date, value, source
        )
      file_name <- paste0("covid-cases-deaths_", file_date, ".csv")
      vroom::vroom_write(df, file.path(local_path, file_name), delim = ",")
      return(df)
    } else {
      return(NULL)
    }
  }

  ## save snapshots
  snapshots <- purrr::map(process_files, dl_snapshot)

  return(snapshots)
}
