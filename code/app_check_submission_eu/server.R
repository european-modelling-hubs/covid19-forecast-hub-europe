#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
source("plot_functions.R")

# unix command to change language
Sys.setlocale(category = "LC_TIME", locale = "en_US.UTF8")

# command that should work cross-platform
# Sys.setlocale(category = "LC_TIME","English")

local <- FALSE # set to FALSE when deploying



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

# Define server logic required to draw a histogram
shinyServer(function(input, output) {


  dat <- reactiveValues()

  # Handling reading in of files:
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

  # input element to select location (loads the available locations):
  output$inp_select_location <- renderUI(
    selectInput("select_location", "Select location:", choices = dat$locations,
                selected = "GM")
  )

  # plot output:
  output$plot <- renderPlot({
    if(!is.null(dat$forecasts)){

      # et forecast date:
      forecast_date <- dat$forecasts$forecast_date[1]

      par(mfrow = 1:2)

      # plot for cases:
      if(any(grepl("case", dat$forecasts$target))){ # only if case forecasts available
        plot_forecast(dat$forecasts, forecast_date = forecast_date,
                      location = input$select_location,
                      truth = dat_truth, target_type = "inc case",
                      levels_coverage = c(0.5, 0.95),
                      start = as.Date(forecast_date) - 35,
                      end = as.Date(forecast_date) + 28)
        title(paste0("Incident cases - ", input$select_location))
        legend("topleft", legend = c("50%PI", "95% PI"), col = cols_legend, pch = 15, bty = "n")

      }else{ # otherwise empty plot
        plot(NULL, xlim = 0:1, ylim = 0:1, xlab = "", ylab = "", axes = FALSE)
        text(0.5, 0.5, paste("No case forecasts found."))
      }

      # plot for deaths:
      if(any(grepl("death", dat$forecasts$target))){  # only if case forecasts available
        plot_forecast(dat$forecasts, forecast_date = forecast_date,
                      location = input$select_location,
                      truth = dat_truth, target_type = "inc death",
                      levels_coverage = c(0.5, 0.95),
                      start = as.Date(forecast_date) - 37,
                      end = as.Date(forecast_date) + 28,
                      start_at_zero = FALSE)
        title(paste0("Incident deaths - ", input$select_location))
        legend("topleft", legend = c("50%PI", "95% PI"), col = cols_legend, pch = 15, bty = "n")

      }else{  # otherwise empty plot
        plot(NULL, xlim = 0:1, ylim = 0:1, xlab = "", ylab = "", axes = FALSE)
        text(0.5, 0.5, paste("No  death forecasts found."))
      }

    }else{
      # if no file is uploaded: empty plot with "Please select file"
      plot(NULL, xlim = 0:1, ylim = 0:1, xlab = "", ylab = "", axes = FALSE)
      text(0.5, 0.5, "Please select file.")
    }
  })

})
