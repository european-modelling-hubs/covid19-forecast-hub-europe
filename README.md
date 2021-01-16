# European COVID-19 Forecast Hub

We are aggregating forecasts of new cases and deaths due to Covid-19 over the next four weeks in countries across Europe and the UK.

##### Latest forecasts
* See the current forecasts [here //TBC]()
* We publish an evaluation of current forecasts [here //TBC]()
* Raw forecast files are in the `data-processed` folder

##### README contents
- [Quick start](#quick-start)
- [About Covid-19 forecast hubs](#about-covid-19-forecast-hub)
- [European forecast hub team](#european-forecast-hub-team)
- [Data license and reuse](#data-license-and-reuse)

## Quick start
This is a brief outline for anyone considering contributing a forecast. For a detailed guide on how to structure and submit a forecast, please read the [technical wiki](https://github.com/epiforecasts/covid19-forecast-hub-europe/wiki). Before contributing for the first time, please get in touch by opening an [issue](https://github.com/epiforecasts/covid19-forecast-hub-europe/issues).

#### Forecasting
We require some forecast parameters so that we can compare and ensemble forecasts. All forecasts should use the following structure:

| Parameter | Description |
| ----------- | ----------- |
| Target | Cases and/or deaths |
| Count | Incident |
| Geography | EU/UK nations (any/all) |
| Frequency | Weekly |
| Horizon | 1 to 4 weeks |

There is no obligation to submit forecasts for all suggested targets or horizons, and it is up to you to decide which you are comfortable forecasting with your model.

###### Dates
We use [epidemiological weeks (EWs)](https://wwwn.cdc.gov/nndss/document/MMWR_Week_overview.pdf) defined by the US CDC. These start on Sunday and end on Saturday. There are standard software packages to convert from dates to epidemic weeks and vice versa. In R this includes the `MMWRweek` package or the `lubridate::epiweek()` function, or the packages  `pymmwr` and `epiweeks` in Python.

###### Truth data
We base evaluations on data from the [European Centre for Disease Prevention and Control](https://www.ecdc.europa.eu/en/geographical-distribution-2019-ncov-cases).


#### Submitting
Forecasts should be submitted between *# start date* and *# end date*. Submit a forecast using a pull request (our wiki contains a detailed [guide](https://github.com/epiforecasts/covid19-forecast-hub-europe/wiki)). If you have technical difficulties with submission, get in touch by raising an [issue](https://github.com/epiforecasts/covid19-forecast-hub-europe/issues).

###### Evaluating and ensembling
After teams have submitted their forecasts, we create an ensemble forecast. Note that the ensemble only includes the forecasts that completely match the standard format (for example those with all the specified quantiles). See the [inclusion criteria](https://github.com/epiforecasts/covid19-forecast-hub-europe/wiki/Ensembling-and-evaluation) for more details.

We also publish some weekly evaluation across forecasting models.

## About Covid-19 forecasting hubs
This effort parallels forecasting hubs in the US and Germany. We follow a similar structure and data format, and re-use software provided by the ReichLab.

- The [US COVID-19 Forecast Hub](https://github.com/reichlab/covid19-forecast-hub) is run by the UMass-Amherst Influenza Forecasting Center of Excellence based at the [Reich Lab](https://reichlab.io/).

- The [German and Polish COVID-19 Forecast Hub](https://github.com/KITmetricslab/covid19-forecast-hub-de) is run by members of the [Karlsruher Institut für Technologie (KIT)](https://statistik.econ.kit.edu/index.ph) and the [Computational Statistics Group at Heidelberg Institute for Theoretical Studies](https://www.h-its.org/research/cst/).

## European forecast hub team
The following persons have contributed to this repository (in alphabetical order):

- Nikos Bosse
- Sebastian Funk
- Katharine Sherratt

## Data license and reuse
- The forecasts assembled in this repository have been created by independent teams. Most provide a license in their respective subfolder of `data-processed`.
- Parts of the processing, analysis and validation code have been taken or adapted from the [US Covid-19 forecast hub](https://github.com/reichlab/covid19-forecast-hub) and the [Germany/Poland Covid-19 forecast hub](https://github.com/KITmetricslab/covid19-forecast-hub-de) both under an [MIT license](https://github.com/reichlab/covid19-forecast-hub/blob/master/LICENSE).
- All code contained in this repository is under the [MIT license](https://github.com/epiforecasts/covid19-forecast-hub-europe/blob/master/LICENSE). **Please get in touch with us to re-use materials from this repository.**
