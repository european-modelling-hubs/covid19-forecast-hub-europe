This folder contains code for running and evaluating ensemble methods.

To run a single ensemble on hub forecasts, use the `run_ensemble()` function combined with one of the [supported methods](#methods) for any given forecast date.

See the [EuroCOVIDhub](./code/ensemble/EuroCOVIDhub) folder for the code and history of the European forecasting hub ensemble published each week.

## Methods

Currently, our code supports the following ensemble [methods](./code/ensemble/methods). Find ensemble forecasts for all methods over time in [Forecasts](ensembles).

Type | Method | Function
---|---|---
Unweighted | Mean | [`create_ensemble_average(method = "mean")`](./code/ensemble/methods/create-ensemble-average.R)
Unweighted | Median | [`create_ensemble_average(method = "median")`](./code/ensemble/methods/create-ensemble-average.R)

## Implementation

These functions support running and formatting ensembles.

Function | Description
---|---
[`run_ensemble()`](./code/ensemble/utils/run-ensemble.R) | Specify a supported method and a valid date to create a single formatted ensemble
[`use_ensemble_criteria()`](./code/ensemble/utils/use-ensemble-criteria.R) | Filter given forecasts based on the [hub inclusion criteria](./code/ensemble/EuroCOVIDhub/README.md#Inclusion-criteria)
[`format_ensemble()`](./code/ensemble/utils/format-ensemble.R) | Prepare an ensemble according to the standard submission format
[`run_multiple_ensembles()`](./code/ensemble/utils/run-multiple-ensembles.R) | Specify one or more supported methods and forecast dates to create a list of ensembles for each method/date combination. This is implemented for all methods and forecast dates in [`create-all-methods-ensembles.R`](./code/ensemble/utils/create-all-methods-ensembles.R)
