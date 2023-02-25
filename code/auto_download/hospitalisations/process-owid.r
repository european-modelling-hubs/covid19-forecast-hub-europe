library("readr")
library("lubridate")
library("purrr")
library("dplyr")

cat("Processing OWID data.\n")

cutoff_days <- 28

owid_dir <- here::here("data-truth", "OWID")
snapshot_dir <- file.path(owid_dir, "snapshots")
final_dir <- file.path(owid_dir, "final")

snapshot_files <- list.files(snapshot_dir)
final_files <- list.files(final_dir)

snapshot_dates <- as.Date(
  sub(
    "^covid-hospitalizations_(.*)\\.csv", "\\1",
    grep("^covid-hospitalizations_", snapshot_files, value = TRUE)
  )
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

if (length(final_dates) == 0) {
  stop("No new data to process.")
}

if (min(final_dates) == min(snapshot_dates) - days(28) + 1) {
  ## need to create first "final" dataset
  init <- readr::read_csv(
    file.path(
      snapshot_dir, grep(min(snapshot_dates), snapshot_files, value = TRUE)
    ), show_col_types = FALSE
  ) |>
    dplyr::mutate(snapshot_date = min(snapshot_dates)) |>
    dplyr::filter(date <= min(snapshot_dates) - days(cutoff_days))
  readr::write_csv(init, file.path(
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
snapshots <- purrr::map(snapshot_dates,
  \(x) read_csv(
    file.path(snapshot_dir, grep(x, snapshot_files, value = TRUE)),
    show_col_types = FALSE
  ) |>
    dplyr::mutate(snapshot_date = x)
) |>
  dplyr::bind_rows()

for (final_date_chr in as.character(final_dates)) {
  final_date <- as.Date(final_date_chr)
  init <- readr::read_csv(
    file.path(
      final_dir, paste0(
        "covid-hospitalizations-final_", final_date - days(1), ".csv"
      )
    ),
    show_col_types = FALSE
  )
  df <- init |>
    dplyr::bind_rows(snapshots) |>
    dplyr::filter(
      snapshot_date < final_date + days(cutoff_days),
      snapshot_date >= date + days(cutoff_days)
    ) |>
    dplyr::group_by(date) |>
    dplyr::filter(snapshot_date == min(snapshot_date)) |>
    dplyr::ungroup() |>
    dplyr::distinct()
  readr::write_csv(df, file.path(
    final_dir, paste0(
      "covid-hospitalizations-final_", final_date, ".csv"
    ))
  )
}

## create master data file
recommended_cutoffs <- readr::read_csv(
  file.path(owid_dir, "recommended-cutoffs.csv"),
  show_col_types = FALSE
)

latest_final <- read_csv(
  file.path(
    final_dir, paste0(
      "covid-hospitalizations-final_", max(final_dates), ".csv"
    )
  ),
  show_col_types = FALSE
)

latest_snapshot <- snapshots |>
  dplyr::filter(snapshot_date == max(snapshot_date))

new_data <- latest_snapshot |>
  dplyr::anti_join(
    latest_final, by = c("location_name", "location", "date", "source")
  ) |>
  dplyr::left_join(recommended_cutoffs, by = c("location_name", "location")) |>
  tidyr::replace_na(list(cutoff_weeks = 0)) |>
  dplyr::group_by(location_name, location, source) |>
  dplyr::mutate(status = dplyr::if_else(
    floor(as.integer(max(date) - date) / 7) < cutoff_weeks,
    "expecting revisions", "near final"
  )) |>
  dplyr::select(-cutoff_weeks)

status_factors <- c("final", "near final", "expecting revisions")

df <- latest_final |>
  dplyr::mutate(status = "final") |>
  dplyr::bind_rows(new_data) |>
  dplyr::arrange(location_name, location, date)

## remove countries with stale data (nothing for 4 weeks)
df <- df |>
  dplyr::group_by(location) |>
  dplyr::mutate(max_loc_snapshot = max(snapshot_date)) |>
  dplyr::ungroup() |>
  dplyr::filter(max_loc_snapshot > max(snapshot_date) - days(28)) |>
  dplyr::select(-max_loc_snapshot)

## identify and shift weekly data
df <- df |>
  dplyr::mutate(sat_date = EuroForecastHub::date_to_week_end(date)) |>
  dplyr::group_by(
    location_name, location, source, sat_date
  )  |>
  dplyr::mutate(n = dplyr::n())  |> ## count observations per Saturday date
  dplyr::group_by(
    location_name, location, source,
  )  |>
  ## check if data is weekly or daily
  dplyr::mutate(
    frequency = dplyr::if_else(all(n == 1), "weekly", "daily")
  ) |>
  dplyr::ungroup() |>
  ## if weekly and end date is previous Sunday, make end date the Saturday
  ## instead, i.e. interpret Mon-Sun as Sun-Sat
  dplyr::mutate(date = dplyr::if_else(
    frequency == "weekly" & date + 6 == sat_date, date + 6, date
  )) |>
  dplyr::filter(date == sat_date) |>
  dplyr::select(
    location_name, location, target_end_date = date, value, source,
    snapshot_date, status
  )

readr::write_csv(
  df,
  file.path(owid_dir, "truth_OWID-Incident Hospitalizations.csv")
)

readr::write_csv(
  df |> dplyr::filter(status != "expecting revisions"),
  here::here(
    "data-truth", "OWID", "truncated_OWID-Incident Hospitalizations.csv"
  )
)
