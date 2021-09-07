## European hub ensemble

The European hub produces weekly ensemble forecasts from valid submitted models. Ensembles are saved in [data-processed](../../../data-processed/EuroCOVIDhub-ensemble) with the team name "EuroCOVIDhub".

### Inclusion criteria

For each location and target (cases or deaths), forecasts must have all of the following to be included in the ensemble:

- Includes all quantiles
- Includes forecasts over a four week horizon
- Not manually specified for exclusion (e.g. because of late submission)

We detail the inclusion and exclusion of models in a csv updated [weekly](criteria).

### Ensemble methods

**Current methods**

Ensembling methods combine forecast values by target, location, horizon, and quantile. The ensemble we use in evaluation is the "EuroCOVIDhub-ensemble". See [here](../../../forecasthub.yml) for the current ensemble method used this week.

We are continually reviewing the performance of the default ensemble compared to other ensembling methods. We will make a change if we find a different method to consistently outperform the current default.

**Past methods**

- See all past [ensemble forecasts](../../../data-processed/EuroCOVIDhub-ensemble) in the hub
- Check the history of which [methods](../EuroCOVIDhub/method-by-date.csv) we've used
- See which [contributing forecasts](../EuroCOVIDhub/criteria) were used to create each ensemble

**Guide to ensemble code**

_Creating the EuroCOVIDhub weekly ensemble_

- Add any models for manual exclusion to [`manual-exclusions.csv`](../EuroCOVIDhub/manual-exclusions.csv)
   - If already in R, optionally add these by [`create-manual-exclusions.R`](../utils/create-manual-exclusions.R)
- Define the forecast method in [`forecasthub.yml`](../../../forecasthub.yml)
- The weekly ensemble is created with [`create-weekly-ensemble.R`](../EuroCOVIDhub/create-weekly-ensemble.R)
