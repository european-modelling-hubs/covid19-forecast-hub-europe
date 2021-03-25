## European hub ensembles

The European hub produces weekly ensemble forecasts from valid submitted models. Ensembles are saved in [data-processed](./data-processed) with the team name "EuroCOVIDhub".

### Inclusion criteria

Forecasts must have all of the following to be included in the ensemble:

- Includes all quantiles for each horizon
- Includes forecasts over a four week horizon
- Not manually specified for exclusion (e.g. because of late submission)

We detail the inclusion and exclusion of models in a [weekly csv](./code/ensemble/criteria).

### Ensemble methods

**Current methods**

Ensembling methods combine forecast values by target, location, horizon, and quantile. At the moment we use the following:

- Mean average ([`EuroCOVIDhub-ensemble`](./data-processed/EuroCOVIDhub-ensemble))
- Median average ([`EuroCOVIDhub-median`](./data-processed/EuroCOVIDhub-median))

The ensemble we use in evaluation is the "EuroCOVIDhub-ensemble".

**Guide to ensemble code**

Use the [`run-ensembles.R`](./code/ensemble/run-ensembles.R) script to create and save all ensembles as well as the logic for model inclusion.

This uses the following flow:

   |   
---|---
[`use-ensemble-criteria.R`](./code/ensemble/utils/load-ensemble-forecasts.R) | Filter given forecasts based on the [inclusion criteria](#Inclusion criteria)
[`create-ensemble-average.R`](./code/ensemble/methods/create-ensemble-average.R) | Create a mean or a median ensemble
[`format-ensembles.R`](./code/ensemble/utils/format-ensembles.R) | Prepare an ensemble according to the standard submission format