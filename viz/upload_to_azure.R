library(AzureStor)

to_upload <- c(
  "viz/settings_model_selection.json",
  "viz/metadata.json",
  "viz/forecasts_to_plot.json",
  "viz/truth_to_plot.csv",
  "data-locations/locations_eu.csv"
)

bl_endp_key <- storage_endpoint(
  Sys.getenv("AZURE_STORAGE_ENDPOINT"),
  Sys.getenv("AZURE_STORAGE_KEY")
)
cont <- storage_container(bl_endp_key, "data")

storage_multiupload(cont, src = to_upload)
