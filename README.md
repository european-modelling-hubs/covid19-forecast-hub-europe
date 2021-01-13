![Actions Status](https://github.com/KITmetricslab/covid19-forecast-hub-de/workflows/RKI-data/badge.svg)
![Actions Status](https://github.com/KITmetricslab/covid19-forecast-hub-de/workflows/ECDC-JHU-DIVI/badge.svg)
![Actions Status](https://github.com/KITmetricslab/covid19-forecast-hub-de/workflows/MZ/badge.svg)
![Actions Status](https://github.com/KITmetricslab/covid19-forecast-hub-de/workflows/Visualization/Validation/Evaluation/badge.svg)
![Actions Status](https://github.com/KITmetricslab/covid19-forecast-hub-de/workflows/Geneva/badge.svg)
![Actions Status](https://github.com/KITmetricslab/covid19-forecast-hub-de/workflows/UCLA/badge.svg)
![Actions Status](https://github.com/KITmetricslab/covid19-forecast-hub-de/workflows/LANL/badge.svg)
![Actions Status](https://github.com/KITmetricslab/covid19-forecast-hub-de/workflows/epiforecasts/badge.svg)


# German and Polish COVID-19 Forecast Hub

#### A collaborative forecasting project

*Beschreibung in deutscher Sprache siehe [hier](https://github.com/KITmetricslab/covid19-forecast-hub-de/blob/master/README_DE.md).*

**Website:**: https://kitmetricslab.github.io/forecasthub/

**Old version of visualization incl. evaluation scores:** https://jobrac.shinyapps.io/app_forecasts_de/

**Study protocol:**: https://osf.io/cy937/registrations

**Reference:** Bracher J, Wolffram D, Deuschel, J, Görgen, K, Ketterer, J, Gneiting, T, Schienle, M (2020): *The German and Polish COVID-19 Forecast Hub.* https://github.com/KITmetricslab/covid19-forecast-hub-de.

**Web tool to visualize submission files:** https://jobrac.shinyapps.io/app_check_submission/

**Web tool to explore forecast evaluations (still in development):** https://jobrac.shinyapps.io/app_evaluation/

**Contact**: forecasthub@econ.kit.edu

## Purpose

This repository assembles forecasts of cumulative and incident COVID-19 deaths and cases in Germany and Poland in a standardized format. The repository is run by members of the [Chair of Econometrics and Statistics at Karlsruhe Institute of Technology](https://statistik.econ.kit.edu/index.php) and the [Computational Statistics Group at Heidelberg Institute for Theoretical Studies](https://www.h-its.org/research/cst/), see [below](#forecast-hub-team).

An **interactive visualization** and additional information on our project can be found on our website [here](https://kitmetricslab.github.io/forecasthub/).

We are running a **pre-registered evaluation study** covering the months of October through March to assess the performance of different forecasting methods. You can find the protocol [here](https://osf.io/cy937/registrations).

![static visualization of current forecasts](code/visualization/current_forecasts.png?raw=true)

The effort parallels the [US COVID-19 Forecast Hub](https://github.com/reichlab/covid19-forecast-hub) run by the UMass-Amherst Influenza Forecasting Center of Excellence based at the [Reich Lab](https://reichlab.io/). We are in close exchange with the Reich Lab team and follow the general structure and [data format](https://github.com/reichlab/covid19-forecast-hub/blob/master/data-processed/README.md) defined there, see this [wiki entry](https://github.com/KITmetricslab/covid19-forecast-hub-de/wiki/Forecast-Data-Format) for more details. We also re-use software provided by the ReichLab (see [below](#data-license-and-reuse)).

If you are generating forecasts for COVID-19 cases, hospitalizations or deaths in Germany and would like to contribute to this repository do not hesitate to [get in touch](https://kitmetricslab.github.io/forecasthub/about).

## Forecast targets

### Deaths

We collect **1 through 30 day and 1 through 4 week ahead forecasts of incident and cumulative deaths by reporting date in Germany and Poland (national level), the German states (Bundesländer) and Polish voivodeships, with a special focus on short horizons 1 and 2 week ahead.** This [wiki entry](https://github.com/KITmetricslab/covid19-forecast-hub-de/wiki/Forecast-targets) contains details on the definition of the targets. There is no obligation to submit forecasts for all suggested targets and it is up to teams to decide what they feel comfortable forecasting.

Our definition of targets parallels the principles outlined [here](https://github.com/reichlab/covid19-forecast-hub#what-forecasts-we-are-tracking-and-for-which-locations) for the US COVID-19 Forecast Hub.

Up to 14 December we treated the **ECDC data** available [here](https://www.ecdc.europa.eu/en/publications-data/download-todays-data-geographic-distribution-covid-19-cases-worldwide) and [here](https://github.com/KITmetricslab/covid19-forecast-hub-de/tree/master/data-truth/ECDC) in a processed form as our ground truth for the national level death forecasts. As of 19 December, we use data we process directly from Robert Koch Institute and the Polish Ministry of Health see [below](#truth-data). These agree with the ECDC data up to 14 Dec.

### Cases

We collect **1 through 4 week ahead and 1 through 30 day forecasts of incident and cumulative confirmed cases by reporting date in Germany and Poland (national level), German states (Bundesländer) and Polish voivodeships**, see the [wiki entry](https://github.com/KITmetricslab/covid19-forecast-hub-de/wiki/Forecast-targets). The respective truth data from RKI and the Polish Ministry of Health can be found [here](https://github.com/KITmetricslab/covid19-forecast-hub-de/tree/master/data-truth/RKI) and [here](https://github.com/KITmetricslab/covid19-forecast-hub-de/tree/master/data-truth/MZ).

<!---
### Intensive care use
We intend to start covering forecasts for intensive care use due to COVID19 (at the German national and Bundesland levels). Details will be provided here soon. # Data from the [DIVI Registry](https://www.divi.de/) have been compiled [here](https://github.com/KITmetricslab/covid19-forecast-hub-de/tree/master/data-# truth/DIVI) and may be used to define prediction targets.
-->


<!---
Note that unlike the US hub we also allow for `-1 wk ahead <target>`, `0 wk ahead <target>`, `-1 day ahead <target>` and `0 day ahead <target>` which, if they have already been observed (this may or may not be the case for 0 wk ahead) are assigned `type = "observed"`. We decided to include this as there is more heterogeneity concerning the ground truths used by different teams. By also storing the last observed values as provided by teams it becomes easier to spot such differences.
-->

## Contents of the repository

The main contents of the repository are currently the following (see also [this](https://github.com/KITmetricslab/covid19-forecast-hub-de/wiki/Structure-of-the-repository) wiki page):

- `data-processed`: forecasts in a standardized format
- `data-truth`: truth data from JHU and ECDC in a standardized format
- `data-raw`: the forecast files as provided by various teams on their respective websites
- The [interactive visualization](https://kitmetricslab.github.io/forecasthub), which has been implemented by embers of the Signale Team at RKI, is maintained in a [separate repository](https://github.com/KITmetricslab/forecasthub/).

## Guide to submission

Submission for actively contributing teams is based on pull requests. Our wiki contains a detailed [guide to submission](https://github.com/KITmetricslab/covid19-forecast-hub-de/wiki/Preparing-your-submission). **Forecasts should be updated in a weekly rhythm. If possible, new forecast should be uploaded on Mondays.** Upload until Tuesday, 3pm Berlin/Warsaw time is acceptable. Note that we also accept additional updates on other days of the week (not more than one per day), but will not include these in visualizations or ensembles (if no new forecast was provided on a Monday we will, however, use forecasts from the preceding Sunday, Saturday or Friday).

We moreover actively collect forecasts from a number of public repositories in accordance with the respective license terms and after having contacted the respective authors.

We strongly encourage teams to visually inspect their final forecasts prior to submission. We created a [Shiny app](https://jobrac.shinyapps.io/app_check_submission/) to help you in this process.

We try to provide direct support to new teams to help overcome technical difficulties, do not hesitate to [get in touch](forecasthub@econ.kit.edu).


## Data format

We store point and quantile forecasts in a long format, including information on forecast dates and location, see [this wiki entry](https://github.com/KITmetricslab/covid19-forecast-hub-de/wiki/Forecast-Data-Format) for details. This format is largely identical to the one outlined for the US Hub [here](https://github.com/reichlab/covid19-forecast-hub/tree/master/data-processed#data-submission-instructions).

## Data license and reuse

The forecasts assembled in this repository have been created by various independent teams, most of which provided a license with their forecasts. These licenses can be found in the respective subfolders of `data-processed`. Parts of the processing, analysis and validation codes have been taken or adapted from the [US COVID-19 forecast hub](https://github.com/reichlab/covid19-forecast-hub) where they were provided under an [MIT license](https://github.com/reichlab/covid19-forecast-hub/blob/master/LICENSE). All codes contained in this repository are equally under the [MIT license](https://github.com/KITmetricslab/covid19-forecast-hub-de/blob/master/LICENSE). **If you want to re-use materials from this repository please [get in touch](forecasthub@econ.kit.edu) with us.**

## Truth data

Data on observed numbers of deaths and several other quantities are compiled [here](https://github.com/KITmetricslab/covid19-forecast-hub-de/tree/master/data-truth) and come from the following sources:

- [European Centre for Disease Prevention and Control](https://www.ecdc.europa.eu/en/geographical-distribution-2019-ncov-cases) **This used to be our preferred source for national level counts, but ECDC has switched to weekly reporting intervals on 14 Dec 2020.**
- [Polish Ministry of Health](https://www.gov.pl/web/zdrowie). We pull these data from [this Google Sheet](https://docs.google.com/spreadsheets/u/2/d/1ierEhD6gcq51HAm433knjnVwey4ZE5DCnu1bW7PRG3E/htmlview?usp=gmail_thread#) run by [Michal Rogalski](https://twitter.com/micalrg). **This is our preferred source for Polish voivodeship level counts.** The data are coherent with the national level data from ECDC. **These data are coherent with the ECDC data up to 14 Dec. To align with the ECDC time scale we have shifted them by one day, see [here](https://github.com/KITmetricslab/covid19-forecast-hub-de/tree/master/data-truth/MZ).**
- [Robert Koch Institut](https://npgeo-corona-npgeo-de.hub.arcgis.com/datasets/dd4580c810204019a7b8eb3e0b329dd6_0). Note that these data are subject to some processing steps (see [here](data-truth/RKI)) and are in part based on manual data extraction performed by [IHME](https://covid19.healthdata.org/united-states-of-america). **This is our preferred source for German Bundesland level counts. The data are coherent with the national level data from ECDC up to 14 Dec.**
- [Johns Hopkins University](https://coronavirus.jhu.edu/). These data are used by a number of teams generating forecasts. Currently (August 2020) the agreement with ECDC is good, but in the past there have been larger discrepancies.
- [DIVI Intensivregister.](https://www.divi.de/register/tagesreport) These data are currently not yet used for forecasts, but we may extend our activities in this direction.

Details can be found in the respective README files in the subfolders of `data-truth`.

## Teams generating forecasts

Currently we assemble forecasts from the following teams. *Note that not all teams are using the same ground truth data.* (used truth data source and forecast reuse license in brackets):

- [epiforecasts.io / London School of Hygiene and Tropical Medicine](https://github.com/epiforecasts/covid-german-forecasts) (ECDC; MIT)
- [Frankfurt Institute for Advanced Studies & Forschungszentrum Jülich](https://www.medrxiv.org/content/10.1101/2020.04.18.20069955v1) (ECDC; no license specified)
- [ICM / University of Warsaw](https://icm.edu.pl/en/) (ECDC; to be specified)
- [IHME](https://covid19.healthdata.org/united-states-of-america) (JHU; CC-AT-NC4.0)
- [Imperial College](https://github.com/mrc-ide/covid19-forecasts-orderly) (ECDC; Creative Commons Attribution-NonCommercial-NoDerivatives 4.0 International License)
- [Johannes Gutenberg University Mainz / University of Hamburg](https://github.com/QEDHamburg/covid19) (ECDC; MIT)
- [KIT](https://github.com/KITmetricslab/KIT-baseline) (ECDC; MIT) *These are two simple baseline models run by the Forecast Hub Team. Part of these forecasts were created retrospectively, but using only data available at the respective forecast date. The commit dates of all forecasts can be found [here](https://github.com/KITmetricslab/covid19-forecast-hub-de/blob/master/code/validation/commit_dates.csv).*
- [Karlen working group](Karlen working group) (ECDC; to be specified)
- [KITCOVIDhub] The `mean_ensemble` and `median_ensemble` are two different aggregations of all submitted and eligible forecasts, see [here](https://github.com/KITmetricslab/covid19-forecast-hub-de/wiki/Creation-of-equally-weighted-ensemble). While the median ensemble is our pre-specified main ensemble, we also monitor performance of the mean ensemble.
- [LANL](https://covid-19.bsvgateway.org/) (JHU; custom)
- [MIM / University of Warsaw](https://www.mimuw.edu.pl/en/faculty) (ECDC; to be specified)
- [MIT Covid Analytics](https://www.covidanalytics.io/) (JHU; Apache 2.0)
- [MOCOS Group](https://mocos.pl/) (ECDC; to be specified)
- ITTW (Universities of Ilmenau, Trier, Wroclaw, Warsaw) (ECDC; no license specified)
- [University of Geneva / Swiss Data Science Center](https://renkulab.shinyapps.io/COVID-19-Epidemic-Forecasting/) (ECDC; none given)
- [University of Leipzig IMISE/GenStat](https://github.com/holgerman/covid19-forecast-hub-de) (ECDC; MIT)
- [UCLA Statistical Machine Learning Lab](https://covid19.uclaml.org/) (JHU; cc-by-4.0)
- [University of Southern California Data Science Lab](https://scc-usc.github.io/ReCOVER-COVID-19)(JHU; MIT) (MIT)
- [YYG](http://covid19-projections.com/) (JHU; MIT)

## Forecast evaluation and ensemble building

One of the goals of this forecast hub is to combine the available forecasts into an ensemble prediction, see [here](https://github.com/KITmetricslab/covid19-forecast-hub-de/wiki/Creation-of-equally-weighted-ensemble) for a description of the current unweighted ensemble approach. *Note that we only started generating ensemble forecasts each week on 17 August 2020. Ensemble forecasts from earlier weeks have been generated retrospectively to assess performance. As the ensemble is only a simple average of other models this should not affect the behaviour of the ensemble forecasts. The commit dates of all forecasts can be found [here](https://github.com/KITmetricslab/covid19-forecast-hub-de/blob/master/code/validation/commit_dates.csv). Starting from 2020-09-21, our main ensemble is the median rather than the mean ensemble, as the former showed better performance in evaluations.*


At a later stage we intend to generate more data-driven ensembles, which requires evaluating different forecasts, both those submitted by teams and those generated using different ensembling techniques. **We want to emphasize, however, that this is not a competition, but a collaborative effort.** The forecast evaluation method which will be applied is described in [this preprint](https://arxiv.org/abs/2005.12881).

## Forecast hub team

The following persons have contributed to this repository, either by assembling forecasts or by conceptual work in the background (in alphabetical order):

- [Johannes Bracher](https://statistik.econ.kit.edu/mitarbeiter_2902.php)
- Jannik Deuschel
- [Tilmann Gneiting](https://www.h-its.org/2018/01/08/tilmann-gneiting/)
- [Konstantin Görgen](https://statistik.econ.kit.edu/mitarbeiter_2716.php)
- Jakob Ketterer
- [Melanie Schienle](https://statistik.econ.kit.edu/mitarbeiter_2068.php)
- Daniel Wolffram

## Related efforts

- [US COVID-19 Forecast Hub](https://github.com/reichlab/covid19-forecast-hub) run by the [Reich Lab](https://reichlab.io/).
- [Code repository for the SARS-CoV2 modelling initiative](https://github.com/timueh/sars-cov2-modelling-initiative)

## Scientific papers and preprints

Members of our group have contributed to the following papers and preprints on collaborative COVID-19 forecasting:

- J. Bracher, E.L. Ray, T. Gneiting, N.G. Reich: [Evaluating epidemic forecasts in an interval format](https://arxiv.org/abs/2005.12881).
- L.C. Brooks, E.L. Ray, J. Bien, J. Bracher, A. Rumack, R.J. Tibshirani, N.G. Reich: [Comparing ensemble approaches for short-term probabilistic COVID-19 forecasts in the U.S.](https://forecasters.org/blog/2020/10/28/comparing-ensemble-approaches-for-short-term-probabilistic-covid-19-forecasts-in-the-u-s/)
- E.L. Ray, N. Wattanachit, J. Niemi et al: [Ensemble Forecasts of Coronavirus Disease 2019 (COVID-19) in the U.S.](https://www.medrxiv.org/content/10.1101/2020.08.19.20177493v1).


## Acknowledgements

The Forecast Hub project is part of the [SIMCARD Information& Data Science Pilot Project](https://www.helmholtz.de/forschung/information-data-science/information-data-science-pilot-projekte/pilotprojekte-2/) funded by the Helmholtz Association. We moreover wish to acknowledge the [Alexander von Humboldt Foundation](http://www.humboldt-foundation.de/web/start.html) whose support facilitated early interactions and collaboration with the [Reich Lab](https://reichlab.io/) and the [US COVID-19 Forecast Hub](https://github.com/reichlab/covid19-forecast-hub).

**The content of this site is solely the responsibility of the authors and does not necessarily represent the official views of KIT, HITS, the Humboldt Foundation or the Helmholtz Association.**
