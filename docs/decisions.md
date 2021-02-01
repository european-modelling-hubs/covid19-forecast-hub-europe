# Key decisions and files affected

## Pending decisions

### Location format

- [ ] FIPS (as in the US and Germany), ISO-3 (as in the ECDC data) or NUTS (as per EU data) - tbc

Files affected:
- `template/locations_eu.csv` [currently using ISO-3]

## Made decisions

### Submission period

Decision: Thursday to Monday (to be reviewed).
Rationale: Data is updated on Thursdays

### Horizons and date ranges

Decision: 4 weeks ahead.

Files affected:
- `code/validation/covid19.py`

### Targets

Decisions: Cases and deaths initially, possibly an indicator of health system burden later.
Rationale: Hospitalisations not recorded consistently across countries, so this will have to be considered carefully, and is best done so later.

Files affected:
- `code/validation/covid19.py`

### Locations

Decision: National only, at least initially.
Rationale: Unclear whether there is capacity among modelling teams to provide subnational forecasts.

### Frequency of forecasts

Decision: Weekly.
Rationale: No gain from going less often, and this ensures relevance and timeliness, and is in line with the other forecasting hubs.

Files affected:
- `code/validation/covid19.py`

### File naming

Decision: Single file, `<date>-<group>-<model>.csv`. Date is to be the last day of the submission period (Monday as things stand).
Rationale: File contents should be self-explaining and as little information as possible in the file name

Files affected:
- `code/validation/validate_filenames.py`
- `code/validation/test-formatting.py`
- `code/validation/covid19.py`

### File format

Decision: As in the US Forecast hub To contain a column called "scenario" which is set to "forecast" for forecasts.

Rationale: Consistency with other forecast hubs but desire to possibly add scenarios later. 

Files affected:
- `code/validation/covid19.py`
- `code/validation/quantile_io.py`

### Truth data

Decision: From ECDC (https://www.ecdc.europa.eu/en/covid-19/data).

Rationale: ECDC sponsors this project and therefore it makes sense to use their official data streams. Problem is that the updating schedule is relatively slow so modellers will have to be pointed to other sources.

Files affected:
- `code/validation/validate_truth.py` [removed]
- `code/validation/check_truth.py`

### Quantiles

Decisions: We use quantiles `c(0.01, 0.025, seq(0.05, 0.95, by = 0.05), 0.975, 0.99)` but also allow point forecasts which, however, do not become part of the ensemble.

Rationale: These are the same quantiles used elsewhere (US and Germany/Poland). We do not allow submission with a smaller set of quantiles as this will make creating the ensemble and comparing model performance difficutl without extrapolating beyond or making assumptions about the model submissions (which we would like to avoid).

### Ensemble

Initially we will construct a mean ensemble - at a later stage we will consider weighing forecasts by past performance.
