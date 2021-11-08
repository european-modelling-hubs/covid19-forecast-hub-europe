This folder contains code for running and evaluating ensemble methods.

To run a single ensemble on hub forecasts, use the `run_ensemble()` function combined with one of the [supported methods](#methods) for any given forecast date.

See the [EuroCOVIDhub](EuroCOVIDhub) folder for the code and history of the European forecasting hub ensemble published each week.

## Methods

Currently, our code supports the following ensemble methods. Find ensemble forecasts for all methods over time in [Forecasts](../../ensembles/data-processed).

Type | Method | Function
---|---|---
Unweighted | Mean | [`create_ensemble_average(method = "mean")`](https://github.com/epiforecasts/EuroForecastHub/blob/main/R/create_ensemble_average.R)
Unweighted | Median | [`create_ensemble_average(method = "median")`](https://github.com/epiforecasts/EuroForecastHub/blob/main/R/create_ensemble_average.R)
Weighted | Mean | [`create_ensemble_relative_skill(average = "mean")`](https://github.com/epiforecasts/EuroForecastHub/blob/main/R/create_ensemble_relative_skill.R)
Weighted | Median | [`create_ensemble_average(average = "median")`](https://github.com/epiforecasts/EuroForecastHub/blob/main/R/create_ensemble_relative_skill.R)

## Implementation

These functions support running and formatting ensembles.

Function | Description
---|---
[`run_ensemble()`](https://github.com/epiforecasts/EuroForecastHub/blob/main/R/run_ensemble.R) | Specify a supported method and a valid date to create a single formatted ensemble
[`use_ensemble_criteria()`](https://github.com/epiforecasts/EuroForecastHub/blob/main/R/use_ensemble_criteria.R) | Filter given forecasts based on the [hub inclusion criteria](EuroCOVIDhub/README.md#inclusion-criteria)
[`format_ensemble()`](https://github.com/epiforecasts/EuroForecastHub/blob/main/R/format_ensemble.R) | Prepare an ensemble according to the standard submission format
[`run_multiple_ensembles()`](https://github.com/epiforecasts/EuroForecastHub/blob/main/R/run_multiple_ensembles.R) | Specify one or more supported methods and forecast dates to create a list of ensembles for each method/date combination. This is implemented for all methods and forecast dates in [`create-all-methods-ensembles.R`](utils/create-all-methods-ensembles.R)

## Create all methods ensembles

To create ensembles for all times and using all implemented methods for comparison, you can use the script [`create-all-methods-ensembles.R`](https://github.com/epiforecasts/covid19-forecast-hub-europe/blob/main/code/ensemble/utils/create-all-methods-ensembles.R):

```{sh}
Rscript code/ensemble/utils/create-all-methods-ensembles.R
```

To score them you can then use

```{sh}
Rscript code/evaluation/score_models.r ensembles
Rscript code/evaluation/aggregate_scores.r ensembles
```

To create a performance report from them, you can use

```{sh}
Rscript code/reports/compile-country-reports --countries Overall ensembles
```

This will compile a report across countries and put it in `html/ensembles`
