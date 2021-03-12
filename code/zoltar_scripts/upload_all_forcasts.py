#!/usr/bin/env python3
"""Upload forcasts to Zoltar"""
__appname__  = "upload_all_forcasts.py"
__author__   = "Joseph Palmer <Joe.Palmer.2019@live.rhul.ac.uk>"
__version__  = "0.0.1"
__date__     = "03-2021"

import os
import json
import glob
import yaml
import shared_variables
from zoltpy.connection import ZoltarConnection
from zoltpy.cdc_io import YYYY_MM_DD_DATE_FORMAT



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


def upload_all_covid_forcasts(forcast_path : str, zoltar_project_dict : dict):
    """Upload all forcasts for a given directory

    Args:
        forcast_path (str): path to processed model forcasts
        dir_name (str): name of model directory.
    """
    forcast_files = glob.glob(f"{forcast_path}/*.csv")
    metadata_file = glob.glob(f"{forcast_path}/*.txt")[0]
    metadata = metadata_dict_for_file(metadata_file)

    # get model config for the metadata file
    model_config = zoltar_config_from_metadata(metadata)

    # check model is on zoltar, if not add it
    print(metadata)
    if metadata["model_abbr"] not in zoltar_project_dict["model_abbr"]:
        add_model_to_zoltar()


def main():
    zoltar_project_objects = zoltar_setup()
    data_processed = "./data-processed"
    model_directories = os.listdir(data_processed)
    for directory in model_directories[:1]:
        if "." in directory:
            continue
        model_path = f"{data_processed}/{directory}"
        upload_all_covid_forcasts(model_path, zoltar_project_objects)

if __name__ == "__main__":
    main()