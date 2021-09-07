# European COVID-19 Forecast Hub

We are aggregating forecasts of new cases and deaths due to Covid-19 over the next four weeks in countries across Europe and the UK.

##### Latest forecasts

* View the [current forecasts](https://covid19forecasthub.eu/visualisation)
* We publish a weekly [evaluation](https://covid19forecasthub.eu/reports) of current forecasts
* Raw forecast files are in the [data-processed](https://github.com/epiforecasts/covid19-forecast-hub-europe/tree/main/data-processed) folder

##### README contents

- [Quick start](#quick-start)
- [About Covid-19 forecast hubs](#about-covid-19-forecasting-hubs)
   - [European forecast hub team](#european-forecast-hub-team)
   - [Data license and reuse](#data-license-and-reuse)

## Quick start

This is a brief outline for anyone considering contributing a forecast. For a detailed guide on how to structure and submit a forecast, please read the [technical wiki](../../wiki).

#### Set up

Before contributing for the first time:
* Read the guide for [preparing to submit](../../wiki/Preparing-to-submit)
* Create a [team directory](../../wiki/Creating-a-team-directory)
* Add your [metadata](../../wiki/Metadata) and a [license](../../wiki/Licensing)

#### Forecasting

We require some forecast parameters so that we can compare and ensemble forecasts. All forecasts should use the following structure:

| Parameter | Description |
| ----------- | ----------- |
| Target | Cases and/or deaths |
| Count | Incident |
| Geography | EU/EFTA/UK nations (any/all) |
| Frequency | Weekly |
| Horizon | 1 to 4 weeks |

There is no obligation to submit forecasts for all suggested targets or horizons, and it is up to you to decide which you are comfortable forecasting with your model.

We have written more about forecast targets, horizons, and locations in the [guide](../../wiki/Targets-and-horizons).

###### Dates

We use Epidemiological Weeks (EW) defined by the [US CDC](https://wwwn.cdc.gov/nndss/document/MMWR_Week_overview.pdf). Each week starts on Sunday and ends on Saturday. We provide more details [here](../../wiki/Targets-and-horizons#date-format), and [templates](../../template) to convert dates to EW weeks (and vice versa).

###### Truth data

We base evaluations on country level data from [Johns Hopkins University](https://github.com/CSSEGISandData/COVID-19/tree/master/csse_covid_19_data/csse_covid_19_time_series).

#### Submitting

Forecasts should be submitted on Monday by opening a pull request in this repository. So that we can evaluate and ensemble forecasts, we ask for a specific file structure and naming format: our wiki contains a detailed [guide](../../wiki/Forecast-format). If you have technical difficulties with submission, try [troubleshooting](../..wiki/Troubleshooting-pull-requests) or get in touch by raising an [issue](../issues).

###### Evaluating and ensembling

After teams have submitted their forecasts, we create an ensemble forecast. Note that the ensemble only includes the forecasts that completely match the standard format (for example those with all the specified quantiles). See the [inclusion criteria](../../wiki/Ensembling-and-evaluation) for more details.

We also publish some weekly evaluation across forecasting models.

## About Covid-19 forecasting hubs

This effort parallels forecasting hubs in the US and Germany. We follow a similar structure and data format, and re-use software provided by the ReichLab.

- The [US COVID-19 Forecast Hub](https://github.com/reichlab/covid19-forecast-hub) is run by the UMass-Amherst Influenza Forecasting Center of Excellence based at the [Reich Lab](https://reichlab.io/).

- The [German and Polish COVID-19 Forecast Hub](https://github.com/KITmetricslab/covid19-forecast-hub-de) is run by members of the [Karlsruher Institut für Technologie (KIT)](https://statistik.econ.kit.edu/index.ph) and the [Computational Statistics Group at Heidelberg Institute for Theoretical Studies](https://www.h-its.org/research/cst/).

### European forecast hub team

This repository is maintained by [Epiforecasts](https://epiforecasts.io). It is based on and supported by members of the US, and German and Polish Forecast Hubs. A small team is adapting this work for the European forecasting hub. We are based at the [London School of Hygiene & Tropical Medicine](https://www.lshtm.ac.uk) and supported by grant funding from the ECDC.

Direct contributors to this repository include (in alphabetical order):

- Daniel Wolffram
- Hugo Gruson
- Jannik Deuschel
- [Johannes Bracher](https://statistik.econ.kit.edu/mitarbeiter_2902.php)
- Katharine Sherratt
- Nikos Bosse
- [Sebastian Funk](https://www.lshtm.ac.uk/aboutus/people/funk.sebastian)

The [interactive visualization tool](https://covid19forecasthub.eu/visualisation/) (code available [here](https://github.com/SignaleRKI/forecast-europe)) has been developed by the [Signale Team at Robert Koch Institute](https://www.rki.de/EN/Content/infections/epidemiology/signals/signals_node.html):
- Fabian Eckelmann
- Knut Perseke
- Alexander Ullrich

### Data license and reuse

- The forecasts assembled in this repository have been created by independent teams. Most provide a license in their respective subfolder of `data-processed`.
- Parts of the processing, analysis and validation code have been taken or adapted from the [US Covid-19 forecast hub](https://github.com/reichlab/covid19-forecast-hub) and the [Germany/Poland Covid-19 forecast hub](https://github.com/KITmetricslab/covid19-forecast-hub-de) both under an [MIT license](https://github.com/reichlab/covid19-forecast-hub/blob/master/LICENSE).
- All code contained in this repository is under the [MIT license](/LICENSE). **Please get in touch with us to re-use materials from this repository.**
