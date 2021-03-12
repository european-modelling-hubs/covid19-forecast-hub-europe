#!/usr/bin/env python3
"""Upload forcasts to Zoltar"""
__appname__  = "upload_all_forcasts.py"
__author__   = "Joseph Palmer <Joe.Palmer.2019@live.rhul.ac.uk>"
__version__  = "0.0.1"
__date__     = "03-2021"

import hashlib
import os
import json
import glob
import yaml
import logging
import shared_variables
from zoltpy.connection import ZoltarConnection
from zoltpy.cdc_io import YYYY_MM_DD_DATE_FORMAT

# set logger as a global variable
logger = logging.getLogger(__name__)

def zoltar_setup(staging=False) -> dict:
    """Set up variables for interacting with Zoltar

    Args:
        staging (bool, optional): use staging server. Defaults to False.
    """
    # meta info
    project_name = 'ECDC European COVID-19 Forecast Hub'
    project_obj = None
    url = 'https://github.com/epiforecasts/covid19-forecast-hub-europe/tree/main/data-processed'
    project_timezeros = []

    # Is staging is set to True, use the staging server
    if staging:
        conn = ZoltarConnection(host='https://rl-zoltar-staging.herokuapp.com')
    else:
        conn = ZoltarConnection()
    conn.authenticate(os.environ.get("Z_USERNAME"), os.environ.get("Z_PASSWORD"))

    MISSING_METADATA_VALUE = "Missing"
    db = {}
    with open('./code/zoltar_scripts/validated_file_db.json', 'r') as f:
        db = json.load(f)

    # Get all existing timezeros and models in the project
    project_obj = [project for project in conn.projects if project.name == project_name][0]
    project_timezeros = [timezero.timezero_date for timezero in project_obj.timezeros]
    models = [model for model in project_obj.models]
    model_abbr = [model.abbreviation for model in models]

    # Convert all timezeros from Date type to str type
    project_timezeros = [
        project_timezero.strftime(YYYY_MM_DD_DATE_FORMAT)
        for project_timezero in project_timezeros
    ]

    project_objects = {
        "project_obj" : project_obj,
        "project_timezeros" : project_timezeros,
        "models" : models,
        "model_abbr" : model_abbr
    }
    return project_objects

def metadata_dict_for_file(metadata_file : str ) -> dict:
    """Read Metadata files into a dictionary

    Args:
        metadata_file (str): path to the metadata file

    Returns:
        dict: contents of the metadata file.
    """
    with open(metadata_file, encoding="utf8") as m:
        metadata_dict = yaml.safe_load(m)
    return metadata_dict

def zoltar_config_from_metadata(metadata : dict) -> dict:
    """get zoltar model_config object from metadatafile using
    the zoltar mapping dict

    Args:
        metadata (dict): dictionary of metedata file contents

    Returns:
        dict: metadata and zoltar fields
    """
    conf = {}
    for mfield, zfield in shared_variables.metadata_field_to_zoltar.items():
        if mfield in metadata:
            conf[zfield] = metadata[mfield]
        else:
            conf[zfield] = shared_variables.missing_metadata_value
    return conf

def add_model_to_zoltar_dict(zoltar_project_dict : dict, config : dict) -> int:
    """Add a new model to the dictionary of zoltar projects

    Args:
        zoltar_project_dict (dict): zoltar objects
        config (dict): zoltar config from metadata

    Returns:
        int: 0
    """
    zoltar_project_dict["models"].append(
        zoltar_project_dict["project_obj"].create_model(config)
    )
    zoltar_project_dict["model_abbr"] = [
        model.abbreviation for model in zoltar_project_dict["models"]
    ]
    return 0

def has_changed(metadata : dict, model : tuple) -> bool:
    """check for changes in model metadata

    Args:
        metadata (dict): metadata dictionary
        model (tuple): model information

    Returns:
        bool: pass or fail of the check
    """
    for metadata_field, zoltar_field in shared_variables.metadata_field_to_zoltar.items():
        if metadata.get(
            metadata_field,
            shared_variables.missing_metadata_value
        ) != getattr(model, zoltar_field):
            print(f"{metadata_field} has changed in {metadata['model_abbr']}")
            return True
    return False

