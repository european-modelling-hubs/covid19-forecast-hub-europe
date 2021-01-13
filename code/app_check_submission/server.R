#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

# setwd("/home/johannes/Documents/COVID/covid19-forecast-hub-de/app_check_submission/app_check_submission")
library(shiny)
# library(reticulate)
source("plot_functions.R")

# unix command to change language
Sys.setlocale(category = "LC_TIME", locale = "en_US.UTF8")

# command that should work cross-platform
# Sys.setlocale(category = "LC_TIME","English")

local <- FALSE

# reticulate::virtualenv_create(envname = "myreticulate",
#                               python= '/usr/bin/python3')
# reticulate::virtualenv_install("myreticulate", packages = c( 'datetime','click'))
# reticulate::use_virtualenv("myreticulate", required = TRUE)
#
# # get Python functions:
# reticulate::source_python("covid19.py")
# reticulate::source_python("quantile_io.py")
# reticulate::source_python("cdc_io.py")



# get truth data:
dat_truth <- list()
if(local){
  dat_truth$JHU <- read.csv("../../../app_forecasts_de/data/truth_to_plot_jhu.csv",
                            colClasses = list("date" = "Date"), stringsAsFactors = FALSE)
  dat_truth$ECDC <- read.csv("../../../app_forecasts_de/data/truth_to_plot_ecdc.csv",
                             colClasses = list("date" = "Date"), stringsAsFactors = FALSE)
}else{
  dat_truth$JHU <- read.csv("https://raw.githubusercontent.com/KITmetricslab/covid19-forecast-hub-de/master/app_forecasts_de/data/truth_to_plot_jhu.csv",
                           colClasses = list("date" = "Date"), stringsAsFactors = FALSE)
  dat_truth$ECDC <- read.csv("https://raw.githubusercontent.com/KITmetricslab/covid19-forecast-hub-de/master/app_forecasts_de/data/truth_to_plot_ecdc.csv",
                            colClasses = list("date" = "Date"), stringsAsFactors = FALSE)
}


colnames(dat_truth$JHU) <- gsub("inc_", "inc ", colnames(dat_truth$JHU)) # for matching with targets
colnames(dat_truth$JHU) <- gsub("cum_", "cum ", colnames(dat_truth$JHU)) # for matching with targets
colnames(dat_truth$ECDC) <- gsub("inc_", "inc ", colnames(dat_truth$ECDC)) # for matching with targets
colnames(dat_truth$ECDC) <- gsub("cum_", "cum ", colnames(dat_truth$ECDC)) # for matching with targets

cols_legend <- c("#699DAF", "#D3D3D3")

# Define server logic required to draw a histogram
shinyServer(function(input, output) {


  dat <- reactiveValues()

  observe({
    inFile <- input$file1

    if (is.null(inFile)){
      dat$forecasts <- NULL
    }else{
      dat$forecasts <- read_week_ahead(inFile$datapath)
      locations <- unique(dat$forecasts$location)
      if(!is.null(dat$forecasts$location_name)) names(locations) <- unique(dat$forecasts$location_name)
      dat$locations <- locations
    }
  })

  # input element to select location:
  output$inp_select_location <- renderUI(
    selectInput("select_location", "Select location:", choices = dat$locations,
                selected = "GM")
  )

  output$plot <- renderPlot({
    if(!is.null(dat$forecasts)){

      target_type <- ifelse(grepl("case", dat$forecasts$target[1]), "case", "death")
      forecast_date <- dat$forecasts$forecast_date[1]


      truth_inc <- dat_truth[[input$truth_source]]
      colnames(truth_inc)[colnames(truth_inc) == paste("inc", target_type)] <- "value"
      truth_cum <- dat_truth[[input$truth_source]]
      colnames(truth_cum)[colnames(truth_cum) == paste("cum", target_type)] <- "value"

      par(mfrow = 1:2)

      if(any(grepl("inc", dat$forecasts$target))){
        plot_forecast(dat$forecasts, forecast_date = forecast_date,
                      location = input$select_location,
                      truth = truth_inc, target_type = paste("inc", target_type),
                      levels_coverage = c(0.5, 0.95),
                      start = as.Date(forecast_date) - 35,
                      end = as.Date(forecast_date) + 28)
        title(paste0("Incident ", target_type, " - ", input$select_location))
        legend("topleft", legend = c("50%PI", "95% PI"), col = cols_legend, pch = 15, bty = "n")

      }else{
        plot(NULL, xlim = 0:1, ylim = 0:1, xlab = "", ylab = "", axes = FALSE)
        text(0.5, 0.5, paste("No week-ahead incident", target_type, "forecasts found."))
      }

      if(any(grepl("cum", dat$forecasts$target))){
        plot_forecast(dat$forecasts, forecast_date = forecast_date,
                      location = input$select_location,
                      truth = truth_cum, target_type = paste("cum", target_type),
                      levels_coverage = c(0.5, 0.95),
                      start = as.Date(forecast_date) - 37,
                      end = as.Date(forecast_date) + 28,
                      start_at_zero = FALSE)
        title(paste0("Cumulative ", target_type, " - ", input$select_location))
        legend("topleft", legend = c("50%PI", "95% PI"), col = cols_legend, pch = 15, bty = "n")

      }else{
        plot(NULL, xlim = 0:1, ylim = 0:1, xlab = "", ylab = "", axes = FALSE)
        text(0.5, 0.5, paste("No week-ahead cumulative", target_type, "forecasts found."))
      }

    }else{
      plot(NULL, xlim = 0:1, ylim = 0:1, xlab = "", ylab = "", axes = FALSE)
      text(0.5, 0.5, "Please select file.")
    }
  })

  output$result_checks <- renderText("Currently in development.")

  observe({
    input$run_checks
    if(!is.null(dat$forecasts)){
      file_name <- input$file1$name
      inFile <- input$file1$datapath

      country <- ifelse(grepl("-Germany-", file_name), "Germany", "Poland")
      mode <- ifelse(grepl("-case", file_name), "case", "deaths")
      print(country)
      print(mode)
      output$result_checks <- renderText("Currently in development.")# renderText(validate_quantile_csv_file(inFile, mode, country))
    }
  })


})
