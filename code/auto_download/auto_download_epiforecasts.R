#' Get an Epiforecast Forecast
#'
#' @param base_path Character string, indicates the base download path.
#' @param model_folder Character string, name of model folder
#' @param model_name Character string, name of model
#' @param region Character string, name of region
#' @param forecast_date Date, defaults to day before today. Day of forecast
#' @param type Character string defaults to "". Target type with the default 
#' indicating deaths.
#'
#' @return A named list containing a single data frame. The data frame is the 
#' target forecast and the name corresponds to the submission file name. If no 
#' forecast is found an empty list is returned.
#' @export
#' @importFrom data.table fread
#' @importFrom purrr safely
#' @examples
#' get_epiforecast()
get_epiforecast <- function(base_path = "https://raw.githubusercontent.com/epiforecasts/covid-german-forecasts/master/submissions",
                         model_folder = "rt-forecasts", 
                         model_name = "EpiNow2", 
                         region = "Germany",
                         forecast_date = Sys.Date() - 1,
                         type = "") {
  if (!type %in% "") {
    model_name <- paste(model_name, type, sep = "-")
  }
  forecast_name <- paste0(forecast_date, "-", region, "-", "epiforecasts-", model_name, ".csv")
  forecast_path <- paste(base_path, model_folder, forecast_date, forecast_name, sep = "/")
  message("Downloading forecast from: ", 
          forecast_path)
  forecast <- list()
  
  safe_read <- safely(fread)
  read_in <-  safe_read(forecast_path)
  if (!is.null(read_in[[2]])) {
    print(read_in[[2]])
  }
  forecast[[forecast_name]] <- read_in[[1]]
  return(forecast)
}

#' Submit an Epiforecast Forecast
#'
#' @param forecast A named list containing a single data frame as 
#' returned by `get_epiforecast`
#' @param target_path A character string indicating the target path in which
#' to save the forecast submission.
#' @inheritParams get_epiforecast
#' @return NULL
#' @export
#' @importFrom data.table fwrite
#' @examples
#' forecast <- get_epiforecast()
#' submit_epiforecast(forecast)
submit_epiforecast <- function(forecast, 
                               model_name = "EpiNow2",
                               target_path = "data-processed") {
  target_folder <- paste0("epiforecasts-", model_name)
  file_path <- file.path(target_path, target_folder, names(forecast))
  message("Submitting forecast to: ", 
          file_path)
  fwrite(forecast[[1]], file_path, sep = ",")
  return(invisible(NULL))
}

#' Submit a Complete Epiforecast Forecast
#'
#' @param forecasts A structured list of forecasts to be submitted. Each 
#' entry should correspond to a single forecast and must contain the following:
#' - `folder`
#' - `name`
#' - `regions`
#' - `type`
#' 
#' @param forecast_date Date, defaults to yesterday. The date of the forecast
#' to be submitted.
#' @return NULL
#' @export
submit_epiforecasts <- function(forecasts, 
                                forecast_date = Sys.Date() - 1) {
  for (model in forecasts) {
    for (type in model$types) {
      for (region in model$regions) {
        forecast <- get_epiforecast(model_folder = model$folder,
                                    model_name = model$name, 
                                    region = region,
                                    type = type)
        
        if (length(forecast) > 0) {
          submit_epiforecast(forecast, 
                             model_name = model$name,
                             target_path = "data-processed")
        }else{
          warning("Forecast processing failed for ",
                  model$name, " in ", region, " with type ", 
                  ifelse(type %in% "", "death", "case"))
        }
      }
    }
  }
  return(invisible(NULL))
}


# Download and submit forecasts
require(data.table)
require(purrr)

forecasts <- list(
  "EpiNow2" = list(
    folder = "rt-forecasts",
    name = "EpiNow2",
    regions = c("Germany", "Poland"),
    types = c("", "case")
  ),
  "EpiNow2_secondary" = list(
    folder = "deaths-from-cases",
    name = "EpiNow2_secondary",
    regions = c("Germany", "Poland"),
    types = c("")
  )
)

submit_epiforecasts(forecasts)
