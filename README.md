
<!-- README.md is generated from README.Rmd. Please edit that file -->

# European COVID-19 Forecast Hub

We are aggregating forecasts of new cases and deaths due to Covid-19
over the next four weeks in countries across Europe and the UK.

##### Latest forecasts

  - View the [current
    forecasts](https://covid19forecasthub.eu/visualisation)
  - We publish a weekly
    [evaluation](https://covid19forecasthub.eu/reports) of current
    forecasts
  - Raw forecast files are in the
    [data-processed](https://github.com/epiforecasts/covid19-forecast-hub-europe/tree/main/data-processed)
    folder

##### README contents

  - [Quick start](#quick-start)
  - [About Covid-19 forecast hubs](#about-covid-19-forecasting-hubs)
      - [European forecast hub team](#european-forecast-hub-team)
      - [Data license and reuse](#data-license-and-reuse)

## Quick start

This is a brief outline for anyone considering contributing a forecast.
For a detailed guide on how to structure and submit a forecast, please
read the [technical wiki](../../wiki).

#### Set up

Before contributing for the first time: - Read the guide for [preparing
to submit](../../wiki/Preparing-to-submit) - Create a [team
directory](../../wiki/Creating-a-team-directory) - Add your
[metadata](../../wiki/Metadata) and a [license](../../wiki/Licensing)

#### Forecasting

We require some forecast parameters so that we can compare and ensemble
forecasts. All forecasts should use the following structure:

| Parameter | Description                           |
| --------- | ------------------------------------- |
| Target    | Cases, hospitalisations and/or deaths |
| Count     | Incident                              |
| Geography | EU/EFTA/UK nations (any/all)          |
| Frequency | Weekly                                |
| Horizon   | 1 to 4 weeks                          |

There is no obligation to submit forecasts for all suggested targets or
horizons, and it is up to you to decide which you are comfortable
forecasting with your model.

We have written more about forecast targets, horizons, and locations in
the [guide](../../wiki/Targets-and-horizons).

###### Dates

We use Epidemiological Weeks (EW) defined by the [US
CDC](https://wwwn.cdc.gov/nndss/document/MMWR_Week_overview.pdf). Each
week starts on Sunday and ends on Saturday. We provide more details
[here](../../wiki/Targets-and-horizons#date-format), and
[templates](../../template) to convert dates to EW weeks (and vice
versa).

###### Truth data

We base evaluations on country level data from [Johns Hopkins
University](https://github.com/CSSEGISandData/COVID-19/tree/master/csse_covid_19_data/csse_covid_19_time_series).

#### Submitting

Forecasts should be submitted on Monday by opening a pull request in
this repository. So that we can evaluate and ensemble forecasts, we ask
for a specific file structure and naming format: our wiki contains a
detailed [guide](../../wiki/Forecast-format). If you have technical
difficulties with submission, try
[troubleshooting](../..wiki/Troubleshooting-pull-requests) or get in
touch by raising an [issue](../issues).

###### Evaluating and ensembling

After teams have submitted their forecasts, we create an ensemble
forecast. Note that the ensemble only includes the forecasts that
completely match the standard format (for example those with all the
specified quantiles). See the [inclusion
criteria](../../wiki/Ensembling-and-evaluation) for more details.

We also publish some weekly evaluation across forecasting models.

## About Covid-19 forecasting hubs

This effort parallels forecasting hubs in the US and Germany. We follow
a similar structure and data format, and re-use software provided by the
ReichLab.

  - The [US COVID-19 Forecast
    Hub](https://github.com/reichlab/covid19-forecast-hub) is run by the
    UMass-Amherst Influenza Forecasting Center of Excellence based at
    the [Reich Lab](https://reichlab.io/).

  - The [German and Polish COVID-19 Forecast
    Hub](https://github.com/KITmetricslab/covid19-forecast-hub-de) is
    run by members of the [Karlsruher Institut für Technologie
    (KIT)](https://statistik.econ.kit.edu/index.ph) and the
    [Computational Statistics Group at Heidelberg Institute for
    Theoretical Studies](https://www.h-its.org/research/cst/).

### European forecast hub team

This repository was created by [Epiforecasts](https://epiforecasts.io),
supported by grant funding from the [European Centre for Disease Control
and Prevention (ECDC)](https://www.ecdc.europa.eu/). It was based on and
supported by members of the US, and German and Polish Forecast Hubs and
is now maintained by the ECDC.

Direct contributors to this repository include (in alphabetical order):

  - Daniel Wolffram
  - Hugo Gruson
  - Jannik Deuschel
  - [Johannes
    Bracher](https://statistik.econ.kit.edu/mitarbeiter_2902.php)
  - Katharine Sherratt
  - Nikos Bosse
  - [Sebastian
    Funk](https://www.lshtm.ac.uk/aboutus/people/funk.sebastian)

The [interactive visualization
tool](https://covid19forecasthub.eu/visualisation/) (code available
[here](https://github.com/SignaleRKI/forecast-europe)) has been
developed by the [Signale Team at Robert Koch
Institute](https://www.rki.de/EN/Content/infections/epidemiology/signals/signals_node.html):
- Fabian Eckelmann - Knut Perseke - Alexander Ullrich

### Data license and reuse

  - The forecasts assembled in this repository have been created by
    independent teams. Most provide a license in their respective
    subfolder of `data-processed`.
  - Parts of the processing, analysis and validation code have been
    taken or adapted from the [US Covid-19 forecast
    hub](https://github.com/reichlab/covid19-forecast-hub) and the
    [Germany/Poland Covid-19 forecast
    hub](https://github.com/KITmetricslab/covid19-forecast-hub-de) both
    under an [MIT
    license](https://github.com/reichlab/covid19-forecast-hub/blob/master/LICENSE).
  - All code contained in this repository is under the [MIT
    license](/LICENSE). **Please get in touch with us to re-use
    materials from this repository.**

To cite the European Covid-19 Forecast Hub in project in publications,
please use the following references:

Methodology and evaluation:

> Sherratt, K., Gruson, H., Johnson, H., Niehus, R., Prasse, B.,
> Sandman, F., … & Funk, S. (2022). Predictive performance of
> multi-model ensemble forecasts of COVID-19 across European nations.
> *medRxiv*. DOI: <https://doi.org/10.1101/2022.06.16.22276024>

Data:

> Katharine Sherratt, Hugo Gruson, Helen Johnson, Rene Niehus, Bastian
> Prasse, Frank Sandman, Jannik Deuschel, Daniel Wolffram, Sam Abbott,
> Alexander Ullrich, Graham Gibson, Evan L Ray, Nicholas G Reich, Daniel
> Sheldon, Yijin Wang, Nutcha Wattanachit, Lijing Wang, Jan Trnka,
> Guillaume Obozinski, … Sebastian Funk. (2023). European Covid-19
> Forecast Hub (v2023.09.14) \[Data set\]. Zenodo.
> <https://doi.org/10.5281/zenodo.8344631>

<details>

<summary>Bibtex</summary>

``` bibtex
@dataset{katharine_sherratt_2023_8344631,
  author       = {Katharine Sherratt and
                  Hugo Gruson and
                  Helen Johnson and
                  Rene Niehus and
                  Bastian Prasse and
                  Frank Sandman and
                  Jannik Deuschel and
                  Daniel Wolffram and
                  Sam Abbott and
                  Alexander Ullrich and
                  Graham Gibson and
                  Evan L Ray and
                  Nicholas G Reich and
                  Daniel Sheldon and
                  Yijin Wang and
                  Nutcha Wattanachit and
                  Lijing Wang and
                  Jan Trnka and
                  Guillaume Obozinski and
                  Tao Sun and
                  Dorina Thanou and
                  Loic Pottier and
                  Ekaterina Krymova and
                  Maria Vittoria Barbarossa and
                  Neele Leithauser and
                  Jan Mohring and
                  Johanna Schneider and
                  Jaroslaw Wlazlo and
                  Jan Fuhrmann and
                  Berit Lange and
                  Isti Rodiah and
                  Prasith Baccam and
                  Heidi Gurung and
                  Steven Stage and
                  Bradley Suchoski and
                  Jozef Budzinski and
                  Robert Walraven and
                  Inmaculada Villanueva and
                  Vit Tucek and
                  Martin Smid and
                  Milan Zajicek and
                  Cesar Perez Alvarez and
                  Borja Reina and
                  Nikos I Bosse and
                  Sophie Meakin and
                  Pierfrancesco Alaimo Di Loro and
                  Antonello Maruotti and
                  Veronika Eclerova and
                  Andrea Kraus and
                  David Kraus and
                  Lenka Pribylova and
                  Bertsimas Dimitris and
                  Michael Lingzhi Li and
                  Soni Saksham and
                  Jonas Dehning and
                  Sebastian Mohr and
                  Viola Priesemann and
                  Grzegorz Redlarski and
                  Benjamin Bejar and
                  Giovanni Ardenghi and
                  Nicola Parolini and
                  Giovanni Ziarelli and
                  Wolfgang Bock and
                  Stefan Heyder and
                  Thomas Hotz and
                  David E Singh and
                  Miguel Guzman-Merino and
                  Jose L Aznarte and
                  David Morina and
                  Sergio Alonso and
                  Enric Alvarez and
                  Daniel Lopez and
                  Clara Prats and
                  Jan Pablo Burgard and
                  Arne Rodloff and
                  Tom Zimmermann and
                  Alexander Kuhlmann and
                  Janez Zibert and
                  Fulvia Pennoni and
                  Fabio Divino and
                  Marti Catala and
                  Gianfranco Lovison and
                  Paolo Giudici and
                  Barbara Tarantino and
                  Francesco Bartolucci and
                  Giovanna Jona Lasinio and
                  Marco Mingione and
                  Alessio Farcomeni and
                  Ajitesh Srivastava and
                  Pablo Montero-Manso and
                  Aniruddha Adiga and
                  Benjamin Hurt and
                  Bryan Lewis and
                  Madhav Marathe and
                  Przemyslaw Porebski and
                  Srinivasan Venkatramanan and
                  Rafal Bartczuk and
                  Filip Dreger and
                  Anna Gambin and
                  Krzysztof Gogolewski and
                  Magdalena Gruziel-Slomka and
                  Bartosz Krupa and
                  Antoni Moszynski and
                  Karol Niedzielewski and
                  Jedrzej Nowosielski and
                  Maciej Radwan and
                  Franciszek Rakowski and
                  Marcin Semeniuk and
                  Ewa Szczurek and
                  Jakub Zielinski and
                  Jan Kisielewski and
                  Barbara Pabjan and
                  Kirsten Holger and
                  Yuri Kheifetz and
                  Markus Scholz and
                  Marcin Bodych and
                  Maciej Filinski and
                  Radoslaw Idzikowski and
                  Tyll Krueger and
                  Tomasz Ozanski and
                  Johannes Bracher and
                  Sebastian Funk},
  title        = {European Covid-19 Forecast Hub},
  month        = sep,
  year         = 2023,
  publisher    = {Zenodo},
  version      = {v2023.09.14},
  doi          = {10.5281/zenodo.8344631},
  url          = {https://doi.org/10.5281/zenodo.8344631}
}
```

</details>
