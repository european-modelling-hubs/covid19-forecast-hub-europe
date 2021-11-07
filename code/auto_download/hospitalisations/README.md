
### European hospitalisation data pipeline

#### Selecting data

There is no single source covering hospitalisation data across all countries in the Forecast Hub. Data are also often heavily revised,particularly for recent dates, and can vary substantially between sources.

We therefore create a combined set of what we identify as the most reliable data source, truncated to an appropriate date, for each country.

-   The final dataset is saved as: [data-truth/ECDC/truth\_ECDC-Incident Hospitalizations.csv](../data-truth/ECDC/truth_ECDC-Incident%20Hospitalizations.csv)
-   The full pipeline is run with [`hospitalisations-download.R`](../code/auto_download/hospitalisations-download.R)

#### Data sources

We also provide the full version of each data source:

-   ECDC official: [data-truth/ECDC/raw/official.csv](../data-truth/ECDC/raw/official.csv)
    -   Source: [ECDC public website](https://www.ecdc.europa.eu/en/publications-data/download-data-hospital-and-icu-admission-rates-and-current-occupancy-covid-19)
    -   Origin: Mix of public data scraped from websites (typically government data) by the ECDC, and data sent to ECDC directly through the TESSy European data sharing agreement. All data are processed and vetted by ECDC
    -   Released: weekly on Thursdays. Each data point covers the previous Monday-Sunday period. Data are incidence per 100,000 population.
    -   Download with: [`get-ecdc-official.R`](./get-ecdc-official.R)
-   EU scraped: [data-truth/ECDC/raw/scraped.csv](../data-truth/ECDC/raw/scraped.csv)
    -   Source: Additional data obtained from public sources and provided by the ECDC to the European Forecast Hub
    -   Origin: Similar to ECDC public data, before the internal ECDC vetting process.
    -   Released: Daily. Data are raw counts.
    -   Download with: [`get-ecdc-scraped.R`](./get-ecdc-scraped.R)
-   Non-EU:
    [data-truth/ECDC/raw/non-eu.csv](../data-truth/ECDC/raw/non-eu.csv)
    -   Source: UK and Swiss data are not always included in ECDC publications, so we obtain add these separately.
        -   UK: [gov.uk](https://coronavirus.data.gov.uk/details/healthcare)
        -   Switzerland: [covidregionaldata](https://github.com/epiforecasts/covidregionaldata)
    -   Released: Daily. Data are raw counts.
    -   Download with: [`get-non-eu.R`](./get-non-eu.R)

These datasets are combined and filtered to produce a single dataset covering as many countries as possible. This is created with:

-   [`save-selected-sources.R`](./save-selected-sources.R)

We have a set list of preferred sources and number of weeks’ truncation for each country. This is based on minimising large data revisions (where a weekly count is updated &gt;5% in a later data release):

-   Data sources and weeks’ truncation by country: [check-sources/sources.csv](./check-sources/sources.csv)
-   Code: [`check-sources/select_hosp_sources.r`](./check-sources/select_hosp_sources.r)
