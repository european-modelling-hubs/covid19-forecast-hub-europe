#!/usr/bin/env python3
"""A module of shared variables"""
__appname__  = "shared_variables.py"
__author__   = "Joseph Palmer <Joe.Palmer.2019@live.rhul.ac.uk>"
__version__  = "0.0.1"
__date__     = "03-2021"

# mapping of variables in the metadata to the parameters in Zoltar
metadata_field_to_zoltar = {
    'team_name': 'team_name',
    'model_name': 'name',
    'model_abbr': 'abbreviation',
    'model_contributors': 'contributors',
    'website_url': 'home_url',
    'license': 'license',
    'team_model_designation': 'notes',
    'methods': 'description',
    'repo_url': 'aux_data_url',
    'citation': 'citation',
    'methods_long': 'methods'
}

# what to put if metadata value is missing
missing_metadata_value = "Missing"