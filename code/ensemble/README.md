### Create an equally weighted ensemble (currentl only Germany, national level)

Steps to create the ensemble forecast:

- Create a new file `included_models/included_models-<forecast_date>.csv` containing info on which models to include. This serves to keep things reproducible.
- Run the R script `simple_ensemble.R` (with working directory set to the containing folder).
- Forecasts are written to `data-processed/KITCOVIDhub-ensemble` and can sent to the repo via PR.
