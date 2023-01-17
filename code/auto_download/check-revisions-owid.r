library("lubridate")
library("EuroForecastHub")
library("dplyr")
library("tidyr")
library("tibble")
library("vroom")

## select last 4 Sundays
latest_date <- lubridate::today()
wday(latest_date) <- EuroForecastHub::get_hub_config("forecast_week_day")

data_dir <- here::here("data-truth", "OWID", "snapshots")

owid_files <- list.files(data_dir, pattern = "20")

owid_revisions <- tibble::tibble(file = owid_files) |>
  dplyr::mutate(dl_date = as.Date(
    sub("^.*(20[0-9]{2}-[0-9]{2}-[0-9]{2}).*$", "\\1", file))
  ) |>
  dplyr::filter(
    wday(dl_date, label = TRUE, abbr = FALSE) ==
      EuroForecastHub::get_hub_config("forecast_week_day")
  ) |>
  dplyr::rowwise() |>
  dplyr::mutate(data = list(vroom::vroom(
    file = file.path(data_dir, file),
    col_types = c(
      location_name = "c",
      location = "c",
      date = "D",
      value = "i",
      source = "c"
    )
  ))) |>
  dplyr::ungroup() |>
  tidyr::unnest(data) |>
  dplyr::filter(dl_date > max(dl_date) - weeks(12)) |>
  dplyr::group_by(dl_date, location) |>
  dplyr::mutate(max_date = max(date)) |>
  dplyr::ungroup() |>
  dplyr::mutate(weeks_back = ceiling(as.numeric(max_date - date + 1) / 7)) |>
  dplyr::filter(weeks_back <= 5) |>
  dplyr::group_by(date, location_name, location) |>
  dplyr::mutate(revision = (max(value) - value) / value) |>
  dplyr::group_by(location, location_name, weeks_back) |>
  dplyr::summarise(mean_relative_revision = mean(revision), .groups = "drop")

vroom::vroom_write(
  owid_revisions,
  here::here("data-truth", "OWID", "revisions.csv"), delim = ","
)

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
  dplyr::select(location, location_name, cutoff = weeks_back)

vroom::vroom_write(
  recommended_cutoffs,
  here::here("data-truth", "OWID", "recommended-cutoffs.csv"), delim = ","
)
