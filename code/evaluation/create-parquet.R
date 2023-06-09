# Create a parquet file from all available raw forecasts
library(arrow)
library(here)

raw_forecasts <- arrow::open_dataset(
  here::here("data-processed"),
  format = "csv",
  partitioning = schema(model = string()),
  hive_style = FALSE,
  col_types = schema(
    forecast_date = date32(),
    target = string(),
    target_end_date = date32(),
    location = string(),
    type = string(),
    quantile = float32(),
    value = float32()
  )
)

arrow::write_parquet(raw_forecasts, "covid19-forecast-hub-europe.parquet")

# data cleaning ---------------------------------------

# df <- arrow::read_parquet("covid19-forecast-hub-europe.parquet")
# df <- df |>
#   # set forecast date to corresponding submission date
#   dplyr::mutate(
#     forecast_date = ceiling_date(forecast_date, "week",
#                                  week_start = 3)
#   )
