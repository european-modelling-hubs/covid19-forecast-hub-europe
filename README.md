# European COVID-19 Forecast Hub

We are aggregating forecasts of national incidence of cases and deaths due to Covid-19 in countries across Europe and the UK.

The effort parallels forecasting hubs in the US and Germany. We follow a similar structure and data format, and re-use software provided by the ReichLab (see [below](#data-license-and-reuse)).

- The [US COVID-19 Forecast Hub](https://github.com/reichlab/covid19-forecast-hub) is run by the UMass-Amherst Influenza Forecasting Center of Excellence based at the [Reich Lab](https://reichlab.io/).

- The [German and Polish COVID-19 Forecast Hub](https://github.com/KITmetricslab/covid19-forecast-hub-de) is run by members of the [Karlsruher Institut für Technologie (KIT)](https://statistik.econ.kit.edu/index.ph) and the [Computational Statistics Group at Heidelberg Institute for Theoretical Studies](https://www.h-its.org/research/cst/).

We welcome all forecasters! To contribute, please read through the [wiki](https://github.com/epiforecasts/covid19-forecast-hub-europe/wiki), and get in touch by opening an [Issue](https://github.com/epiforecasts/covid19-forecast-hub-europe/issues).

#### Contents of this repository
- `data-processed`: forecasts in a standardized format
- `data-truth`: truth data from ECDC in a standardized format
- `data-raw`: the forecast files as provided by various teams on their respective websites

## Forecasting European cases and deaths
#### Forecast structure
We require some forecast parameters so that we can use all models to compare and ensemble forecasts. Forecast submissions should use the structure outlined below. For detailed information on structuring and submitting a forecast, see the [technical wiki](https://github.com/epiforecasts/covid19-forecast-hub-europe/wiki).

| Forecast parameter | Description |
| ----------- | ----------- |
| Target | Cases and/or deaths |
| Count | Incident |
| Geography | EU/UK nations |
| Frequency | Weekly |
| Horizon | 1 to *#4* weeks |

We do not accept forecasts of cumulative counts. We also cannot accept forecasts for sub-national regions, daily intervals, or for a horizon beyond *#6* weeks.

#### Targets and truth data
We accept forecasts of incident cases and deaths from Covid-19. We base evaluations on data from the [European Centre for Disease Prevention and Control](https://www.ecdc.europa.eu/en/geographical-distribution-2019-ncov-cases). Details can be found in the respective README files in the subfolders of `data-truth`.

#### Submissions

- Forecasts should be submitted between *# start date* and *# end date*. We also accept updates on other days of the week - *# TBC*.
- Submit a forecast using a pull request. Our wiki contains a detailed [guide to submission](https://github.com/epiforecasts/covid19-forecast-hub-europe/wiki/Preparing-your-submission). If you have technical difficulties with submission, get in touch by raising an [issue](https://github.com/epiforecasts/covid19-forecast-hub-europe/issues).

## Evaluating and ensembling forecasts


## Data license and reuse

- The forecasts assembled in this repository have been created by independent teams. Most provide a license in their respective subfolder of `data-processed`.
- Parts of the processing, analysis and validation code have been taken or adapted from the [US COVID-19 forecast hub](https://github.com/reichlab/covid19-forecast-hub) under an [MIT license](https://github.com/reichlab/covid19-forecast-hub/blob/master/LICENSE).
- All code contained in this repository is under the [MIT license](https://github.com/epiforecasts/covid19-forecast-hub-europe/blob/master/LICENSE). **Please get in touch with us to re-use materials from this repository.**

## Forecasting teams

## European forecast hub team

The following persons have contributed to this repository (in alphabetical order):

- Nikos Bosse
- Sebastian Funk
- Katharine Sherratt

#### Acknowledgements
We are based at the London School of Hygiene and Tropical Medicine and funded by the Wellcome Trust.
