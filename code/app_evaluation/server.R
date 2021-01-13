#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(colorspace)
library(DT)
library(pals)

cols_models <- glasbey(5)

# options(scipen=999)

timezeros <- 1:10

local <- TRUE


dat_evaluation <- list()
if(local){
  source("../R/plot_functions.R")
  dat_evaluation$ECDC <- read.csv("../../evaluation/evaluation-ECDC.csv",
                                  colClasses = list("target_end_date" = "Date", "forecast_date" = "Date", "timezero" = "Date"),
                                  stringsAsFactors = FALSE)
  dat_evaluation$JHU <- read.csv("../../evaluation/evaluation-JHU.csv",
                                 colClasses = list("target_end_date" = "Date", "forecast_date" = "Date", "timezero" = "Date"),
                                 stringsAsFactors = FALSE)
}else{
  source("https://raw.githubusercontent.com/KITmetricslab/covid19-forecast-hub-de/master/code/R/plot_functions.R")
  dat_evaluation$ECDC <- read.csv("https://raw.githubusercontent.com/KITmetricslab/covid19-forecast-hub-de/master/evaluation/evaluation-ECDC.csv",
                                  colClasses = list("target_end_date" = "Date", "forecast_date" = "Date", "timezero" = "Date"),
                                  stringsAsFactors = FALSE)
  dat_evaluation$JHU <- read.csv("https://raw.githubusercontent.com/KITmetricslab/covid19-forecast-hub-de/master/evaluation/evaluation-JHU.csv",
                                 colClasses = list("target_end_date" = "Date", "forecast_date" = "Date", "timezero" = "Date"),
                                 stringsAsFactors = FALSE)
}

lighten_colour <- function(col, power = 0.5){
  x <- col2rgb(col)/255
  rgb(x[1]^power, x[2]^power, x[3]^power)
}

timezeros <- sort(unique(dat_evaluation$ECDC$timezero), decreasing = TRUE)
models <- sort(unique(dat_evaluation$ECDC$model))
to_exclude <- c("JGU_UHH-SMM", "IHME-CurveFit", "Imperial-ensemble1", "Imperial-ensemble2", "YYG-ParamSearch")
models <- models[!models %in% to_exclude]
locations <- c("GM", "PL")

