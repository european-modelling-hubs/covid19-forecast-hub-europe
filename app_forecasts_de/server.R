library(shiny)
library(pals)

local <- FALSE

# read in plotting functions etc
if(local){
  source(("../code/R/plot_functions.R"))
  source("../code/R/auxiliary_functions.R")

}else{
  source("https://raw.githubusercontent.com/KITmetricslab/covid19-forecast-hub-de/master/code/R/plot_functions.R")
  source("https://raw.githubusercontent.com/KITmetricslab/covid19-forecast-hub-de/master/code/R/auxiliary_functions.R")
}

# Choose the right option, depending on your system:
# ----------------------------------------------------------------------------

# unix command
Sys.setlocale(category = "LC_TIME", locale = "en_US.UTF8")

# command that should work cross-platform
# Sys.setlocale(category = "LC_TIME","English")

# ----------------------------------------------------------------------------

# read in data set compiled specificaly for Shiny app:
if(local){
  forecasts_to_plot <- read.csv("data/forecasts_to_plot.csv",
                                stringsAsFactors = FALSE,
                                colClasses = c("forecast_date" = "Date",
                                               "timezero" = "Date",
                                               "target_end_date" = "Date",
                                               "first_commit_date" = "Date"))
}else{
  forecasts_to_plot <- read.csv("https://raw.githubusercontent.com/KITmetricslab/covid19-forecast-hub-de/master/app_forecasts_de/data/forecasts_to_plot.csv",
                                stringsAsFactors = FALSE,
                                colClasses = c("forecast_date" = "Date",
                                               "timezero" = "Date",
                                               "target_end_date" = "Date"))
}

# exclude some models because used data is neither ECDC nor JHU:
models_to_exclude <- c("Imperial-ensemble1")
forecasts_to_plot <- subset(forecasts_to_plot, !(model %in% models_to_exclude) )

# get timezeros, i.e. Mondays on which forecasts were made:
timezeros <- as.character(sort(unique(forecasts_to_plot$timezero), decreasing = TRUE))

# read in location codes (FIPS):
location_codes <- read.csv("https://raw.githubusercontent.com/KITmetricslab/covid19-forecast-hub-de/master/template/state_codes_germany.csv",
                           stringsAsFactors = FALSE)
locations <- location_codes$state_code
names(locations) <- location_codes$state_name
# re-order:
locations <- locations[locations != "GM"]
locations <- locations[order(names(locations))]
names(locations) <- paste0(".. ", names(locations))
locations <- c("Germany" = "GM", "Poland" = "PL", locations)

# get names of models which appear in the data:
models <- sort(as.character(unique(forecasts_to_plot$model)))

# set default for selected models at start:
default_models <- models # if("KITCOVIDhub-median_ensemble" %in% models) "KITCOVIDhub-median_ensemble" else models

# assign colours to models (currently restricted to eight):
cols_models <- glasbey(length(models) + 1)[-1]
names(cols_models) <- models

# get truth data:
dat_truth <- list()
dat_truth$JHU <- read.csv("https://raw.githubusercontent.com/KITmetricslab/covid19-forecast-hub-de/master/app_forecasts_de/data/truth_to_plot_jhu.csv",
                          colClasses = list("date" = "Date"))
colnames(dat_truth$JHU) <- gsub("inc_", "inc ", colnames(dat_truth$JHU)) # for matching with targets
colnames(dat_truth$JHU) <- gsub("cum_", "cum ", colnames(dat_truth$JHU)) # for matching with targets


dat_truth$ECDC <- read.csv("https://raw.githubusercontent.com/KITmetricslab/covid19-forecast-hub-de/master/app_forecasts_de/data/truth_to_plot_ecdc.csv",
                           colClasses = list("date" = "Date"))
colnames(dat_truth$ECDC) <- gsub("inc_", "inc ", colnames(dat_truth$ECDC)) # for matching with targets
colnames(dat_truth$ECDC) <- gsub("cum_", "cum ", colnames(dat_truth$ECDC)) # for matching with targets


# define point shapes for different truth data sources:
truths <- names(dat_truth)
pch_full <- c(17, 16)
pch_empty <- c(2, 1)
names(pch_full) <- names(pch_empty) <- truths

# get data on which model uses which truth data:
truth_data_used0 <- read.csv("https://raw.githubusercontent.com/KITmetricslab/covid19-forecast-hub-de/master/app_forecasts_de/data/truth_data_use.csv",
                             stringsAsFactors = FALSE)
truth_data_used <- truth_data_used0$truth_data
names(truth_data_used) <- truth_data_used0$model

