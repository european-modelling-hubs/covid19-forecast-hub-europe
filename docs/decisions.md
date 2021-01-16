# Key decisions and files affected

## Outstanding decisions

### Frequency of forecasts

- [ ] Weekly, bi-weekly or monthly?

### Submission period

- [ ] Friday to Monday? (data is updated on Thursdays)

### Horizons and date ranges

- [ ] Weekly data up to 4 weeks ahead?

### Targets

- [ ] Cases and deaths, possibly others

### Locations

- [ ] National only or subnational, too?

### Location format

- [ ] FIPS (as in the US and Germany), ISO-3 (as in the ECDC data) or NUTS (as per EU data)

## Made decisions

### File naming

Decision: Single file, `<date>-<group>-<model>.csv`
Rationale: File contents should be self-explaining and as little information as possible in the file name

Files affected:
- `code/validaton/validate_filenames.py`

### File format

Decision: As in the US Forecast hub To contain a column called "scenario" which is set to "forecast" for forecasts.

Rationale: Consistency with other forecast hubs but desire to possibly add scenarios later. 

### Truth data

Decision: From ECDC (https://www.ecdc.europa.eu/en/covid-19/data).

Rationale: ECDC sponsors this project and therefore it makes sense to use their official data streams. Problem is that the updating schedule is relatively slow so modellers will have to be pointed to other sources.

### Quantiles

Decisions: We use quantiles `c(0.01, 0.025, seq(0.05, 0.95, by = 0.05), 0.975, 0.99)` but also allow point forecasts which, however, do not become part of the ensemble.

Rationale: These are the same quantiles used elsewhere (US and Germany/Poland). We do not allow submission with a smaller set of quantiles as this will make creating the ensemble and comparing model performance difficutl without extrapolating beyond or making assumptions about the model submissions (which we would like to avoid).

### Ensemble

Initially we will construct a mean ensemble - at a later stage we will consider weighing forecasts by past performance.
