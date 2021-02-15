import glob
from pprint import pprint
import sys
import os
import pandas as pd
import numpy as np
import datetime
from pathlib import Path
from pyprojroot import here

sys.path.append(str(Path.cwd().joinpath("code", "validation")))
import covid19
from metadata import check_for_metadata, get_metadata_model, output_duplicate_models

# set range of valid scenario IDs
VALID_SCENARIO_ID = ["forecast"] # add new scenarios here

# replace meta data check

# Check filename date matches forecast date
def filename_match_forecast_date(filename):
    df = pd.read_csv(filename)
    file_forecast_date = os.path.basename(os.path.basename(filename))[:10]
    forecast_date_column = set(list(df['forecast_date']))

    if len(forecast_date_column) > 1:
        return "ERROR: %s has multiple forecast dates: %s. Forecast date must be unique" % (
            filename, forecast_date_column)
    else:
        forecast_date_column = forecast_date_column.pop()

        if file_forecast_date != forecast_date_column:
            return "ERROR %s forecast filename date %s does not match forecast_date column %s" % (
                filename, file_forecast_date, forecast_date_column)
        else:
            return None
            
# Check scenario column
def scenario_id_match(filename):
    df = pd.read_csv(filename)
    
    # check if scenario col is present
    if 'scenario_id' in list(df):
        scenario_id = set(list(df['scenario_id']))
        
        # error if not valid
        if scenario_id not in VALID_SCENARIO_ID:
            return "ERROR: scenario_id must be either 'forecast' or a given scenario ID: %s" % (scenario_id)
    
    else:
        return None
    
# Check forecast formatting

def check_formatting(my_path, model=None):
    output_errors = {}
    df = pd.read_csv('code/validation/validated_files.csv')
    previous_checked = list(df['file_path'])
    files_in_repository = []

    if model:
        paths = glob.iglob(my_path + "/" + model + "**/", recursive=False)

    else:
        paths = glob.iglob(my_path + "**/**/", recursive=False)

        # Iterate through processed csvs
    for path in paths:
        for filepath in glob.iglob(path + "*.csv", recursive=False):
            files_in_repository += [filepath]

            # check if file has been edited since last checked
            if filepath not in previous_checked:
                # delete validated file if currrently present
                df = df[df['file_path'] != filepath]

                # validate file
                file_error = covid19.validate_quantile_csv_file(
                    filepath)
                # file_error = "no errors"
                # Check forecast file date = forecast_date column
                forecast_date_error = filename_match_forecast_date(filepath)
                if forecast_date_error is not None:
                    if file_error == 'no errors':
                        file_error = [forecast_date_error]
                    else:
                        file_error += [forecast_date_error]
                        
               # Check scenario ID is valid if present
                scenario_id_error = scenario_id_match(filepath)
                if scenario_id_error is not None:
                    if file_error == 'no errors':
                        file_error = [scenario_id_error]
                    else:
                        file_error += [scenario_id_error]

                if file_error != 'no errors':
                    output_errors[filepath] = file_error
                else:
                    # add to previously checked files
                    current_time = datetime.now()
                    df = df.append({'file_path': filepath,
                                    'validation_date': current_time}, ignore_index=True)

    # Remove files that have been deleted from repo
    # files that are in verify checks but NOT in repository
    deleted_files = np.setdiff1d(previous_checked, files_in_repository)
    df = df[~df['file_path'].isin(deleted_files)]

    # update previously checked files
    if not model:
        df.to_csv('code/validation/locally_validated_files.csv', index=False)

    # Output list of Errors
    if len(output_errors) > 0:
        for filename, errors in output_errors.items():
            print("\n* ERROR IN '", filename, "'")
            for error in errors:
                print(error)
                pass
        sys.exit("\n ERRORS FOUND EXITING BUILD...")
    else:
        print("✓ no errors")

def main():
    my_path = str(here('data-processed'))

    try:
        model = sys.argv[1]
    except IndexError:
        model = None
 
    # check_metadata(my_path, model)
    check_formatting(my_path, model)


if __name__ == "__main__":
    main()
