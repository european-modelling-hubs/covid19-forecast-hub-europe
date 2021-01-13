# German COVID-19 Forecast Hub - Zusammenstellung von Vorhersagen für COVID-19 Todesfälle in Deutschland

*Description in English available [here](https://github.com/KITmetricslab/covid19-forecast-hub-de/).*

**Website:**: https://kitmetricslab.github.io/forecasthub/

**Studienprotokoll:**: https://osf.io/cy937/registrations

**Referenz:** Bracher J, Wolffram D, Deuschel, J, Görgen, K, Ketterer, J, Gneiting, T, Schienle, M (2020): *The German and Polish COVID-19 Forecast Hub.* https://github.com/KITmetricslab/covid19-forecast-hub-de.

**Web tool zur Visualisierung von Vorhersage-Dateien vor der Einreichung:** https://jobrac.shinyapps.io/app_check_submission/

**Kontakt**: forecasthub@econ.kit.edu

## Zweck

Dieses Repository dient dazu, Vorhersagen für kumulative und inzidente COVID-19-Todeszahlen in einem standardisierten Format zusammenzutragen. Es wird von Mitgliedern des [Lehrstuhl für Ökonometrie und Statistik am Karslruher Institut für Technologie](https://statistik.econ.kit.edu/index.php) und der [Computational Statistics Gruppe am Heidelberger Institut für Theoretische Studien](https://www.h-its.org/research/cst/) betrieben, siehe Auflistung unten.

Eine **interaktive Visualisierung** der verschiedenen Vorhersagen und weitere Informationen (auf English) sind [auf unserer Webseite](https://kitmetricslab.github.io/forecasthub/) verfügbar.

Wir führe eine **präregistrierte Evaluationsstudie** durch, in der wir die Vorhersagequalität verschiedener Modelle in den Monaten Oktober 2020 bis März 2021 untersuchen, siehe [hier](https://osf.io/cy937/registrations) für das Studienprotokoll.

Dieses Projekt ist vom [US COVID-19 Forecast Hub](https://github.com/reichlab/covid19-forecast-hub) inspiriert, der vom [Reich Lab](https://reichlab.io/) / UMass-Amherst Influenza Forecasting Center of Excellence betrieben wird. Wir stehen in engem Austausch mit dem Reich Lab und übernehmen weitgehend die dort festgelegten Strukturen und [Datenformate](https://github.com/reichlab/covid19-forecast-hub#data-model), siehe auch diesen [Wiki-Eintrag](https://github.com/KITmetricslab/covid19-forecast-hub-de/wiki/Data-Format) (auf englisch). Ausserdem verwenden wir vom ReichLab zur Verfügung gestellte Software (siehe [unten](#lizenz-und-weiterverwendung-der-vorhersagedaten)).

Falls Sie an Vorhersagen für COVID-19-Todesfälle in Deutschland arbeiten und gerne zu diesem Repository beitragen möchten treten Sie bitte mit uns in [Kontakt](https://statistik.econ.kit.edu/mitarbeiter_2902.php)

## Vorhersageziele

### Todeszahlen

Unser Hauptfokus liegt auf **1 bis 30 Tages und 1 bis 4 Wochen-Vorhersagen für inzidente und kumulative Todeszahlen**. Wir akzeptieren auch Vorhersagen bis zu 130 Tage oder 20 Wochen voraus. Dieser [Wiki-Eintrag](https://github.com/KITmetricslab/covid19-forecast-hub-de/wiki/Forecast-targets) (auf englisch) beinhaltet eine genauere Beschreibung der Vorhersageziele. Es gibt keine Verpflichtung, Vorhersagen für alle genannten Ziele abzugeben und es bleibt den einzelnen Gruppen überlassen, einzuschätzen, für welche Ziele ihr Modell sinnvolle Vorhersagen generieren kann.

Die Definition unserer Vorhersageziele folgt den [hier](https://github.com/reichlab/covid19-forecast-hub#what-forecasts-we-are-tracking-and-for-which-locations) für den US COVID-19 forecast hub beschriebenen Prinzipien.

Derzeit betrachten wir die [ECDC Daten](https://www.ecdc.europa.eu/en/publications-data/download-todays-data-geographic-distribution-covid-19-cases-worldwide) als die zugrundeliegende und vorherzusagende ``Wahrheit'' (*ground truth*).  Für Todeszahlen in den Bundesländern und polnischen Woiwodschaften verwenden wir Daten des Robert Koch Instituts bzw. des polnischen Gedundheitsministeriums, siehe Abschnitt [Wahrheitsdaten](#wahrheitsdaten).

### Fälle

Wir akzeptieren ausserdem **1 bis 30 Tages und 1 bis 4 Wochen-Vorhersagen für inzidente und kumulative Fallzahlen**, siehe auch Beschreibung [hier](https://github.com/KITmetricslab/covid19-forecast-hub-de/wiki/Forecast-targets).

### Intensivmedizinische Versorgung

Wir erwägen, demnächst auch Vorhersagen für den Bedarf an intensivmedizinischer Versorgung aufgrund von COVID19-Erkrankungen abzudecken. Daten aus dem [DIVI Register](https://www.divi.de/) könnten als Gundlage für die Definition von Vorhersagezielen dienen.


Die Definition unserer Vorhersageziele folgt den [hier](https://github.com/reichlab/covid19-forecast-hub#what-forecasts-we-are-tracking-and-for-which-locations) für den US COVID-19 forecast hub beschriebenen Prinzipien.

## Inhalt des Repositories

Die Hauptinhalte des Repositories sind gegenwärtig die Folgenden:

- `data-raw`: Vorhersagedateien in ihrer ursprünglichen Form, d.h. so, wie sie von den verschiedenen Teams zur Verfügung gestellt wurden.
- `data-processed`: Vorhersagen im Standardformat.
- `data-truth`: ECDC- und JHU-Daten zu COVID19 Todesfällen in einem standardisierten Format


## Anleitung zur Einreichung von Vorhersagen

Die Einreichung von Vorhersagen erfolgt via Pull Requests. In unserem Wiki stellen wir eine ausführliche [Anleitung zur Einreichung](https://github.com/KITmetricslab/covid19-forecast-hub-de/wiki/Preparing-your-submission) zur Verfügung. **Vorhersagen sollten in wöchentlichen Abständen aktualisiert werden, wenn möglich jeden Montag.** Als Frist haben wir Dienstag 15:00 gewählt. Neue Vorhersagen können auch an anderen Wochentagen abgegeben werden (nicht mehr als eine pro Tag), diese werden jedoch nicht in Visualisierungen oder Ensembles verwendet (Ausnahme: Falls an einem Montag keine Vorhersage abgegeben wurde verwenden wir Vorhersagen, die am vorangegangenen Sonntag, Samstag oder Freitag abgegeben wurden).

Wir sind bemüht, teilnehmenden Gruppen technische Unterstützung bei der Einreichung anzubieten. Treten Sie hierzu gerne mit uns in [Kontakt](forecasthub@kit.edu).

## Speicherformat für Vorhersagen

Wir speichern Punktvorhersagen und Vorhersagequantile in einem Langformat mit Informationen zu Datum und Ort, siehe [hier](https://github.com/KITmetricslab/covid19-forecast-hub-de/wiki/Data-Format). Dieses Format ist weithgehend identisch zu dem im US Hub verendeten Format (siehe [hier](https://github.com/reichlab/covid19-forecast-hub#data-model) and [hier](https://github.com/reichlab/covid19-forecast-hub/tree/master/data-processed#data-submission-instructions)).


## Lizenz und Weiterverwendung der Vorhersagedaten

Die in diesem Repository zusammengetragenen Vorhersagen sind von verschiedenen unabhängigen Teams erstellt worden, in den meisten Fällen zusammen mit einer Lizenz zur Weiterverwendung. Diese Lizenzen sind in den entsprechenden Unterordnern von `data-processed` enthalten. Teile der Processing- und Analyse-Codes sind angepasste Versionen von Codes aus dem [US COVID-19 Forecast Hub](COVID-19 Forecast Hub) (dort unter [MIT Lizenz](https://github.com/reichlab/covid19-forecast-hub/blob/master/LICENSE)). Alle hier bereitgestellten Codes stehen ebenfalls unter der [MIT license](https://github.com/KITmetricslab/covid19-forecast-hub-de/blob/master/LICENSE). **Falls Sie Daten aus diesem Repository weiterverwenden möchten treten Sie bitte mit uns in [Kontakt](forecasthub@kit.edu).**

## Wahrheitsdaten

Daten zu den beobachteten Todeszahlen beziehen wir aus den folgenden Quellen:

- [European Centre for Disease Prevention and Control](https://www.ecdc.europa.eu/en/geographical-distribution-2019-ncov-cases) **(Dies ist unsere bevorzugte Quelle und wird bei der Evaluierung zugrundegelegt.)**
- [Johns Hopkins University](https://coronavirus.jhu.edu/)
- [European Centre for Disease Prevention and Control](https://www.ecdc.europa.eu/en/geographical-distribution-2019-ncov-cases) **Dies ist unsere bevorzugte Quelle und wird bei der Evaluierung zugrundegelegt.**
 [Polnisches Gesundheitsministerium](https://www.gov.pl/web/zdrowie). Wir beziehen diese Daten aus einem öffentlichen [Google Sheet](bit.ly/covid19-poland), das von [Michal Rogalski](https://twitter.com/micalrg) betrieben wird. **Dies ist unsere bevorzugte Quelle für Daten auf der Bundesland-Ebene. Die Daten sind kompatibel mit den ECDC-Daten auf der Bundesebene. Um die Daten mit den Daten ECDC-Daten auf der nationalen Ebene kompatibel zu machen werden sie um einen Tag verschoben, seiehe [hier](https://github.com/KITmetricslab/covid19-forecast-hub-de/tree/master/data-truth/MZ).**
- [Robert Koch Institut](https://npgeo-corona-npgeo-de.hub.arcgis.com/datasets/dd4580c810204019a7b8eb3e0b329dd6_0). Die Generierung dieser Datensätze erfordert einige Pre-Processing-Schritte, siehe [hier](data-truth/RKI). **Dies ist unsere bevorzugte Quelle für Daten auf der Bundesland-Ebene. Die Daten sind kompatibel mit den ECDC-Daten auf der Bundesebene.**
- [Johns Hopkins University](https://coronavirus.jhu.edu/). Diese Daten werden von einer Reihe von Teams zur Generierung von Vorhersagen genutzt. Derzeit (August 2020) ist die Übereinstimmung mit den ECDC-DAten gut, in der Vergangenheit gab es allerdings stärkere Diskrepanzen.
- [DIVI Intensivregister](https://www.divi.de/register/tagesreport) Diese Daten werden derzeit nicht genutzt, wir planen jedoch, künftig auch Vorhersagen basierend auf diesen Daten zusammenzutragen.


## Teams, die Vorhersagen bereitstellen

Derzeit tragen wir Vorhersagen der folgenden Teams zusammen. *Bitte beachten Sie, dass nicht alle Teams ihre Vorhersagen aufgrund der selben Datengrundlage zu Todeszahlen erstellen.* (benutzte Datengrundlage und Lizenz in Klammern).

- [epiforecasts.io / London School of Hygiene and Tropical Medicine](https://epiforecasts.io/) (ECDC; no license specified)
- [Frankfurt Institute for Advanced Studies & Forschungszentrum Jülich](https://www.medrxiv.org/content/10.1101/2020.04.18.20069955v1) (ECDC; no license specified)
- [ICM / University of Warsaw](https://icm.edu.pl/en/) (ECDC; to be specified)
- [IHME](https://covid19.healthdata.org/united-states-of-america) (JHU; CC-AT-NC4.0)
- [Imperial College](https://github.com/mrc-ide/covid19-forecasts-orderly) (ECDC; Creative Commons Attribution-NonCommercial-NoDerivatives 4.0 International License)
- [Johannes Gutenberg University Mainz / University of Hamburg](https://github.com/QEDHamburg/covid19) (ECDC; MIT)
- [KIT](https://github.com/KITmetricslab/KIT-baseline) (ECDC; MIT) *Die sind zwei einfache Referenzmodelle.*
- [KITCOVIDhub] Das `mean_ensemble` und `median_ensemble` sind zwei verschiedene Aggregationen der verfügbaren Vorhersagen, siehe [hier](https://github.com/KITmetricslab/covid19-forecast-hub-de/wiki/Creation-of-equally-weighted-ensemble). Das Median-Ensemble ist unser präspezifiziertes Haupt-Ensemble.
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

## Vorhersageevaluation und Ensembles

Eines der Ziele des Forecast Hubs ist es, verschiedene Vorhersagen in einer Ensemble-Vorhersage zusammenzuführen, siehe [hier](https://github.com/KITmetricslab/covid19-forecast-hub-de/wiki/Creation-of-equally-weighted-ensemble) für eine kurze Beschreibung des derzeit verwendeten Ansatzes ohne Gewichtung. Aufwändigere datengetriebene Verfahren setzen voraus, dass verschiedene Vorhersagen, sowohl Ensemble-Vorhersagen als auch Vorhersagen einzelner Teams evaluiert und verglichen werden. **Wir möchten jedoch betonen, dass es sich hierbei nicht um einen Wettbewerb, sondern um ein kollaboratives Projekt handelt.** Die Methoden zur Vorhersageevaluation die Anwendung finden werden sind [hier](https://arxiv.org/abs/2005.12881) beschrieben.


## Forecast hub team

Die folgenden Personen haben zu diesem Projekt beigetragen, entweder durch praktische Arbeit am Repository oder konzeptionelle Arbeit im Hintergrund (in alphabetischer Reihenfolge):

- [Johannes Bracher](https://statistik.econ.kit.edu/mitarbeiter_2902.php)
- Jannik Deuschel
- [Tilmann Gneiting](https://www.h-its.org/2018/01/08/tilmann-gneiting/)
- [Konstantin Görgen](https://statistik.econ.kit.edu/mitarbeiter_2716.php)
- Jakob Ketterer
- [Melanie Schienle](https://statistik.econ.kit.edu/mitarbeiter_2068.php)
- Daniel Wolffram

## Verwandte Projekte

- [US COVID-19 Forecast Hub](https://github.com/reichlab/covid19-forecast-hub), betrieben vom [Reich Lab](https://reichlab.io/) (Preprint [hier](https://www.medrxiv.org/content/10.1101/2020.08.19.20177493v1) verfügbar).
- [Code repository der SARS-CoV2 modelling initiative](https://github.com/timueh/sars-cov2-modelling-initiative)

## Wissenschaftliche Publikationen und Preprints

Mitglieder unserer Gruppe haben zu den folgenden Veröffentlichungen oder Preprints im Zusammenhang mit der Vorhersage der COVID-19 Pandemie beigetragen:

- J. Bracher, E.L. Ray, T. Gneiting, N.G. Reich: [Evaluating epidemic forecasts in an interval format](https://arxiv.org/abs/2005.12881).
- L.C. Brooks, E.L. Ray, J. Bien, J. Bracher, A. Rumack, R.J. Tibshirani, N.G. Reich: (Comparing ensemble approaches for short-term probabilistic COVID-19 forecasts in the U.S.)[https://forecasters.org/blog/2020/10/28/comparing-ensemble-approaches-for-short-term-probabilistic-covid-19-forecasts-in-the-u-s/]
- E.L. Ray, N. Wattanachit, J. Niemi et al: [Ensemble Forecasts of Coronavirus Disease 2019 (COVID-19) in the U.S.](https://www.medrxiv.org/content/10.1101/2020.08.19.20177493v1).

## Acknowledgements

Das Forecast Hub-Projekt ist Teil des von der Helmholtz-Gemeinschaft geförderten [SIMCARD Information& Data Science Pilot Project](https://www.helmholtz.de/forschung/information-data-science/information-data-science-pilot-projekte/pilotprojekte-2/). Ausserdem gilt unser Dank der [Alexander von Humboldt Stiftung](http://www.humboldt-foundation.de/web/start.html) deren Unterstützung für Nicholas G. Reich maßgeblich dazu beigetragen hat, die Zusammenarbeit mit dem [ Reich Lab](https://reichlab.io/) und dem und dem [US COVID-19 Forecast Hub](https://github.com/reichlab/covid19-forecast-hub) in die Wege zu leiten.

**Für die Inhalte dieser Seite sind einzig die Autoren verantwortlich. Diese Seite spiegelt nicht notwendigerweise die Standpunkte des KIT, HITS, der Humboldt Stiftung oder der Helmholtz-Gemeinschaft wider.**