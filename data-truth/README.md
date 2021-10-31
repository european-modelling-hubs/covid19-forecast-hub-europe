European data status
================

#### Potential issues in the JHU dataset

As at 2021-10-31 13:10:52

| country | created    | updated    | issue                                               | message                                             | url                                                      |
| :------ | :--------- | :--------- | :-------------------------------------------------- | :-------------------------------------------------- | :------------------------------------------------------- |
| germany | 2021-10-28 | 2021-10-30 | covid stats incorrect for germany                   | Covid cases for germany for 30 Dec,20 (49,044) and… | <https://github.com/CSSEGISandData/COVID-19/issues/4840> |
| germany | 2021-10-26 | 2021-10-26 | issue in data feed for confirmed cases in germany.  | There is a discrepancy in the confirmed cases data… | <https://github.com/CSSEGISandData/COVID-19/issues/4824> |
| germany | 2021-09-06 | 2021-09-06 | decrease of cumulative cases for germany 2021-09-05 | Hi, there is a decrease of **-1050** cases from 2…  | <https://github.com/CSSEGISandData/COVID-19/issues/4612> |

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
