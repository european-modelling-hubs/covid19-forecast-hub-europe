European data status
================

#### Potential issues in the JHU dataset

As at 2021-08-09 13:12:03

| country | created    | updated    | issue                                               | message                                             | url                                                      |
| :------ | :--------- | :--------- | :-------------------------------------------------- | :-------------------------------------------------- | :------------------------------------------------------- |
| germany | 2021-07-31 | 2021-07-31 | decrease of daily cases for germany 2021-07-29      | There is a difference of **-4910** daily cases in … | <https://github.com/CSSEGISandData/COVID-19/issues/4454> |
| germany | 2021-07-30 | 2021-07-30 | incorrect “new cases” data on july 28th for germany | Huge difference between the stats for 27th July an… | <https://github.com/CSSEGISandData/COVID-19/issues/4451> |
| france  | 2021-05-24 | 2021-06-28 | france negative cases may 20                        | Hello all, Shortly, we will be merging in a PR th…  | <https://github.com/CSSEGISandData/COVID-19/issues/4125> |
| sweden  | 2021-06-21 | 2021-06-21 | sweden pauses reporting due to security breach      | Hello all, The following (translated) message is …  | <https://github.com/CSSEGISandData/COVID-19/issues/4264> |

Open issues updated over the last eight weeks: from [JHU CSSEGISandData
Github](https://github.com/CSSEGISandData/COVID-19/)

## Truth data

We evaluate forecasts of cases and deaths against [Johns Hopkins
University data](https://github.com/CSSEGISandData/COVID-19), and we
recommend using this dataset as the basis for forecasts.

  - Daily numbers of cases and deaths are available to download from
    [JHU](https://github.com/CSSEGISandData/COVID-19/tree/master/csse_covid_19_data/csse_covid_19_time_series),
    or from [our
    repository](https://github.com/epiforecasts/covid19-forecast-hub-europe/data-truth).
  - JHU also provide [country
    metadata](https://github.com/CSSEGISandData/COVID-19/blob/master/csse_covid_19_data/UID_ISO_FIPS_LookUp_Table.csv),
    including population counts and ISO-3 codes.

Note there are some differences between the format of the JHU data and
what we require in a forecast. Please check the
[Wiki](https://github.com/epiforecasts/covid19-forecast-hub-europe/wiki/Targets-and-horizons#truth-data)
for more on forecast formatting.

#### Additional data sources

We do not use or evaluate against these data, but the following might be
useful for modelling targets:

| Data                | Description                                                                                                                              | Source | Link                                                                                                                            |
| ------------------- | ---------------------------------------------------------------------------------------------------------------------------------------- | ------ | ------------------------------------------------------------------------------------------------------------------------------- |
| Vaccination         | Number of vaccine doses distributed by manufacturers, number of first, second and unspecified doses administered                         | ECDC   | [Data on COVID-19 vaccination in the EU/EEA](https://www.ecdc.europa.eu/en/publications-data/data-covid-19-vaccination-eu-eea)  |
| Variants of concern | Volume of COVID-19 sequencing, the number and percentage distribution of VOC for each country, week and variant submitted since 2020-W40 | ECDC   | [Data on SARS-CoV-2 variants in the EU/EEA](https://www.ecdc.europa.eu/en/publications-data/data-virus-variants-covid-19-eueea) |
| Testing             | Weekly testing rate and weekly test positivity                                                                                           | ECDC   | [Data on testing for COVID-19 by week and country](https://www.ecdc.europa.eu/en/publications-data/covid-19-testing)            |
