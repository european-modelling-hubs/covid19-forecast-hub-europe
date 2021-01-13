# Download latest YYG projections
# Jakob Ketterer, September 2020

import urllib.request
import pandas as pd
import numpy as np
from datetime import date, datetime, timedelta
import os

def days_between(d1, d2):
    diff_list = []
    d2 = datetime.strptime(d2, "%Y-%m-%d")
    for d in d1:   
        d = datetime.strptime(d, "%Y-%m-%d")
        diff_list.append((d - d2).days)
    return diff_list 

if __name__ == "__main__":

    # dir of already saved raw data
    DIR = './data-raw/YYG/'

    # determine today's date
    today = date.today()
    print("Today: ", today)

    # determine most current date in data-raw/YYG
    raw_files = os.listdir(DIR)
    name_suffix = "_global.csv"
    raw_files_list = sorted([f for f in raw_files if f.endswith(name_suffix)], reverse=True)
    if raw_files_list:
        most_current_date_str = raw_files_list[0].replace(name_suffix, "").strip("_global.csv")
    else:
        print("Couldn't determine most current date in data-raw/YYG")
        most_current_date_str = "20200810"
    most_current_date = datetime.strptime(most_current_date_str, "%Y-%m-%d").date()
    print("Most current date in data-raw/YYG: ", most_current_date_str)
    
    # create list of dates to fetch from YYG-repo ranging from most_current_date+1 till today
    date_list = [most_current_date + timedelta(days=x) for x in range(1, (today-most_current_date).days+1)]
    print("Try downloading data-raw for the following dates: ", ["".join(str(d)) for d in date_list])

    for date in date_list:

        DATE = str(date)
        FILENAME = DATE + '_global.csv'
        URL = 'https://raw.githubusercontent.com/youyanggu/covid19_projections/master/projections/combined/' + FILENAME
        PATH = DIR + FILENAME

        # download and safe raw file
        urllib.request.urlretrieve(URL, PATH)
        print("Successfully downloaded", FILENAME, "and saved it to", DIR)
        
        # catch URL Errors: 
        # try:
        #     urllib.request.urlretrieve(URL, PATH)
        #     print("Successfully downloaded", FILENAME, "and saved it to", DIR)
        # except:
        #     print("Error downloading", FILENAME, ". It probably doesn't exist in the repo yet.")