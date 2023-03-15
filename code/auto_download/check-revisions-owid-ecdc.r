library("lubridate")
library("EuroForecastHub")
library("dplyr")
library("tidyr")
library("tibble")
library("vroom")

## select last 4 Sundays
latest_date <- lubridate::today()
wday(latest_date) <- EuroForecastHub::get_hub_config("forecast_week_day")

sources <- list(ECDC = c("Cases", "Deaths"), OWID = "Hospitalizations")

cutoff_days <- 28

for (source in names(sources)) {
  source_dir <- here::here("data-truth", source)
  snapshot_dir <- file.path(source_dir, "snapshots")
  final_dir <- file.path(source_dir, "final")

  snapshot_files <- list.files(snapshot_dir, pattern = "20")
  snapshot_dates <- as.Date(
    sub("^.*(20[0-9]{2}-[0-9]{2}-[0-9]{2}).*$", "\\1", snapshot_files)
  )

  file_pattern <- paste(tolower(sources[[source]]), collapse = "-")

  combine_files <- function(date) {
    final <- readr::read_csv(file.path(
      final_dir,
      paste0(
        "covid-", file_pattern, "-final_", date - days(cutoff_days), ".csv"
      )
      ), show_col_types = FALSE) |>
      dplyr::mutate(status = "final")
    snapshot <- readr::read_csv(file.path(
      snapshot_dir,
      paste0("covid-", file_pattern, "_", date, ".csv")
    ), show_col_types = FALSE) |>
      dplyr::mutate(snapshot_date = {{ date }},
                    status = "final") |>
      dplyr::filter(date > {{ date }} - days(cutoff_days))
    combined <- dplyr::bind_rows(final, snapshot) |>
      EuroForecastHub::convert_to_weekly()
    return(list(combined))
  }

  revisions <- tibble::tibble(dl_date = snapshot_dates) |>
    dplyr::rowwise() |>
    dplyr::mutate(data = combine_files(dl_date)) |>
    dplyr::ungroup() |>
    tidyr::unnest(data) |>
    tidyr::replace_na(list(value = 0)) |>
    dplyr::filter(dl_date > max(dl_date) - weeks(12)) |>
    dplyr::group_by(dl_date) |>
    dplyr::mutate(max_date = max(date)) |>
    dplyr::ungroup() |>
    dplyr::mutate(weeks_back = ceiling(as.numeric(max_date - date) / 7)) |>
    dplyr::select(-dl_date, -snapshot_date, -max_date) |>
    dplyr::group_by(dplyr::across(c(-value, -weeks_back))) |>
    dplyr::mutate(
      value = value + 1,
      revision = c(rev(abs(cumsum(diff(rev(value))))), 0) / value
    ) |>
    dplyr::group_by(dplyr::across(c(-value, -revision, -date))) |>
    dplyr::summarise(mean_relative_revision = mean(revision), .groups = "drop")

  recommended_cutoffs <- revisions |>
    dplyr::filter(mean_relative_revision > 0.05) |>
    dplyr::arrange(location, weeks_back) |>
    dplyr::group_by(
      across(c(-weeks_back, -mean_relative_revision))
    ) |>
    dplyr::mutate(cum_weeks_back = cumsum(weeks_back)) |>
    dplyr::rowwise() |>
    dplyr::mutate(sum_seq_weeks_back = sum(seq_len(weeks_back))) |>
    dplyr::ungroup() |>
    dplyr::filter(cum_weeks_back == sum_seq_weeks_back) |>
    dplyr::group_by(
      across(c(
        -weeks_back, -mean_relative_revision,
        -cum_weeks_back, -sum_seq_weeks_back
      ))
    ) |>
    dplyr::filter(weeks_back == max(weeks_back)) |>
    dplyr::ungroup() |>
    dplyr::mutate(cutoff_weeks = weeks_back + 1) |>
    dplyr::select(
      -mean_relative_revision, -cum_weeks_back, -sum_seq_weeks_back, -weeks_back
    )

  vroom::vroom_write(
    recommended_cutoffs,
    here::here("data-truth", source, "recommended-cutoffs.csv"),
    delim = ","
  )
}
