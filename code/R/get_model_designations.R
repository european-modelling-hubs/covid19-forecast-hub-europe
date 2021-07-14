library(yaml)

##' Get the model designation of each model in a forecast hub
##'
##' Reads the metadata files to extract model_designation field
##' @return a data frame of each "model", and the correpsonding "designation"
##' @importFrom yaml read_yaml
##' @param hub_repo_path path to the local clone of the forecast repository
get_model_designations <- function(hub_repo_path) {
  models <-
    list.files(file.path(hub_repo_path, "data-processed"), include.dirs = TRUE)
  metadata_files <-
    file.path(hub_repo_path, "data-processed", models,
              paste0("metadata-", models, ".txt"))
  metadata <- lapply(metadata_files, yaml::read_yaml)
  model_designations <-
    vapply(metadata, `[[`, "team_model_designation", FUN.VALUE = "")
  return(data.frame(model = models, designation = model_designations))
}