# get evaluation data:
dat_evaluation <- list()
if(local){
  dat_evaluation$ECDC <- read.csv("../evaluation/evaluation-ECDC.csv",
                                  colClasses = list("target_end_date" = "Date", "forecast_date" = "Date", "timezero" = "Date"),
                                  stringsAsFactors = FALSE)
  dat_evaluation$JHU <- read.csv("../evaluation/evaluation-JHU.csv",
                                 colClasses = list("target_end_date" = "Date", "forecast_date" = "Date", "timezero" = "Date"),
                                 stringsAsFactors = FALSE)
}else{
  dat_evaluation$ECDC <- read.csv("https://raw.githubusercontent.com/KITmetricslab/covid19-forecast-hub-de/master/evaluation/evaluation-ECDC.csv",
                                  colClasses = list("target_end_date" = "Date", "forecast_date" = "Date", "timezero" = "Date"),
                                  stringsAsFactors = FALSE)
  dat_evaluation$JHU <- read.csv("https://raw.githubusercontent.com/KITmetricslab/covid19-forecast-hub-de/master/evaluation/evaluation-JHU.csv",
                                 colClasses = list("target_end_date" = "Date", "forecast_date" = "Date", "timezero" = "Date"),
                                 stringsAsFactors = FALSE)
}


