# Workflow for evaluating experimental ensembles from forecasts from the Euro Forecast Hub.
  # Create ensembles using a variety of different methods,
  # save them in a separate /ensembles/ directory, and score them using the
  # same process for scoring individual real-time weekly forecasts.

# Packages:
# Scoringutils dev version
  # remotes::install_github("epiforecasts/scoringutils", dependencies = TRUE)
# EuroForecastHub
  # remotes::install_github("covid19-forecast-hub-europe/EuroForecastHub")

library(here)
library(EuroForecastHub)

# Settings
opts <- list(
  subdir = "ensembles",
  restrict_weeks = 4L,
  histories = c("All"),
  latest_date = as.Date("2022-03-07")
)

# Create and save ensembles to separate ensembles/ directory
source(here("code", "ensemble", "utils", "create-all-methods-ensembles.R"))

# Score, absolute
source(here("code", "evaluation", "score_models.r"))

# Score, relative
opts$re_run <- FALSE # only create a single aggregated score as of the `latest_date`
source(here("code", "evaluation", "aggregate_scores.r"))
