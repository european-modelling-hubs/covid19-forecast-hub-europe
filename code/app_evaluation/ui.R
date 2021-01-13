#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)

# Define UI for application that draws a histogram
shinyUI(fluidPage(

  # Application title
  titlePanel("Forecast Evaluations - German and Polish COVID-19 Forecast Hub"),

  # Sidebar with a slider input for number of bins
  sidebarLayout(
    sidebarPanel(
      radioButtons("select_view", "Select display:", choices = c("Detailed plots"= "plot",
                                                                 "Summary table" = "tab")),
      conditionalPanel("input.select_view == 'plot'",
                       uiOutput("inp_select_model1"),
                       uiOutput("inp_select_model2"),
                       uiOutput("inp_select_model3"),
                       uiOutput("inp_select_model4"),
                       uiOutput("inp_select_model5")
      ),
      uiOutput("inp_select_location"),
      radioButtons("select_inc_or_cum", "Select incidence or cumulative scale:", choices = c("inc", "cum")),
      radioButtons("select_target_type", "Select target type:", choices = c("case", "death")),
      conditionalPanel("input.select_view == 'plot'",
                       radioButtons("select_stratification", "Show forecasts by:",
                                    choices = list("Forecast date" = "forecast_date",
                                                   "Forecast horizon" = "horizon"),
                                    selected = "horizon", inline = TRUE),
                       uiOutput("inp_select_date")),
      conditionalPanel("input.select_view == 'tab'",
                       radioButtons("score_type", "Select performance measure",
                                    choices = c("weighted interval score" = "wis",
                                                "absolute error" = "ae",
                                                "coverage of 50% PI" = "coverage0.5",
                                                "coverage of 95% PI" = "coverage0.95"))),
      conditionalPanel("input.select_stratification == 'horizon'",
                       uiOutput("inp_select_first_date")),
      conditionalPanel("input.select_stratification == 'horizon'",
                       uiOutput("inp_select_last_date"))
    ),

    # Plot
    mainPanel(
      conditionalPanel("input.select_view == 'plot'",
                       h4("Take a detailed look at scores achieved by up to five models."),
                       plotOutput("plot", height = "800px")),
      conditionalPanel("input.select_view == 'tab'",
                       h4("Average scores achieved by all models covering the selected target for all specified time points.
                          Models with missing weeks have been removed."),
                       DT::dataTableOutput("tab"))

    )
  )
))
