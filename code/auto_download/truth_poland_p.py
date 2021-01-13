# -*- coding: utf-8 -*-
"""
Created on Wed Oct 14 10:31:53 2020

@author: Jannik
"""


import pygsheets
import pandas as pd
from unidecode import unidecode
import datetime
import numpy as np
import time

def wide_to_long(df):
    """

    Parameters
    ----------
    df : TYPE
        dataframe in wide format

    Returns
    -------
    df : TYPE
        dataframe in long format

    """
    df = df.unstack().reset_index()
        
    df = df.rename(columns={"level_0": "date", 0: "value"})
    
    # handle date
    date_col = df["date"].values.tolist()
    
    date_col_reversed = date_col.copy()
    date_col_reversed.reverse()
    
    eoy = date_col_reversed.index("31.12")
    
    first_year = date_col[:len(date_col) - eoy]
    second_year = date_col[len(date_col) - eoy:]
    
    first_year_compl = [x + ".2020" for x in first_year]
    sec_year_compl = [x + ".2021" for x in second_year]
    
    df["date"] = first_year_compl + sec_year_compl
    
    
    df["date"] = df['date'].apply(lambda x: (x).replace(".", "/"))
    df["date"] = pd.to_datetime(df["date"], format="%d/%m/%Y")
    
    # add location names
    df["location"] = df["location_name"].apply(lambda x: abbr_vois[x])
    
    # handle polish characters
    df["location_name"] = df["location_name"].apply(lambda x: unidecode(x))
    
    #shift to ecdc
    df["date"] = df["date"]. apply(lambda x: x + datetime.timedelta(days=1))
    df = df.set_index("date")
    
    df = df[["location_name", "location", "value"]]
    
    return df


gc = pygsheets.authorize(service_account_env_var ='SHEETS_CREDS')
#gc = pygsheets.authorize(service_file='creds.json')
a = gc.open_by_key('1ierEhD6gcq51HAm433knjnVwey4ZE5DCnu1bW7PRG3E')

worksheet = a.worksheet('title','Wzrost w województwach')

abbr_vois = {"Śląskie": "PL83", "Mazowieckie": "PL78", "Małopolskie": "PL77", 
             "Wielkopolskie": "PL86", "Łódzkie": "PL74", "Dolnośląskie": "PL72", 
             "Pomorskie": "PL82", "Podkarpackie": "PL80",
             "Kujawsko-Pomorskie": "PL73", "Lubelskie": "PL75", 
             "Opolskie": "PL79", "Świętokrzyskie": "PL84", "Podlaskie": "PL81",
             "Zachodniopomorskie": "PL87", "Warmińsko-Mazurskie": "PL85", 
             "Lubuskie": "PL76", "Poland": "PL"}

inc_case_rows = range(8, 25)
cum_case_rows = range(31, 48)
inc_death_rows = range(51, 68)
cum_death_rows = range(71, 88)


result = []

for idx, relevant_rows in enumerate([inc_case_rows, cum_case_rows, inc_death_rows, cum_death_rows]):
    
    
    rows = []
    
    for row in relevant_rows:
        rows.append(worksheet.get_row(row))
        time.sleep(1)
        #print("debug")
        
    df = pd.DataFrame(rows[1:], columns=rows[0])
    
    # drop cols without values
    df = df.loc[:,~df.columns.duplicated()]
    df = df.drop(df.columns[-1],axis=1)
    
    # delete suma col if exists
    if "SUMA" in list(df):
        df = df.drop(columns=["SUMA"])
        
    if "Dane" in list(df)[-1]:
        df = df.drop(df.columns[-1],axis=1)
        
    df = df.rename(columns={"Województwo": "location_name"})
    df = df.set_index("location_name")
    df = df.replace(r'^\s*$', np.nan, regex=True)
    df = df.astype(float)
    
    # for cum cases, the sum has to be extracted from different worksheet because of bulk reporting
    if idx == 1:
        
        worksheet_cases = a.worksheet('title','Wzrost')
        cum_cases_pol = worksheet_cases.get_col(col=12)[3:]
        #print(cum_cases_pol)
        cum_cases_pol = [float(x) for x in cum_cases_pol if not x.strip()==""]
        df.loc["Poland"] = cum_cases_pol
    
    # for cum deaths, the sum has to be extracted from different worksheet because of bulk reporting
    elif idx == 3:
        
        worksheet_cases = a.worksheet('title','Wzrost')
        cum_cases_pol = worksheet_cases.get_col(col=13)[3:]
        cum_cases_pol = [float(x) for x in cum_cases_pol if not x.strip()==""]
        df.loc["Poland"] = cum_cases_pol
    
    #df["location"] = abbr_vois
    
    result.append(df)

wide = result

# calculate inc cases for poland
cum_cases = wide[1].loc["Poland"].values.tolist()
inc_cases = np.asarray(cum_cases) - np.asarray([0] + cum_cases[:-1])
 
df_inc_cases = wide[0]
df_inc_cases.loc["Poland"] = inc_cases.tolist()
wide[0] = df_inc_cases

# calculate ncn deaths for poland
cum_deaths = wide[3].loc["Poland"].values.tolist()
inc_deaths = np.asarray(cum_deaths) - np.asarray([0] + cum_deaths[:-1])
 
df_inc_deaths = wide[2]
df_inc_deaths.loc["Poland"] = inc_deaths.tolist()
wide[2] = df_inc_deaths

long_result = [wide_to_long(df) for df in wide]

    
long_result[0].to_csv("../../data-truth/MZ/truth_MZ-Incident Cases_Poland.csv")
long_result[1].to_csv("../../data-truth/MZ/truth_MZ-Cumulative Cases_Poland.csv")
long_result[2].to_csv("../../data-truth/MZ/truth_MZ-Incident Deaths_Poland.csv")
long_result[3].to_csv("../../data-truth/MZ/truth_MZ-Cumulative Deaths_Poland.csv")
