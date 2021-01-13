library(shiny)
library(shinyjs)
library(shinydashboard)
library(shinyBS)


dashboardPage(
  title = "Interactive visualization of COVID19 case and death forecasts (Germany and Poland)",
  dashboardHeader(title = ""),
  skin = "yellow",
  ## Sidebar content
  dashboardSidebar(
    sidebarMenu(
      menuItem("Forecasts", tabName = "forecasts", icon = icon("area-chart")),
      menuItem("Background", tabName = "background", icon = icon("gear")))
  ),
  ## Body content
  dashboardBody(
    tabItems(

      # start tab:
      tabItem(tabName = "forecasts",
              titlePanel("Assembling forecasts of COVID19 cases and deaths in Germany and Poland"),
              # input elements generated on server side:
              div(style="display:inline-block",
                  radioButtons("select_stratification", "Show forecasts by:",
                           choices = list("Forecast date" = "forecast_date",
                                          "Forecast horizon" = "horizon"),
                           selected = "forecast_date", inline = TRUE)
                  ),
              span(HTML("&nbsp")),
              bsButton("stratification", label = "", icon = icon("question"), style = "info", size = "extra-small"),
              bsPopover(id = "stratification", title = "Display of forecasts",
                        content = paste0("Forecasts can either be shown for a fixed forecast date ",
                                         "(i.e. date when the forecast was issued) ",
                                         "and different forecast horizons (one through four weeks ",
                                         "ahead) or for all forecast dates and a fixed forecast horizon.")
              ),

              br(),
              div(style="display:inline-block", uiOutput("inp_select_date")),
              div(style="display:inline-block", selectInput("select_target", label = "Select target:",
                                                            choices = list("cumulative deaths" = "cum death",
                                                                           "incident deaths" = "inc death",
                                                                           "cumulative cases" = "cum case",
                                                                           "incident cases" = "inc case"))),
              div(style="display:inline-block", uiOutput("inp_select_location")),
              uiOutput("inp_select_model"),

              actionButton("show_all", "Show all"),
              actionButton("hide_all", "Hide all"),
              div(style="display:inline-block",
                  checkboxInput("show_pi.50", label = "Show 50% prediction interval where available", value = FALSE)              ),
              div(style="display:inline-block",
                  checkboxInput("show_pi.95", label = "Show 95% prediction interval where available", value = TRUE)
              ),
              # div(style="display:inline-block",
              #     checkboxInput("remove_retrospective", label = "Remove forecasts added retrospectively.", value = FALSE)
              # ),
              br(),
              div(style="display:inline-block",
                  radioButtons("select_truths", "Select handling of truth data:",
                                 choiceNames = c("Show original forecasts irrespective of used truth data", "Shift all forecasts to ECDC/RKI data", "Shift all forecasts to JHU data (only national level)"),
                                 choiceValues = c("both", "ECDC", "JHU"),
                                 selected = c("ECDC"), inline = TRUE)
                  ),
              span(HTML("&nbsp")),
              bsButton("truths", label = "", icon = icon("question"), style = "info", size = "extra-small"),
              bsPopover(id = "truths", title = "Truth data sources",
                        content = paste0("Some teams base their forecasts on ECDC data, others on JHU data ",
                                         "(the data source used by each team is indicated by the respective point shape in the plot). ",
                                         "Forecasts of cumulative quantities can be shown either as they were ",
                                         "made by the teams or vertically shifted so they are aligned with ",
                                         "the last observation of a given data source. ",
                                         "The vertical shift corresponds to the last observed difference between ",
                                         "the respective data sources.")
              ),
              br(),
              div(style="display:inline-block",
                  checkboxInput("show_evaluation", label = "Show evaluation (in development)", value = FALSE)
                  ),
              bsButton("evaluations", label = "", icon = icon("question"), style = "info", size = "extra-small"),
              bsPopover(id = "evaluations", title = "Evaluation",
                        content = paste0("We use two different measures to assess predictive performance. ",
                                         "The absolute error (AE) serves to assess the accuracy of the point forecast ",
                                         "typically the predictive median).",
                                         "The weighted interval score (WIS) assesses all prediction intervals (or quantiles) ",
                                         "simulataneously and thus also takes into account the uncertainty of a distribution. ",
                                         "See our github repo/wiki for more information.")
              ),
              br(),
              # checkboxInput("show_model_past", label = "Show past values assumed by models where available", value = TRUE),
              tags$b("Draw rectangle to zoom in, double click to zoom out. Hover over grey line to display numbers (point forecasts and observed)."),
              h3(""),
              # plot:
              plotOutput("plot_forecasts", height = 500,
                         click = "coord_click", hover = "coord_hover",
                         brush = brushOpts(id = "coord_brush", resetOnNew = TRUE),
                         dblclick = clickOpts("coord_dblclick")),
              # evaluation plot:
              conditionalPanel("input.show_evaluation",
                               plotOutput("plot_evaluation", height = 500))

      ),

      # tab on background:
      tabItem(tabName = "background",
              h3("Purpose"),
              "This interactive visualization is part of the",
              tags$a(href = "https://github.com/KITmetricslab/covid19-forecast-hub-de/",
                     "German and Polish version of the COVID-19 forecast hub."),
              "The forecasts shown here have been created by various independent international research groups. Links to these",
              "groups, the respective raw data and licences can be found",
              tags$a(href = "https://github.com/KITmetricslab/covid19-forecast-hub-de#teams-generating-forecasts", "here."),
              "The repository also contains the",
              tags$a(href = "https://github.com/KITmetricslab/covid19-forecast-hub-de/tree/master/app_forecasts_de", "code"),
              "behind this app.",
              "This effort is inspired by the",
              tags$a(href = "https://github.com/reichlab/covid19-forecast-hub", "US COVID-19 forecast hub."),
              h3("Creators"),
              "The following persons are contributing to the forecast hub (in alphabetical order): Johannes Bracher,",
              "Jannik Deuschel, Tilmann Gneiting, Konstantin Görgen, Melanie Schienle. Details can be found",
              tags$a(href = "https://github.com/KITmetricslab/covid19-forecast-hub-de#forecast-hub-team", "here."),
              "All contributors are members of the",
              tags$a(href = "https://statistik.econ.kit.edu/index.php", "Chair of Econometrics and Statistics, Karlsruhe Institute of Technology"),
              "and/or the",
              tags$a(href = "https://www.h-its.org/research/cst/", "Computational Statistics Group at Heidelberg Institute of Theoretical Studies."),
              "Note, however, that the forecast hub is not officially endorsed by neither KIT nor HITS.",
              "This Shiny app has been implemented by Johannes Bracher.")
    )
  )
)
