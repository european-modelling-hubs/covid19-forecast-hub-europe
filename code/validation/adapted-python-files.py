# -*- coding: utf-8 -*-

"""
23 Jan 2021 - Kath
Note of files modified for Europe Hub from Germany/Poland Forecast Hub

Major modifications:
 - Use ECDC data
 - Alter countries + codes (germany/poland > 32 European countries ISO-3)
 - Add "scenario" column to forecast file format
 - Filename + forecast_date = Monday, last day of submission
 - Filenames = remove country and mode ("-case" / "-icu" etc)

Files changed:
# <code/validation/...>

 - [x] validate_truth.py - DELETED
         - only 1 data source, no need to reconcile

 - [x] check_truth.py - MODIFIED
         - adapted to ECDC filename + date column name
         - note: kept heavier structure to allow adding extra data sources

 - [x] covid19.py - MODIFIED
         - replaced VALID_TARGET_NAMES & FIPS_CODES
         - validate_quantile_csv_file:
             - replaced fips_codes with 32 ISO-3C
             - removed args for "country" and "mode", not used
             - add 'scenario' to additional required columns
         - covid19_row_validator: 
             - targets: dropped daily, icu/hosp, cumulative
             - validate date alignment:
                 - removed daily targets
                 - replaced epiweek with Mon-Sun week
                     - see commented-out code to change back to Sun-Sat week
                     - Forecast date should be Monday
            - adds check on "scenario" column ('forecast' or 'scenario')

 - [x] quantile_io.py - MODIFIED
         - replace "fips_code" with "code"
         - add "scenario" to POSSIBLE_COLUMNS
         - note: if I understand correctly, zoltar is unable to store "scenario" column (https://docs.zoltardata.com/fileformats/#quantile-forecast-format-csv)
            - could we get around this by specifying "forecacst/scenario" as "target units"?
                - we need to specify this when setting up zoltar: https://docs.zoltardata.com/targets/
                - this would impact validation:
                    - covid19.py: 
                        - VALID_TARGET_NAMES
                        - json_io_dict_from_quantile_csv_file(args)
                        - covid19_row_validator()

 - [x] test-formatting.py - MODIFIED
         - removed "COUNTRIES" list, "country" and "mode", not used in filename
         - forecast_date column must match filename and be a Monday

 - [x] test-formatting-local.py - MODIFIED
         - removed "COUNTRIES" list, "country" and "mode", not used in filename

 - [x] validate_filenames.py- MODIFIED
         - removed from filename check: countries, icu, case

 - [x] get_commit_dates.py - UNCHANGED

 - [x] cdc_io.py - UNCHANGED
     - note: some functions are modified/used in quantile_io.py / covid19.py


# <code/visualization/...>
- [] data_preparation.py
- [] prepare_truth_data.py
- [] add_last_observed.py

"""
