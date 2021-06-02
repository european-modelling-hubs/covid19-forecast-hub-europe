## Scheduled workflows

| Action name                                                                                                                            | Language   | Scheduled at                                                   | Function                     |
|----------------------------------------------------------------------------------------------------------------------------------------|------------|----------------------------------------------------------------|------------------------------|
| [`ECDC.yml`](https://github.com/epiforecasts/covid19-forecast-hub-europe/blob/main/.github/workflows/ECDC.yml)                         | R          | [12:00 every Thursday](https://crontab.guru/#0_12_*_*_4)       | Get recorded cases from ECDC |
| [`JHU.yml`](https://github.com/epiforecasts/covid19-forecast-hub-europe/blob/main/.github/workflows/JHU.yml)                           | Python     | [7:00 every day](https://crontab.guru/#0_7_*_*_*)              | Get recorded cases from JHU  |
| [`LANL.yml`](https://github.com/epiforecasts/covid19-forecast-hub-europe/blob/main/.github/workflows/LANL.yml)                         | R          | [0:00 every day](https://crontab.guru/#0_0_*_*_*)              |                              |
| [`check-truth.yml`](https://github.com/epiforecasts/covid19-forecast-hub-europe/blob/main/.github/workflows/check-truth.yml)           | Python & R | [13:00 every day](https://crontab.guru/#0_13_*_*_*)            |                              |
| [`ensemble.yml`](https://github.com/epiforecasts/covid19-forecast-hub-europe/blob/main/.github/workflows/ensemble.yml)                 | R          | [10:15 every Tuesday](https://crontab.guru/#15_10_*_*_2)       | Create weekly ensemble       |
| [`evaluation.yml`](https://github.com/epiforecasts/covid19-forecast-hub-europe/blob/main/.github/workflows/evaluation.yml)             | R          | [10:00 every Sunday](https://crontab.guru/#0_10_*_*_0)         | Compute forecast scores      |
| [`reports-ensemble.yml`](https://github.com/epiforecasts/covid19-forecast-hub-europe/blob/main/.github/workflows/reports-ensemble.yml) | R          | [10:45 every Tuesday](https://crontab.guru/#45_10_*_*_2)       | Compile ensemble report      |
| [`reports-eval.yml`](https://github.com/epiforecasts/covid19-forecast-hub-europe/blob/main/.github/workflows/reports-eval.yml)         | R          | [9:00 every Sunday](https://crontab.guru/#0_9_*_*_0)           | Compile evaluation reports   |
| [`visualisation.yml`](https://github.com/epiforecasts/covid19-forecast-hub-europe/blob/main/.github/workflows/visualisation.yml)       | Python     | [8:00 and 11:00 every day](https://crontab.guru/#0_8,11_*_*_*) |                              |

## Submission checks

| Action name                                                                                                                    | Language |
|--------------------------------------------------------------------------------------------------------------------------------|----------|
| [`ValidationV2.yml`](https://github.com/epiforecasts/covid19-forecast-hub-europe/blob/main/.github/workflows/ValidationV2.yml) | Python   |
