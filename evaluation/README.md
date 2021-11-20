# Data files of forecast scores

The files `scores.csv` contains "raw" scores for each data/forecast point based on the predictive quantiles and where the data ended up relative to them. For each combination of date, target variable and location we report the [Weighted Interval Score](https://journals.plos.org/ploscompbiol/article?id=10.1371/journal.pcbi.1008618) (`wis`) as well as its components of `sharpness`, `underprediction` and `overprediction`, the absolute error of the median (`aem`), [Bias](https://doi.org/10.1371/journal.pcbi.1006785) (`bias`), coverage at the 50 and 95% levels (`cov_50`/`cov_95`), and the number of quantiles supplied (`n_quantiles`).

The `weekly-summary` folder contains weekly evaluations that enter the [weekly performance reports](https://covid19forecasthub.eu/reports.html).
