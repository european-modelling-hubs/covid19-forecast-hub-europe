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

final_dates <- seq(
  min(snapshot_dates), max(snapshot_dates),
  by = "day"
) - days(cutoff_days) + 1

if (length(final_files) > 0) {
  final_dates_present <- file.exists(
    file.path(final_dir, paste0(
      "covid-hospitalizations-final_", final_dates, ".csv")
    )
  )
  final_dates <- final_dates[!final_dates_present]
}

if (min(final_dates) == min(snapshot_dates) - days(28) + 1) {
  ## need to create first "final" dataset
  init <- read_csv(
    file.path(
      snapshot_dir, grep(min(snapshot_dates), snapshot_files, value = TRUE)
    ), show_col_types = FALSE
  ) |>
    mutate(snapshot_date = min(snapshot_dates)) |>
    filter(date <= min_snapshot - days(cutoff_days))
  write_csv(df, file.path(
    final_dir, paste0(
      "covid-hospitalizations-final_",
      min(final_dates),
      ".csv"
    ))
  )
  final_dates <-
    final_dates[!(final_dates == min(snapshot_dates) - days(28) + 1)]
}

snapshot_dates <- snapshot_dates[snapshot_dates >= min(final_dates)]

## create snapshot dataset
snapshots <- map(snapshot_dates,
  \(x) read_csv(
    file.path(snapshot_dir, grep(x, snapshot_files, value = TRUE)),
    show_col_types = FALSE
  ) |>
    mutate(snapshot_date = x)
) |>
  bind_rows()

for (final_date_chr in as.character(final_dates)) {
  final_date <- as.Date(final_date_chr)
  init <- read_csv(
    file.path(
      final_dir, paste0(
        "covid-hospitalizations-final_", final_date - days(1), ".csv"
      )
    ),
    show_col_types = FALSE
  )
  df <- init |>
    bind_rows(snapshots) |>
    filter(
      snapshot_date < final_date + days(cutoff_days),
      snapshot_date >= date + days(cutoff_days)
    ) |>
    group_by(date) |>
    filter(snapshot_date == min(snapshot_date)) |>
    ungroup() |>
    distinct()
  write_csv(df, file.path(
    final_dir, paste0(
      "covid-hospitalizations-final_", final_date, ".csv"
    ))
  )
}

latest_final <- read_csv(
  file.path(
    final_dir, paste0(
      "covid-hospitalizations-final_", max(final_dates), ".csv"
    )
  ),
  show_col_types = FALSE
)

latest_snapshot <- snapshots |>
  filter(snapshot_date == max(snapshot_date))

new_data <- latest_snapshot |>
  anti_join(
    latest_final, by = c("location_name", "location", "date", "source")
  ) |>
  mutate(status = "preliminary")

df <- latest_final |>
  mutate(status = "final") |>
  bind_rows(new_data) |>
  arrange(location_name, location, date)

write_csv(df, file.path(owid_dir, "truth_OWID-Incident Hospitalizations.csv"))
