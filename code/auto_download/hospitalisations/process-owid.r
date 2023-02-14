library("readr")
library("lubridate")

cat("Processing OWID data.\n")

cutoff_days <- 28

owid_dir <- here::here("data-truth", "OWID")
snapshot_dir <- file.path(owid_dir, "snapshots")
final_dir <- file.path(owid_dir, "final")

snapshot_files <- list.files(snapshot_dir)
final_files <- list.files(final_dir)

snapshot_dates <- as.Date(
  sub("^covid-hospitalizations_(.*)\\.csv", "\\1", snapshot_files)
)

if (length(final_files) > 0) {
  final_dates <- as.Date(
    sub("^covid-hospitalizations-final_(.*)\\.csv", "\\1", final_files)
  )
  max_final_date <- max(final_dates)
  init <- read_csv(
    file.path(final_dir, final_files[final_dates == max_final_date]),
    show_col_types = FALSE
  )
  min_snapshot_date <- max(final_dates) + days(1)
} else {
  min_snapshot_date <- min(snapshot_dates)
  init <- read_csv(
    file.path(
      snapshot_dir, snapshot_files[snapshot_dates == min(snapshot_dates)]
    ), show_col_types = FALSE
  ) |>
    mutate(snapshot_date = min(snapshot_dates)) |>
    filter(date <= min_snapshot - days(cutoff_days))
  snapshot_dates <- snapshot_dates[snapshot_dates > min_snapshot_date]
  min_snapshot_date <- min(snapshot_dates)
}
max_snapshot_date <- max(snapshot_dates)

## create final dataset
snapshots <- map(snapshot_dates[snapshot_dates >= min_snapshot_date],
  \(x) read_csv(
    file.path(snapshot_dir, grep(x, snapshot_files, value = TRUE)),
    show_col_types = FALSE
  ) |>
    mutate(snapshot_date = x) |>
    filter(snapshot_date >= date + days(cutoff_days))
)

df <- init |>
  bind_rows(snapshots) |>
  group_by(date) |>
  filter(snapshot_date == min(snapshot_date)) |>
  ungroup() |>
  distinct()

write_csv(df, file.path(
  final_dir, paste0(
    "covid-hospitalizations-final_",
    max_snapshot_date - days(cutoff_days) + 1,
    ".csv"
  ))
)
