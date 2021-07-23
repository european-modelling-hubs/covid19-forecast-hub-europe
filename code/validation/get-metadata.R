# Read metadata as tibble, with args for common use cases

library(here)
library(yaml)
library(purrr)
library(dplyr)

get_metadata <- function(keys,
                         exclude_designated_other = TRUE, 
                         exclude_hub = FALSE) {
  
  metadata_path <- dir(here("data-processed"), recursive = TRUE, full.names = TRUE)
  metadata_path <- metadata_path[grepl(".txt", metadata_path)]
  
  all_metadata <- map_dfr(metadata_path, read_yaml)
  
  if (exclude_designated_other) {
    all_metadata <- all_metadata %>%
      filter(team_model_designation != "other")
  }
  
  if (exclude_hub) {
    all_metadata <- all_metadata %>%
      filter(!grepl("EuroCOVIDhub", .$model_abbr))
  }
  
  if (missing(keys)) {
    keys <- names(all_metadata)
  }
  
  all_metadata <- all_metadata %>%
    select(model_abbr, all_of(keys))
  
  return(all_metadata)
  
}
