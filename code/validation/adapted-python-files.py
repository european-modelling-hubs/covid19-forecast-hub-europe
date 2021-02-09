# -*- coding: utf-8 -*-

"""
23 Jan 2021 - Kath
Note of files modified for Europe Hub from Germany/Poland Forecast Hub

Major modifications:
 - Use JHU data
 - Alter countries + codes (germany/poland > 32 European countries ISO-3)
 - Add "scenario" column to forecast file format
 - Filename + forecast_date = Monday, last day of submission
 - Filenames = remove country and mode ("-case" / "-icu" etc)

Files changed: <code/validation/...>

 - [x] validate_truth.py - DELETED
         - only 1 data source, no need to reconcile

 - [x] check_truth.py - MODIFIED
         - adapted to JHU filename
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
                 - kept epiweek definition
                     - Forecast date should be Monday
                     - exp_target_end_date accounts for -1 in step_ahead_increment
            - adds check on "scenario" column ('forecast' or one of VALID_SCENARIO_ID)

 - [x] quantile_io.py - MODIFIED
         - replace "fips_code" with "code"
         - add "scenario" to POSSIBLE_COLUMNS

 - [x] test-formatting.py - MODIFIED
         - removed "COUNTRIES" list, "country" and "mode", not used in filename
         - forecast_date column must match filename and be a Monday

 - [x] test-formatting-local.py - MODIFIED
         - removed "COUNTRIES" list, "country" and "mode", not used in filename

 - [x] validate_filenames.py- MODIFIED
         - removed from filename check: countries, icu, case

 - [x] get_commit_dates.py - UNCHANGED

 - [x] cdc_io.py - UNCHANGED
     - note: functions used (unchanged) in quantile_io.py / covid19.py
     - quantile_io.py:
         from cdc_io import CDC_POINT_ROW_TYPE, CDC_OBSERVED_ROW_TYPE, CDC_QUANTILE_ROW_TYPE, _parse_value 
         from zoltpy.util import csv_rows_from_json_io_dict
     - covid19.py
         from cdc_io import _parse_date

"""