def format_model_metadata_for_zoltar(model_path : str, zoltar_project_dict) -> dict:
    """Upload all forcasts for a given directory

    Args:
        model_path (str): path to processed model forcasts
        dir_name (str): name of model directory.
    """
    metadata_file = glob.glob(f"{model_path}/*.txt")[0]
    metadata = metadata_dict_for_file(metadata_file)

    # get model config for the metadata file
    model_config = zoltar_config_from_metadata(metadata)

    # check model is on zoltar, if not add it
    if metadata["model_abbr"] not in zoltar_project_dict["model_abbr"]:
        add_model_to_zoltar_dict(zoltar_project_dict, model_config)

    # fetch model from abbreviation
    model = [
        model for model in zoltar_project_dict["models"]
        if model.abbreviation == metadata["model_abbr"]
    ][0]

    # check for changes in the metadata
    if has_changed(metadata, model):
        # model metadata has changed, call the edit function in zoltpy to update metadata
        print(f"{metadata['model_abbr']!r} model has changed metadata contents. Updating on Zoltar...")
        model.edit(model_config)
    
    return (model, metadata)

def upload_all_covid_forcasts(forcast_path : str, zoltar_project_dict : dict):
    """Upload all forcasts for a given directory

    Args:
        forcast_path (str): path to processed model forcasts
        dir_name (str): name of model directory.
    """
    # get model and metadata
    model, metadata = format_model_metadata_for_zoltar(forcast_path, zoltar_project_dict)
    
    # check for forcasts already on zoltar to avoid re-upload
    existing_time_zeros = [forecast.timezero.timezero_date for forecast in model.forecasts]

    # Convert all timezeros from Date type to str type
    existing_time_zeros = [existing_time_zero.strftime(YYYY_MM_DD_DATE_FORMAT) for existing_time_zero in existing_time_zeros]

    forecasts = glob.glob(f"{forcast_path}/*.csv")
    for forecast_path in forecasts:
        # Default config
        over_write = False
        checksum = 0
        time_zero_date = forecast.split(dir_name)[0][:-1]

        forecast = forcast_path.split("/")[-1]
        # check if forecast is already on zoltar
        with open(forecast_path, "rb") as f:
            # get current hash of processed file
            checksum = hashlib.md5(f.read()).hexdigest()
        
        # check hash against previous versions of hash
        if db.get(forecast, None) != checksum:
            if time_zero_date in existing_time_zeros:

                # Check if the already existing forecast has the same issue date

                from datetime import date
                local_issue_date = date.today().strftime("%Y-%m-%d")

                uploaded_forecast = [forecast for forecast in model.forecasts if forecast.timezero.timezero_date.strftime(YYYY_MM_DD_DATE_FORMAT) == time_zero_date][0]
                uploaded_issue_date = uploaded_forecast.issue_date

                if local_issue_date == uploaded_issue_date:
                    # Overwrite the existing forecast if has the same issue date
                    over_write = True
                    logger.info(f"Overwrite existing forecast={forecast} with newer version because the new issue_date={local_issue_date} is the same as the uploaded file issue_date={uploaded_issue_date}")
                else:
                    logger.info(f"Add newer version to forecast={forecast} because the new issue_date={local_issue_date} is different from uploaded file issue_date={uploaded_issue_date}")

        else:
            continue

    




def main():
    zoltar_project_objects = zoltar_setup()
    data_processed = "./data-processed"
    model_directories = os.listdir(data_processed)
    for directory in model_directories[:1]:
        print(directory)
        if "." in directory:
            continue
        model_path = f"{data_processed}/{directory}"
        upload_all_covid_forcasts(model_path, zoltar_project_objects)

if __name__ == "__main__":
    main()