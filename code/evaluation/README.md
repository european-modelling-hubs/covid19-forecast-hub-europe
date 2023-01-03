This code evaluates forecasts in `data-processed`. These evaluations are the basis for our weekly [model reports](https://covid19forecasthub.eu/reports.html).

## Implementation
To reproduce the steps for evaluation that we run weekly in a [Github Action](.github/workflows/scoring.yml), use the following R scripts. See options in each script for running retrospective evaluations across past dates.

```
# score all forecasts over all time using the latest data in the repo
source(score_models.r)
# combine scores to produce relative evaluations for the latest week
source(aggregate_scores.r) 
```