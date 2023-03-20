library("dplyr")
library("tidyr")

cat("Creating reporting triangles.\n")

cutoff_days <- 28

owid_dir <- here::here("data-truth", "OWID")
snapshot_dir <- file.path(owid_dir, "snapshots")

triangle_file <- file.path(owid_dir, "reporting-triangles.csv")

snapshot_files <- list.files(snapshot_dir)
snapshot_dates <- as.Date(
  sub("^covid-hospitalizations_(.*)\\.csv", "\\1", snapshot_files)
)

hosp_data <- readr::read_csv(here::here(
  "data-truth", "OWID", "truth_OWID-Incident Hospitalizations.csv"
  ),
  show_col_types = FALSE
)
hosp_locations <- sort(unique(hosp_data$location_name))

if (file.exists(triangle_file)) {
  df <- readr::read_csv(triangle_file) |>
    tidyr::pivot_longer(vars(-date), names_to = "delay")

  snapshot_dates <- snapshots_dates[snapshot_dates > max(df$date)]
}

## create snapshot dataset
snapshots <- purrr::map(snapshot_dates,
  \(x) read_csv(
    file.path(snapshot_dir, grep(x, snapshot_files, value = TRUE)),
    show_col_types = FALSE
  ) |>
    dplyr::mutate(snapshot_date = x)
) |>
  dplyr::bind_rows() |>
  dplyr::mutate(delay = as.integer(snapshot_date - date)) |>
  dplyr::filter(
    date >= min(snapshot_date) + days(cutoff_days),
    delay <= cutoff_days
  ) |>
  dplyr::select(-snapshot_date, -source) |>
  tidyr::pivot_wider(names_from = "delay")