# Define server logic:
shinyServer(function(input, output, session) {

  # reactive values to store various mouse coordinates (prefer this to using coordinates
  # directly as NULL values can be avoided):
  coords <- reactiveValues()
  # single click:
  observe({
    input$coord_click
    if(!is.null(input$coord_click)){
      coords$click <- input$coord_click
    }
  })
  # brush, i.e. drawing rectangle:
  observe({
    if(!is.null(input$coord_brush)){
      coords$brush <- list(xlim = as.Date(c(input$coord_brush$xmin, input$coord_brush$xmax), origin = "1970-01-01"),
                           ylim = c(input$coord_brush$ymin, input$coord_brush$ymax))
    }
    if(!is.null(input$coord_dblclick)){
      coords$brush <- list(xlim = NULL, ylim = NULL)
    }
  })
  # reset if target changed:
  observe({
    input$select_target
    coords$brush <- list(xlim = NULL, ylim = NULL)
  })
  # hover:
  observe({
    input$coord_hover
    if(!is.null(input$coord_hover)){
      coords$hover <- input$coord_hover
    }
  })

  # reactive values to store options selected through mouse coordinates:
  selected <- reactiveValues()
  # target_end_date selected by hovering, along with associated truth and point forecast values
  observe({
    if(!is.null(coords$hover$x)){
      # click_date <- as.Date(round(coords$click$x), origin = "1970-01-01")
      hover_date <- as.Date(round(coords$hover$x), origin = "1970-01-01")
      if(weekdays(hover_date) == "Saturday"){
        # get dates
        selected$target_end_date <- hover_date
        # get point estimates:
        subs <- subset(forecasts_to_plot,
                       (if(input$select_stratification == "forecast_date"){
                         timezero == as.Date(input$select_date)
                       } else TRUE) &
                         (if(input$select_stratification == "horizon" & !is.null(input$select_horizon)){
                           grepl(input$select_horizon, target)
                         } else TRUE) &
                         grepl(input$select_target, target) &
                         location == input$select_location &
                         target_end_date == hover_date &
                         type %in% c("point", if(input$select_stratification == "forecast_date") "observed"))
        point_pred <- data.frame(model = models)
        point_pred <- merge(point_pred, subs, by = "model", all.x = TRUE)
        # need to shift to fit respective truth data:
        shift <- rep(0, nrow(point_pred))
        if(input$select_truths == "ECDC"){
          shift <- point_pred$shift_ECDC
        }
        if(input$select_truths == "JHU"){
          shift <- point_pred$shift_JHU
        }
        selected$point_pred <- round(point_pred$value + shift)

        # get truths:
        selected$truths <- c(subset(dat_truth$JHU, date == as.Date(selected$target_end_date) &
                                      location == input$select_location)[, input$select_target],
                             subset(dat_truth$ECDC, date == as.Date(selected$target_end_date) &
                                      location == input$select_location)[, input$select_target])
      }else{
        selected$target_end_date <- NULL
        selected$point_pred <- NULL
        selected$truths <- NULL
      }
    }
  })

  # input element for selection of models to show in plot:
  output$inp_select_model <- renderUI(
    checkboxGroupInput("select_models", "Select models to display:",
                       choiceNames = models,
                       choiceValues = models,
                       selected = default_models,
                       inline = TRUE)
  )

  # uncheck all:
  observe({
    input$hide_all
    updateCheckboxGroupInput(session, "select_models",
                             choiceNames = models,
                             choiceValues = models,
                             selected = NULL, inline = TRUE)
  })

  # check all:
  observe({
    input$show_all
    updateCheckboxGroupInput(session, "select_models",
                             choiceNames = models,
                             choiceValues = models,
                             selected = models, inline = TRUE)
  })

  # set to default (necessary upon launch):
  observe({
    updateCheckboxGroupInput(session, "select_models",
                             choiceNames = models,
                             choiceValues = models,
                             selected = default_models, inline = TRUE)
  })

  # input element to select forecast date:
  output$inp_select_date <- renderUI(
    if(input$select_stratification == "forecast_date" || is.null(input$select_stratification)){
      selectInput("select_date", "Select forecast date:", choices = timezeros)
    }else{
      selectInput("select_horizon", "Select forecast horizon:",
                  choices = c("1 wk ahead", "2 wk ahead", "3 wk ahead", "4 wk ahead"))
    }
  )

  # input element to select location:
  output$inp_select_location <- renderUI(
    selectInput("select_location", "Select location:", choices = locations, selected = "GM")
  )

  # plot (all wrapped up in function plot_forecasts)
  output$plot_forecasts <- renderPlot({
    par(mar = c(4.5, 5, 4, 2), las = 1)

    horizon <- if(input$select_stratification == "horizon") input$select_horizon else NULL
    timezero <- if(is.null(input$select_stratification)){
      as.Date("2020-08-24")
    }else{
      if(!is.null(input$select_date)){
        if(input$select_stratification == "forecast_date") as.Date(input$select_date) else NULL
      }else{
        as.Date("2020-08-24")
      }
    }

    # determine ylim:
    yl <-
      if(is.null(coords$brush$ylim)){
        if(is.null(input$select_location) | is.null(input$select_stratification)){
          c(0, 12000)
        }else{
          c(0, 1.2*max(c(dat_truth$ECDC[dat_truth$ECDC$location == input$select_location, input$select_target],
                         forecasts_to_plot[forecasts_to_plot$forecast_date == as.Date(input$select_date) &
                                             grepl(input$select_target, forecasts_to_plot$target) &
                                             forecasts_to_plot$location == input$select_location, "value"])))
        }
      }else{
        coords$brush$ylim
      }

    plot_forecasts(forecasts_to_plot = forecasts_to_plot,
                   truth = dat_truth,
                   target = input$select_target,
                   timezero = timezero,
                   horizon = horizon,
                   models = input$select_models,
                   location = input$select_location,
                   truth_data_used = truth_data_used,
                   selected_truth = input$select_truths,
                   start = if(is.null(coords$brush$xlim)){
                     as.Date("2020-04-01")
                   }else{
                     coords$brush$xlim[1]
                   },
                   end = if(is.null(coords$brush$xlim)){
                     Sys.Date() + 28
                   }else{
                     coords$brush$xlim[2]
                   },
                   ylim = yl,
                   col = cols_models[input$select_models], alpha.col = 0.5,
                   pch_truths = pch_full,
                   pch_forecasts = pch_empty,
                   legend = FALSE,
                   add_intervals.95 = input$show_pi.95,
                   add_intervals.50 = input$show_pi.50,
                   add_model_past = TRUE, #input$show_model_past,
                   highlight_target_end_date = selected$target_end_date,
                   tolerance_retrospective = 1000)
    abline(h = 0)

    # add legends manually:
    legend("topleft", col = cols_models, legend = paste0(models, ": ", selected$point_pred), lty = 0, bty = "n",
           pch = ifelse(models %in% input$select_models,
                        pch_full[truth_data_used[models]], pch_empty[truth_data_used[models]]),
           pt.cex = 1.3, ncol = 3)
    # print(selected)
    legend("left", col = "black", legend = paste0(c("Truth data", "JHU", "ECDC/RKI"), ": ",
                                                  c("", selected$truths)), lty = 0, bty = "n",
           pch = c(NA, ifelse(truths %in% input$select_truths, pch_full, pch_empty)),
           pt.cex = 1.3)

    # add title manually:
    title(names(locations)[which(locations == input$select_location)])
  })

  # plot (all wrapped up in function plot_forecasts)
  output$plot_evaluation <- renderPlot({
    par(mar = c(4.5, 5, 4, 2), las = 1)

    horizon <- if(input$select_stratification == "horizon") input$select_horizon else NULL
    timezero <- if(is.null(input$select_stratification)){
      as.Date("2020-08-24")
    }else{
      if(!is.null(input$select_date)){
        if(input$select_stratification == "forecast_date") as.Date(input$select_date) else NULL
      }else{
        as.Date("2020-08-24")
      }
    }

    # plot scores:
    plot_scores(scores = dat_evaluation,
                target = input$select_target,
                timezero = timezero,
                horizon = horizon,
                selected_truth = input$select_truths,
                models = input$select_models,
                location = input$select_location,
                start = if(is.null(coords$brush$xlim)){
                  as.Date("2020-04-01")
                }else{
                  coords$brush$xlim[1]
                },
                end = if(is.null(coords$brush$xlim)){
                  Sys.Date() + 28
                }else{
                  coords$brush$xlim[2]
                },
                col = cols_models[input$select_models], alpha.col = 0.5)
    abline(h = 0)

    # add title manually:
    title(paste("Forecast evaluation using weighted interval score and absolute error",
                if(input$select_truths %in% c("ECDC", "JHU")){
                  paste(
                    "based on",
                    input$select_truths, "data",
                    "(all forecasts have been shifted so that last available observations are aligned)"
                  )
                }))
    pch_full_ae <-
      legend("topleft", col = cols_models, legend = paste0(models, ": ", selected$point_pred),
             pt.lwd = 2, bty = "n",
             pch = 23, pt.bg = ifelse(models %in% input$select_models, cols_models, "white"),
             pt.cex = 1.3, ncol = 3)
  })

})