# function for time series plot based on evaluation data:
plot_from_eval <- function(dat_eval, model, location,
                           target_type, inc_or_cum, horizon = NULL, forecast_date = NULL,
                           ylim = NULL, start = NULL, end = NULL,
                           col = "steelblue", alpha.col = 0.3, add = FALSE,
                           shifts = c(0, 1, -1, -0.5, -0.5)){

  # restrict to relevant rows:
  dat_eval <- dat_eval[  grepl(target_type, dat_eval$target) &
                           grepl(inc_or_cum, dat_eval$target) &
                           dat_eval$location == location &
                           !grepl("0", dat_eval$target) &
                           !grepl("-1", dat_eval$target), ]

  # extract data to plot truth:
  all_dates <- dat_eval$target_end_date[!duplicated(dat_eval$target_end_date)]
  all_truths <- dat_eval$truth[!duplicated(dat_eval$target_end_date)]

  # restrict to model and forecast date or horizon:
  dat_eval <- dat_eval[dat_eval$model %in% model, ]
  if(!is.null(forecast_date)) dat_eval <- dat_eval[dat_eval$timezero == forecast_date, ]
  if(!is.null(horizon)){
    dat_eval <- dat_eval[grepl(horizon, dat_eval$target), ]
  }

  # catch in case of only missings:
  if(nrow(dat_eval) == 0 & !add){
    plot(NULL, xlim = 0:1, ylim = 0:1, axes = FALSE, xlab = "", ylab = "")
    text(0.5, 0.5, labels = "No forecasts available.")
    return(invisible(list(ylim = NULL)))
  }else{

    # choose start, end and ylim if not specified:
    if(is.null(start)) start <- ifelse(is.null(horizon), min(dat_eval$forecast_date) - 35, min(dat_eval$forecast_date) - 21)
    if(is.null(end)) end <- ifelse(is.null(horizon), max(dat_eval$forecast_date) + 63, max(dat_eval$forecast_date) + 35)
    if(is.null(ylim)) ylim <- c(ifelse(inc_or_cum == "inc",
                                       0,
                                       0.75*min(c(dat_eval$value.0.025,
                                                  dat_eval$value.point,
                                                  dat_eval$truth), na.rm = TRUE)),
                                max(c(dat_eval$value.0.975,
                                      dat_eval$value.point,
                                      dat_eval$truth), na.rm = TRUE))

    # initialize plot if necessary:
    if(!add){
      plot(dat_eval$target_end_date, dat_eval$truth, ylim = ylim, xlim = c(start, end),
           xlab = "time", ylab = "", col  ="white")
      # horizontal ablines:
      abline(h = axTicks(2), col = "grey")
    }
    # create transparent color:
    col_transp <- modify_alpha(col, alpha.col)

    for(i in seq_along(model)){
      dat_eval_m <- dat_eval[dat_eval$model == model[i], ]
      # add forecasts:
      plot_weekly_bands(dates = dat_eval_m$target_end_date, lower = dat_eval_m$value.0.025,
                        upper = dat_eval_m$value.0.975, separate_all = is.null(forecast_date),
                        col = lighten(col[i], 0.5), border = NA, width = 0.5, shift = shifts[i])
      plot_weekly_bands(dates = dat_eval_m$target_end_date, lower = dat_eval_m$value.0.25,
                        upper = dat_eval_m$value.0.75, separate_all = is.null(forecast_date),
                        col = lighten(col[i], 0.3), border = NA, width = 0.5, shift = shifts[i])
      points(dat_eval_m$target_end_date + shifts[i], dat_eval_m$value.point, pch = 21, col = col[i], bg = "white")
    }

    points(all_dates, all_truths, pch = 15, cex = 0.7)
    lines(all_dates[order(all_dates)], all_truths[order(all_dates)])


    # mark forecast date if necessary:
    if(!is.null(forecast_date)) abline(v = forecast_date, lty = 2)

    # if(!add){
    #   title(paste(horizon, inc_or_cum, target_type, "-", location, "-", model,
    #               ifelse(!is.null(forecast_date), "- Forecast from", ""), forecast_date))
    # }

    # return ylim so it can be used in second plot:
    return(invisible(list(ylim = ylim)))
  }
}

shifts <- c(-0.6, 0, 0.6, 1.2, 1.8)

