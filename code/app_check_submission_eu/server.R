# Written by Johannes Bracher, johannes.bacher@kit.edu
#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
# read in plotting function:
source("plot_functions.R")

# unix command to change language (for local testing)
Sys.setlocale(category = "LC_TIME", locale = "en_US.UTF8")

# command that should work cross-platform
# Sys.setlocale(category = "LC_TIME","English")

local <- FALSE # set to FALSE when deploying, TRUE when testing locally

# get truth data:
if(local){
  dat_truth <- read.csv("../../viz/truth_to_plot.csv",
                        colClasses = list("date" = "Date"), stringsAsFactors = FALSE)
}else{
  dat_truth <- read.csv("https://raw.githubusercontent.com/epiforecasts/covid19-forecast-hub-europe/main/viz/truth_to_plot.csv",
                        colClasses = list("date" = "Date"), stringsAsFactors = FALSE)
}
# adapt column names for matching with targets
colnames(dat_truth) <- gsub("inc_", "inc ", colnames(dat_truth))

# define colors
cols_legend <- c("#699DAF", "#D3D3D3")

# Define server logic
shinyServer(function(input, output, session) {
  
  dat <- reactiveValues()
  
  # Handle reading in of files:
  observe({
    inFile <- input$file # file upload
    query <- parseQueryString(session$clientData$url_search) # arguments provided in URL
    
    # initialization:
    dat$path <- ""
    dat$forecasts <- NULL
    
    # if path to csv provided in URL:
    if(!is.null(query$file) & is.null(inFile) & input$path == ""){
      dat$path <- query$file
      dat$name <- basename(query$file)
      dat$forecasts <- NULL
      try(dat$forecasts <- read_week_ahead(dat$path)) # wrapped in try() to avoid crash if no valid csv
    }
    
    # if file uploaded:
    if(!is.null(inFile) & input$path == ""){
      dat$path <- inFile$datapath
      dat$name <- basename(inFile$name)
      dat$forecasts <- NULL
      try(dat$forecasts <- read_week_ahead(dat$path)) # wrapped in try() to avoid crash if no valid csv
    }
    
    # if path to csv provided in input field:
    if(input$path != ""){
      dat$path <- input$path
      dat$name <- basename(input$path)
      dat$forecasts <- NULL
      try(dat$forecasts <- read_week_ahead(dat$path)) # wrapped in try() to avoid crash if no valid csv
    }
    
    # extact locations:
    if(!is.null(dat$forecasts)){
      locations <- unique(dat$forecasts$location)
      if(!is.null(dat$forecasts$location_name)) names(locations) <- unique(dat$forecasts$location_name)
      dat$locations <- locations
    }
    
    print(dat$path)
    
  })
  
  # input element to select location (loads the available locations):
  # (currently not used)
  # output$inp_select_location <- renderUI(
  #   selectInput("select_location", "Select location:", choices = dat$locations,
  #               selected = "GM")
  # )
  
  # output element to display file name:
  output$file_name <- renderText(dat$name)
  
  # plot output:
  output$plot <- renderPlot({
    if(!is.null(dat$forecasts)){
      
      # get forecast date:
      forecast_date <- dat$forecasts$forecast_date[1]
      
      par(mfrow = c(length(dat$locations), 2), cex = 1)
      
      for(loc in dat$locations){
        # plot for cases:
        if(any(grepl("case", dat$forecasts$target))){ # only if case forecasts available
          plot_forecast(dat$forecasts, forecast_date = forecast_date,
                        location = loc,
                        truth = dat_truth, target_type = "inc case",
                        levels_coverage = c(0.5, 0.95),
                        start = as.Date(forecast_date) - 35,
                        end = as.Date(forecast_date) + 28)
          title(paste0("Incident cases - ", loc))
          legend("topleft", legend = c("50%PI", "95% PI"), col = cols_legend, pch = 15, bty = "n")
          
        }else{ # otherwise empty plot
          plot(NULL, xlim = 0:1, ylim = 0:1, xlab = "", ylab = "", axes = FALSE)
          text(0.5, 0.5, paste("No case forecasts found."))
        }
        
        # plot for deaths:
        if(any(grepl("death", dat$forecasts$target))){  # only if case forecasts available
          plot_forecast(dat$forecasts, forecast_date = forecast_date,
                        location = loc,
                        truth = dat_truth, target_type = "inc death",
                        levels_coverage = c(0.5, 0.95),
                        start = as.Date(forecast_date) - 37,
                        end = as.Date(forecast_date) + 28)
          title(paste0("Incident deaths - ", loc))
          legend("topleft", legend = c("50%PI", "95% PI"), col = cols_legend, pch = 15, bty = "n")
          
        }else{  # otherwise empty plot
          plot(NULL, xlim = 0:1, ylim = 0:1, xlab = "", ylab = "", axes = FALSE)
          text(0.5, 0.5, paste("No  death forecasts found."))
        }
      }
      
    }else{
      # if no file is uploaded: empty plot with "Please select a valid csv file"
      plot(NULL, xlim = 0:1, ylim = 0:1, xlab = "", ylab = "", axes = FALSE)
      text(0.5, 0.5, "Please select a valid csv file.")
    }
  })
  
  output$plot_ui <- renderUI({
    plotOutput("plot", height = ifelse(is.null(dat$locations), 500, length(dat$locations)*250))
  })
  
})
