## European hub ensemble

The European hub produces weekly ensemble forecasts from valid submitted models. Ensembles are saved in [data-processed](./data-processed/EuroCOVIDhub) with the team name "EuroCOVIDhub".

### Inclusion criteria

For each location and target (cases or deaths), forecasts must have all of the following to be included in the ensemble:

- Includes all quantiles
- Includes forecasts over a four week horizon
- Not manually specified for exclusion (e.g. because of late submission)

We detail the inclusion and exclusion of models in a csv updated [weekly](./code/ensemble/EuroCOVIDhub-ensemble/criteria).

### Ensemble methods

**Current methods**

Ensembling methods combine forecast values by target, location, horizon, and quantile. The ensemble we use in evaluation is the "EuroCOVIDhub-ensemble". See [here](./code/ensemble/current-method.txt) for the current ensemble method used this week.

We are continually reviewing the performance of the default ensemble compared to other ensembling methods. We will make a change if we find a different method to consistently outperform the current default.

**Past methods**

- See all past [ensemble forecasts](./data-processed/EuroCOVIDhub-ensemble)
- Check the history of which [methods](./code/ensemble/EuroCOVIDhub-ensemble/method-by-date.csv) we've used
- See which [models](./code/ensemble/EuroCOVIDhub-ensemble/criteria) were used to create each ensemble

**Guide to ensemble code**

_Creating the EuroCOVIDhub weekly ensemble_

- Add any models for manual exclusion to [`manual-exclusions.csv`](./code/ensemble/EuroCOVIDhub/manual-exclusions.csv)
   - If already in R, optionally add these by [`create-manual-exclusions.R`](./code/ensemble/utils/create-manual-exclusions.R)
- Define the forecast method in [`current-method.txt`](./code/ensemble/EuroCOVIDhub/current-method.txt)
- The weekly ensemble is created with [`create-weekly-ensemble.R`](./code/ensemble/EuroCOVIDhub/create-weekly-ensemble.R)

_General purpose ensemble code_

Purpose | Function | Description   
---|---|---
Method | [`create_ensemble_average()`](./code/ensemble/methods/create-ensemble-average.R) | Create a mean or a median ensemble
Utility | [`run_ensemble()`](./code/ensemble/utils/run-ensemble.R) | Specify a method and a (set of) valid dates to create a single formatted ensemble
Utility | [`use_ensemble_criteria()`](./code/ensemble/utils/use-ensemble-criteria.R) | Filter given forecasts based on the [inclusion criteria](#Inclusion criteria)
Utility | [`format_ensemble()`](./code/ensemble/utils/format-ensemble.R) | Prepare an ensemble according to the standard submission format
