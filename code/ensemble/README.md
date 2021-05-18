This folder contains code for running and evaluating multiple ensemble methods.

The  [EuroCOVIDhub](./code/ensemble/EuroCOVIDhub) file contains code specifically for creating the European forecasting hub ensemble published each week.


_General purpose ensemble code_

Purpose | Function | Description
---|---|---
Utility | [`run_ensemble()`](./code/ensemble/utils/run-ensemble.R) | Specify a supported method and a (set of) valid dates to create a single formatted ensemble
Utility | [`run_multiple_ensembles()`](./code/ensemble/utils/run-multiple-ensembles.R) | Input one or more supported methods and forecast dates: returns a list of ensembles for each method/date combination. This is implemented for all methods and forecast dates in [`create-all-methods-ensembles.R`](./code/ensemble/utils/create-all-methods-ensembles.R)
Utility | [`use_ensemble_criteria()`](./code/ensemble/utils/use-ensemble-criteria.R) | Filter given forecasts based on the [inclusion criteria](./code/ensemble/EuroCOVIDhub/README.md#Inclusion-criteria)
Utility | [`format_ensemble()`](./code/ensemble/utils/format-ensemble.R) | Prepare an ensemble according to the standard submission format

_Methods_

Type | Function | Description
---|---|---
Unweighted | [`create_ensemble_average()`](./code/ensemble/methods/create-ensemble-average.R) | Create a mean or a median ensemble
