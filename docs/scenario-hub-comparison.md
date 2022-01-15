# Euro scenario hub set up

This document outlines where the infrastructure for the European COVID-19 Forecast Hub varies from that of the US COVID-19 Scenario hub.

This covers the differences between Github repo structure only, including the [folder structure](#main-branch-folder-structure) and the format for [individual file submissions](#changes-to-team-submissions).
- The US Scenario Hub Github repo doesn't include the evaluation, reporting, or visualisation of model output, so this is not covered. I can't immediately find code for the US scenario hub [website](https://covid19scenariomodelinghub.org/viz.html).
- The differences in defining model targets could be covered separately by comparing the Euro forecast hub (e.g. the Wiki) to the US Scenario Hub [README](https://github.com/midas-network/covid19-scenario-modeling-hub#readme), which has the detailed description of each round's model scenarios.

## Main branch folder structure

This section compares the folder structure in the root of the US Scenario Hub repo against the main European forecast hub repo.

- __Keeps__
  - `data-processed`
    - `team-model` folders: for changes to files see [Changes to team submissions](`#changes-to-team-submissions`)
  - `data-locations` – no change, contains a locations `csv` with a structure that matches our existing file
  - `code` – appears largely unused, includes code to run a JHU team model
  - `.github` - workflow runs for validation, which seem to be currently disabled
  - `README` - contains the full description of the hub, plus current scenario details for modellers.
    - _Suggestion_: Limit the README for only the generic hub introduction. Use a separate folder or a Wiki for each round's scenario details.

- __Adds__
  - `code_resources` - maybe code for modellers to use? Includes a single file for getting age-specific vaccination data.
    - _Suggestion_: merge this with `code` or drop. Having common code to fetch data that is easily accessible to modellers could still be useful.
  - `FAQ` - includes some extra clarifications on dates and target definitions.
    - _Suggestion_: drop this folder and incorporate ad hoc updates into a Wiki or README.
  - `paper-source-code`
    - _Suggestion_: drop this folder as meta-hub research can be kept in a separate repo
  - `previous-rounds` – includes all previous READMEs (describing scenarios) and scenario table diagrams
    - _Suggestion_: drop this folder and separate out the (history of) scenario details from the README.

- __Removes__
  - `ensembles` - all ensembles are saved in `data-processed` as `data-processed/Ensemble-model`. Unclear where the code to create the ensembles is or runs.
  - `evaluation` - not needed as not currently scoring scenario submissions.
  - `template` - the template for team-model submissions is instead a folder in `data-processed`: `data-processed/Myteam-Mymodel`.
    - _Suggestion_: This probably makes it easier to see the template file structure as well as files.
  - `viz` - not needed given this is our code for the Angular app.
  - `validation` - validation code stored at: https://github.com/midas-network/zoltpy
  - `docs` - we used the `decisions.md` to document changes from the US forecast hub, but this could just as easily be stored as part of the Wiki.

---

## Changes to team submissions

Below are the modifications from the existing European forecast hub, to the US Scenario hub structure, for each file that teams are asked to submit. Includes changes to file names, formatting, and validation checks, for model output, metadata, and the (new addition) abstract.

#### Model output

- Weekly submission file
  - Format __keeps__ `csv`, using zip files if size exceeds 100MB
  - File name __keeps__ `YYYY-MM-DD-team-model.csv`
  - Included fields:
    - __Replaces__ `forecast_date` with `model_projection_date`
    - __Keeps__ all other existing fields, with the same formatting (`target`, `target_end_date`, `location`, `type`, `value`, `quantile`)
    - __Adds__
      - `scenario_name` - a single lowercase word, specified in README
      - `scenario_id` - a string in the format `letter-YYYY-MM-DD`, specified in README
- Validation
  - __Adds__ checks `scenario_id` and `scenario_name` match correct format
  - __Modifies__ `target` allows 1 through 26 weeks ahead; suggested weeks to include earliest 13 weeks ahead and furthest 26 weeks ahead

#### Metadata

- Metadata text file
  - Format __keeps__ `.txt` with `YAML` format
  - Naming __keeps__ `team-model-metadata.txt`
  - Included fields:
    - __Keeps__ all existing fields in forecast hub
    - __Adds__ fields (see [description](https://github.com/midas-network/covid19-scenario-modeling-hub/blob/master/data-processed/METADATA.md))
      - `model_version`, `modelling_NPI`, `compliance_NPI`, `contact_tracing`, `testing`, `vaccine_efficacy_transmission`, `vaccine_efficacy_delay`, `vaccine_hesitancy`, `vaccine_immunity_duration`, `natural_immunity_duration`, `case_fatality_rate` *, `infection_fatality_rate` *, `asymptomatics` *, `age_groups`, `importations`, `confidence_interval_method`, `calibration`, `spatial_structure`, `data_inputs`
- Validation
  - __Adds__ checks that all added fields above are strings, except the numeric fields, marked by (*). String is allowed to be "Not applicable"

#### Abstract
- __Adds__ new file added as of round 12, suggested for all teams (see [example](https://github.com/midas-network/covid19-scenario-modeling-hub/blob/master/data-processed/MyTeam-MyModel/2022-01-09-MyTeam-Abstract.md))
  - Naming: `YYYY-MM-DD-team-model-abstract.md`
  - Format: Free text markdown with suggested headers
    - Summarise results
    - Explain results
    - Describe model assumptions (specifically: susceptibility, transmissibility, generation time, waning immunity)
    - Describe changes from previous rounds
