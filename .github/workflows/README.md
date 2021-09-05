## Scheduled workflows

| Action name                                    | Language   | Scheduled at                                                   | Function                                           |
|------------------------------------------------|------------|----------------------------------------------------------------|----------------------------------------------------|
| [`ECDC.yml`](ECDC.yml)                         | R          | [12:00 every Thursday](https://crontab.guru/#0_12_*_*_4)       | Get recorded cases from ECDC                       |
| [`JHU.yml`](JHU.yml)                           | Python     | [7:00 every day](https://crontab.guru/#0_7_*_*_*)              | Get recorded cases from JHU                        |
| [`LANL.yml`](LANL.yml)                         | R          | [0:00 every day](https://crontab.guru/#0_0_*_*_*)              | Get forecasts produced by LANL                     |
| [`check-truth.yml`](check-truth.yml)           | Python & R | [13:00 every day](https://crontab.guru/#0_13_*_*_*)            | Check truth data                   |
| [`ensemble.yml`](ensemble.yml)                 | R          | [10:15 every Tuesday](https://crontab.guru/#15_10_*_*_2)       | Create weekly ensemble                             |
| [`reports-ensemble.yml`](reports-ensemble.yml) | R          | [10:45 every Tuesday](https://crontab.guru/#45_10_*_*_2)       | Compile ensemble report                            |
| [`reports-eval.yml`](reports-eval.yml)         | R          | [9:00 every Sunday](https://crontab.guru/#0_9_*_*_0)           | Compile evaluation reports                         |
| [`visualisation.yml`](visualisation.yml)       | Python     | [8:00 and 11:00 every day](https://crontab.guru/#0_8,11_*_*_*) | Prepare truth data and forecasts for visualisation |
| [`zoltar-upload.yml`](zoltar-upload.yml)      | Python     | [7:00 every day](https://crontab.guru/#0_7_*_*_*)              | Upload modified data to [Zoltar](https://www.zoltardata.com/project/238) |

## Submission checks

| Action name                            | Language |
|----------------------------------------|----------|
| [`ValidationV2.yml`](ValidationV2.yml) | Python   |