# Define server logic required to draw a histogram
shinyServer(function(input, output) {

  # input element to select first model to show in plot:
  output$inp_select_model1 <- renderUI(
    selectInput("select_model1", "Select model 1:",
                choices = c("none", models),
                selected = c("KITCOVIDhub-mean_ensemble"))
  )

  # input element to select second model to show in plot:
  output$inp_select_model2 <- renderUI(
    selectInput("select_model2", "Select model 2:",
                choices = c("none", models),
                selected = "KIT-baseline")
  )

  # input element to select third model to show in plot:
  output$inp_select_model3 <- renderUI(
    selectInput("select_model3", "Select model 3:",
                choices = c("none", models),
                selected = "none")
  )

  # input element to select fourth model to show in plot:
  output$inp_select_model4 <- renderUI(
    selectInput("select_model4", "Select model 4:",
                choices = c("none", models),
                selected = "none")
  )

  # input element to select fifth model to show in plot:
  output$inp_select_model5 <- renderUI(
    selectInput("select_model5", "Select model 5:",
                choices = c("none", models),
                selected = "none")
  )

  # input element to select start date of evaluation period if horizon is used
  output$inp_select_first_date <- renderUI({
    selectInput("select_first_date", "First forecast date to consider", timezeros,
                selected = as.Date("2020-10-12"))
  })

  # input element to select end date of evaluation period if horizon is used
  output$inp_select_last_date <- renderUI({
    selectInput("select_last_date", "Last forecast date to consider", timezeros,
                selected = max(timezeros[timezeros <= Sys.Date()]))
  })

  # input element to select forecast date:
  output$inp_select_date <- renderUI({
    if(input$select_stratification == "forecast_date" || is.null(input$select_stratification)){
      selectInput("select_date", "Select forecast date:", choices = timezeros)
    }else{
      radioButtons("select_horizon", "Select forecast horizon:",
                   choices = c("1 wk ahead", "2 wk ahead", "3 wk ahead", "4 wk ahead"))
    }
  })

  # input element to select location:
  output$inp_select_location <- renderUI(
    selectInput("select_location", "Select location:", choices = locations, selected = "GM")
  )

  # Plot:
  output$plot <- renderPlot({

    # restrict data for coloured part of plot:
    dat_evaluation_restricted <- list("ECDC" = subset(dat_evaluation$ECDC,
                                                      timezero >= input$select_first_date &
                                                        timezero <= input$select_last_date),
                                      "JHU" = subset(dat_evaluation$ECDC,
                                                     timezero >= input$select_first_date &
                                                       timezero <= input$select_last_date))

    # # requires a distinction
    # if(input$select_stratification == "horizon"){
    #   dat_evaluation_restricted <- list("ECDC" = subset(dat_evaluation_restricted$ECDC,
    #                                                     grepl(input$select_horizon, target)),
    #                                     "JHU" = subset(dat_evaluation$JHU,
    #                                                     grepl(input$select_horizon, target)))
    # }else{
    #   dat_evaluation_restricted <- list("ECDC" = subset(dat_evaluation_restricted$ECDC,
    #                                                     timezero == input$select_date),
    #                                     "JHU" = subset(dat_evaluation$JHU,
    #                                                    timezero == input$select_date))
    #   }

    # deteime start and end for plot:
    start <- ifelse(input$select_stratification == "horizon",
                    as.Date(input$select_first_date) - 28,
                    as.Date(input$select_date) - 28)
    end <- ifelse(input$select_stratification == "horizon",
                  as.Date(input$select_last_date) + 28,
                  as.Date(input$select_date) + 42)

    selected_models <- c(input$select_model1, input$select_model2,
                         input$select_model3, input$select_model4,
                         input$select_model5)

    # plot settings:
    par(las = 1, mar = c(4, 6, 4, 1), mfrow = c(3, 1), cex = 1)


    # plot forecasts from first model, coloured
    plot1 <- plot_from_eval(dat_eval = dat_evaluation_restricted$ECDC,
                   model = selected_models,
                   location = input$select_location,
                   target_type = input$select_target_type,
                   inc_or_cum = input$select_inc_or_cum,
                   start = start, end = end,
                   forecast_date = if(input$select_stratification == "forecast_date") input$select_date else NULL,
                   horizon = if(input$select_stratification == "horizon") input$select_horizon else NULL,
                   col = cols_models, shifts = shifts)
    title(paste(input$select_horizon, input$select_inc_or_cum, input$select_target_type, "-",
                input$select_location,
                ifelse(!is.null(input$select_date), "- Forecast from", ""), input$select_date))
#
#     # plot forecasts from second model, coloured
#     plot_from_eval(dat_eval = dat_evaluation_restricted$ECDC,
#                    model = input$select_model2,
#                    location = input$select_location,
#                    target_type = input$select_target_type,
#                    inc_or_cum = input$select_inc_or_cum,
#                    start = start, end = end, ylim = plot1$ylim,
#                    forecast_date = if(input$select_stratification == "forecast_date") input$select_date else NULL,
#                    horizon = if(input$select_stratification == "horizon") input$select_horizon else NULL,
#                    col = "blue")

    # plot scores
    plot_scores(scores = dat_evaluation_restricted,
                target = paste(input$select_inc_or_cum, input$select_target_type),
                timezero = if(input$select_stratification == "forecast_date") input$select_date else NULL,
                horizon = if(input$select_stratification == "horizon") input$select_horizon else NULL,
                selected_truth = "ECDC",
                models = selected_models,
                location = input$select_location,
                start = as.Date(start, origin = "1970-01-01"),
                end = as.Date(end, origin = "1970-01-01"),
                cols = cols_models, shifts = shifts, width = 0.5)
    title("Indvidual scores: mean absolute error and WIS")

    # plot average scores:
    plot_scores(scores = dat_evaluation_restricted,
                target = paste(input$select_inc_or_cum, input$select_target_type),
                timezero = if(input$select_stratification == "forecast_date") input$select_date else NULL,
                horizon = if(input$select_stratification == "horizon") input$select_horizon else NULL,
                selected_truth = "ECDC",
                models = selected_models,
                location = input$select_location,
                start = as.Date(start, origin = "1970-01-01"),
                end = as.Date(end, origin = "1970-01-01"),
                cols = cols_models, display = "average_scores")
    title("Average scores")
    legend("right", legend = selected_models[selected_models != "none"],
           col = cols_models[selected_models != "none"], bty = "n", pch = 15)

    # # plot coverage:
    # plot_scores(scores = dat_evaluation_restricted,
    #             target = paste(input$select_inc_or_cum, input$select_target_type),
    #             timezero = if(input$select_stratification == "forecast_date") input$select_date else NULL,
    #             horizon = if(input$select_stratification == "horizon") input$select_horizon else NULL,
    #             selected_truth = "ECDC", models = c(input$select_model1, input$select_model2),
    #             location = input$select_location,
    #             start = as.Date(start, origin = "1970-01-01"),
    #             end = as.Date(end, origin = "1970-01-01"),
    #             cols = c("red", "blue"), display = "coverage")
    # title("Empirical coverage")
    # legend("topleft", col = c("grey", "black"), legend = c("coverage 50% PI", "coverage 95% PI"), lwd = 4, bty = "n")
  })


  # output table:
  output$tab <- DT::renderDataTable({

    tab <- dat_evaluation$ECDC

    # restrict to relevant rows:
    tab <- subset(tab,
                timezero >= input$select_first_date &
                  timezero <= input$select_last_date &
                  grepl(paste(input$select_inc_or_cum,
                              input$select_target_type), target) &
                  !grepl("0 wk", target) &
                  location == input$select_location)

    # compute coverages:
    tab$coverage0.5 <- (tab$truth >= tab$value.0.25 &
                                tab$truth <= tab$value.0.75)
    tab$coverage0.95 <- (tab$truth >= tab$value.0.025 &
                                 tab$truth <= tab$value.0.975)

    # introduce variables needed for re-formatting:
    tab$target_type <- ifelse(grepl("death", tab$target), "death", "case")
    tab$horizon <- substr(tab$target, start = 1, stop = 1)
    tab$inc_or_cum <- as.factor(ifelse(grepl("inc", tab$target), "inc", "cum"))

    # select relevant columns:
    tab <- tab[, c("location", "inc_or_cum", "target_type", "timezero", "model",
                               "coverage0.5", "coverage0.95", "ae", "wis", "horizon")]

    # bring to long format to distinguish between score measures:
    tab_long <- reshape(tab, varying = c("ae", "wis", "coverage0.5", "coverage0.95"),
                          v.names = "score_value",
                          timevar = "score_type",
                          times = c("ae", "wis", "coverage0.5", "coverage0.95"),
                          direction = "long")
    tab_long$id <- NULL

    # bring to wide format with separate variables for horizons:
    tab_wide <- reshape(tab_long, direction = "wide", timevar = "horizon",
                          idvar = c("location", "timezero", "target_type", "inc_or_cum",
                                    "model", "score_type"))
    rownames(tab_wide) <- NULL

    # subset to selected performance measure:
    tab_wide <- subset(tab_wide, score_type == input$score_type)

    # remode rows with NA values only:
    columns_scores <- colnames(tab_wide)[grepl("score_value", colnames(tab_wide))]
    tab_wide <- tab_wide[rowSums(is.na(tab_wide[, columns_scores])) < 4, ]

    n_forecasts_per_model <- table(tab_wide$model)
    models_to_keep <- names(n_forecasts_per_model)[n_forecasts_per_model == max(n_forecasts_per_model)]
    print(models_to_keep)
    tab_wide <- subset(tab_wide, model %in% models_to_keep)

    summary_tab <- aggregate(cbind(score_value.1, score_value.2, score_value.3, score_value.4)~
                                     location + inc_or_cum + target_type + model + score_type,
                                   data = tab_wide, na.action = na.pass, FUN = mean, na.rm = TRUE)

    # round for display in table:
    summary_tab[, columns_scores] <- round(summary_tab[, columns_scores],
                                                 ifelse(input$score_type %in% c("wis", "ae"), 0, 2))

    # print:
    datatable(summary_tab, filter = "top",
              options = list(
                pageLength = 15,
                columnDefs = list(list(searchable = FALSE, targets = 6:9))
              ),
              colnames = c("Country", "inc/cum", "case/death", "model",
                           "error measure", "1 wk ahead", "2 wk ahead", "3 wk ahead", "4 wk ahead"))
  })
})
