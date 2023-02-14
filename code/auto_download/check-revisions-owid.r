library("lubridate")
library("EuroForecastHub")
library("dplyr")
library("tidyr")
library("tibble")
library("vroom")

## select last 4 Sundays
latest_date <- lubridate::today()
wday(latest_date) <- EuroForecastHub::get_hub_config("forecast_week_day")

owid_dir <- here::here("data-truth", "OWID")
snapshot_dir <- file.path(owid_dir, "snapshots")
final_dir <- file.path(owid_dir, "final")

snapshot_files <- list.files(snapshot_dir, pattern = "20")
snapshot_dates <- as.Date(
  sub("^.*(20[0-9]{2}-[0-9]{2}-[0-9]{2}).*$", "\\1", snapshot_files)
)

combine_files <- function(date) {
  final <- readr::read_csv(file.path(
    final_dir, paste0("covid-hospitalizations-final_", date - days(27), ".csv")
  ), show_col_types = FALSE)
  snapshot <- readr::read_csv(file.path(
    snapshot_dir, paste0("covid-hospitalizations_", date, ".csv")
  ), show_col_types = FALSE) |>
    filter(date > {{ date }} - days(28)) |>
    mutate(snapshot_date = {{ date }})
  return(list(dplyr::bind_rows(final, snapshot)))
}

owid_revisions <- tibble::tibble(dl_date = snapshot_dates) |>
  dplyr::rowwise() |>
  dplyr::mutate(data = combine_files(dl_date)) |>
  dplyr::ungroup() |>
  tidyr::unnest(data) |>
  dplyr::filter(dl_date > max(dl_date) - weeks(12)) |>
  dplyr::group_by(dl_date, location) |>
  dplyr::mutate(max_date = max(date)) |>
  dplyr::ungroup() |>
  dplyr::mutate(weeks_back = ceiling(as.numeric(max_date - date + 1) / 7)) |>
  dplyr::group_by(date, location_name, location) |>
  dplyr::mutate(revision = (max(value) - value) / value) |>
  dplyr::group_by(location, location_name, weeks_back) |>
  dplyr::summarise(mean_relative_revision = mean(revision), .groups = "drop")

recommended_cutoffs <- owid_revisions |>
  dplyr::filter(mean_relative_revision > 0.05) |>
  dplyr::arrange(location, weeks_back) |>
  dplyr::group_by(location) |>
  dplyr::mutate(cum_weeks_back = cumsum(weeks_back)) |>
  dplyr::rowwise() |>
  dplyr::mutate(sum_seq_weeks_back = sum(seq_len(weeks_back))) |>
  dplyr::ungroup() |>
  dplyr::filter(cum_weeks_back == sum_seq_weeks_back) |>
  dplyr::group_by(location, location_name) |>
  dplyr::filter(weeks_back == max(weeks_back)) |>
  dplyr::ungroup() |>
  dplyr::select(location, location_name, cutoff_weeks = weeks_back)

vroom::vroom_write(
  recommended_cutoffs,
  here::here("data-truth", "OWID", "recommended-cutoffs.csv"), delim = ","
)

cutoff_truth_data <- vroom::vroom(
  here::here("data-truth", "OWID", "truth_OWID-Incident Hospitalizations.csv"),
  show_col_types = FALSE
) |>
  dplyr::left_join(recommended_cutoffs, by = c("location", "location_name")) |>
  tidyr::replace_na(list(cutoff_weeks = 0)) |>
  filter(floor(as.integer(snapshot_date - date) / 7) >= cutoff_weeks)

vroom::vroom_write(
  cutoff_truth_data,
  here::here("data-truth", "OWID", "truncated_OWID-Incident Hospitalizations.csv"),
  delim = ","
)
