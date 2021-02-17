#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)

# Define UI
shinyUI(fluidPage(

  # Application title
  titlePanel("Visualize your forecasts prior to submission (European COVID19 Forecast Hub)"),

  # Sidebar with a slider input for number of bins
  sidebarLayout(
    sidebarPanel(
      fileInput("file1", "Choose file to upload", accept = ".csv"),
      uiOutput("inp_select_location")
    ),

    # Show a plot of the generated distribution
    mainPanel(
      tags$style("#result_checks {font-size:15px;
               font-family:'Courier New';
               display:block; }"),

      h4("Forecast visualization:"),
      plotOutput("plot"),
      tags$div(
        tags$span(style="color:white", ".")
      ),
      tags$div(
        tags$span(style="color:white", ".")
      ),
      h6(" Even if your files are displayed correctly here it is possible that they fail the format checks on the GitHub platform. The formal evaluation checks are not run on this site, it serves solely for visualization. Information on how to run local
         validation checks can be found in the Wiki of or github repository."),
      h4("A few things worth checking:"),
      h6("The following are no requirements for submission and will not be checked after your pull request.",
         "This is just a non-exhaustive list of plausibility checks we have found useful in the past."
      ),
      tags$div(
        tags$ul(
          tags$li(tags$b("Vertical alignment of cumulative forecasts:"),
                  "jumps between last observed data and predictions can indicate technical problems."),
          tags$li(tags$b("No implied negative numbers of new deaths:"),
                  "the prediction intervals for cumulative cases/deaths should not imply a decrease compared to the last",
                  "observation is possible (or this should be very unlikely)."),
          tags$li(tags$b("Plausible pattern across forecast horizons:"),
                  "if forecasts one through four weeks ahead are not 'smooth' this may indicate problems (unless there is a plausible explanation)."),
          tags$li(tags$b("Coherence between incident and cumulative forecasts:"),
                  "Your incident and cumulative forecasts for the same target should be compatible with each other. For one-week-ahead forecasts",
                  "the cumulative forecasts should be a shited version of the incident forecasts. For larger horizons this is no generally no longer",
                  "the case, but it is still worth checking for major discrepancies."),
          tags$li(tags$b("Appropriate degree of dispersion:"),
                  "Check whether you are confident that the 50% and 95% forecast intervals will cover the observations in 50% and 95% of the cases, respectively."),
          tags$li(tags$b("Dispersion increases with forecast horizon:"),
                  "Forecast uncertainty often (though not always) increases somewhat for larger horizons as events further in the future are typically harder to predict."),
          tags$li(tags$b("Plausible skewness:"),
                  "As count outcomes have a natural lower limit (zero), they often have a right-skewed distribution. This means that typically the median will",
                  "be closer to the lower than the upper end of your forecast intervals.")
        )
      )
    )
  )
))
