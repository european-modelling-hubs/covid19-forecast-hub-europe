## Scheduled workflows

| Action name                                    | Language   | Scheduled at (UTC time)                                       | Function                                           |
|------------------------------------------------|------------|----------------------------------------------------------------|----------------------------------------------------|
| [`ecdc_owid_data.yml`](ecdc_owid_data.yml)                         | R          | [12:07 every day](https://crontab.guru/#7_12_*_*_*)       | Get recorded cases and deaths from ECDC, and hospitalisations from OWID                       |
| [`check-truth.yml`](check-truth.yml)           | Python & R | [13:00 every day](https://crontab.guru/#0_13_*_*_*)            | Check truth data                   |
| [`ensemble.yml`](ensemble.yml)                 | R          | [11:15 every Tuesday and Wednesday](https://crontab.guru/#15_11_*_*_2,3)       | Create weekly ensemble                             |
| [`release.yml`](release.yml) | R | [11:15 every Thursday](https://crontab.guru/#15_11_*_*_4) | Create GitHub release |
| [`reports-country.yml`](reports-country.yml) | R          | [16:00 every Tuesday](https://crontab.guru/#0_16_*_*_0)       | Compile ensemble report                            |
| [`reports-model.yml`](reports-eval.yml)         | R          | [11:55 every Tuesday and Wednesday](https://crontab.guru/#45_11_*_*_2,3)           | Compile evaluation reports                         |
| [`scoring.yml`](scoring.yml) | R | [9:00 every Sunday](https://crontab.guru/#0_9_*_*_0) | Score forecasts |
| [`visualisation.yml`](visualisation.yml)       | Python & R | [8:00 and 12:00 every day](https://crontab.guru/#0_8,12_*_*_*) | Prepare truth data and forecasts for visualisation |
| [`zoltar-upload.yml`](zoltar-upload.yml)      | Python     | [7:00 every day](https://crontab.guru/#0_7_*_*_*)              | Upload modified data to [Zoltar](https://www.zoltardata.com/project/238) |

## Submission checks

| Action name                                        | Language |
|----------------------------------------------------|----------|
| [`submission_preview.yml`](submission_preview.yml) | R        |
| [`ValidationV2.yml`](ValidationV2.yml)             | Python   |
| [`Validations-R.yml`](Validations-R.yml)           | R        |
| [`labeler.yml`](labeler.yml)                       |
