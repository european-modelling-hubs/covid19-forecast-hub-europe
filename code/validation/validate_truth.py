# -*- coding: utf-8 -*-
"""
Created on Tue Aug 18 21:04:18 2020

@author: Jannik
"""

import pandas as pd
import numpy as np
from pathlib import Path

RKI_path = Path.cwd().parent.parent.joinpath("data-truth", "RKI")
ECDC_path = Path.cwd().parent.parent.joinpath("data-truth", "ECDC")

RKI_data = ["truth_RKI-Cumulative Cases_Germany.csv",
            "truth_RKI-Cumulative Deaths_Germany.csv",
            "truth_RKI-Incident Cases_Germany.csv",
            "truth_RKI-Incident Deaths_Germany.csv"]

ECDC_data = ["truth_ECDC-Cumulative Cases_Germany.csv",
             "truth_ECDC-Cumulative Deaths_Germany.csv",
             "truth_ECDC-Incident Cases_Germany.csv",
             "truth_ECDC-Incident Deaths_Germany.csv"]

rki_dfs = []

for rki, ecdc in zip(RKI_data, ECDC_data):
    
    # load data
    rki_df = pd.read_csv(RKI_path.joinpath(rki))
    ecdc_df = pd.read_csv(ECDC_path.joinpath(ecdc))
    
    # only check national level
    rki_df = rki_df[rki_df["location"] == "GM"]
    rki_dfs.append(rki_df)
    # values of last 7 days 
    rki_values = rki_df.tail(n=7)["value"].values
    ecdc_values = ecdc_df.tail(n=7)["value"].values
    
    # calculate diff
    truth_data = pd.merge(rki_df.tail(n=7), ecdc_df.tail(n=7), on="date")
    
    print(truth_data)
    
    #check if we have 7 matching dates in last 7 days
    if truth_data.shape[0] != 7:
        
        print("****************************")
        print("WARNING: Date missing in last 7 Days in " + rki)
        print("****************************")
   
    
    else:
        diff = rki_values - ecdc_values
        
        if diff.sum() != 0:
            print("WARNING : Data mismatch in " + rki)
            print(np.nonzero(diff))
    