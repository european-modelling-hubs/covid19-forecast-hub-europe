# Auto-download forecasts of Geneva-Team
# Jakob Ketterer, November 2020

import re
import os
import urllib.request
from dateutil.parser import parse
from datetime import datetime, timedelta

def get_filenames(date, root, format_str):
    '''get available csv files for dir specified by root link and date'''
    # open directory url
    dirpath = root + date
    url = urllib.request.urlopen(dirpath)
    str = url.read().decode('utf-8')

    # get filenames from html
    pattern = re.compile('/' + date + '/.*.csv"')
    finds = pattern.findall(str)
    filenames = [f.rstrip('"').replace("/" + date + "/","") for f in finds]
    # print(filenames)
    return filenames

def is_date(string, fuzzy=False):
    """
    Return whether the string can be interpreted as a date.

    :param string: str, string to check for date
    :param fuzzy: bool, ignore unknown tokens in string if True
    """
    try: 
        parse(string)
        return True

    except ValueError:
        return False

if __name__ == "__main__": 
    # most current date in raw
    format_str = "%Y-%m-%d"
    data_raw_dir = "./data-raw/USC"
    files = os.listdir(data_raw_dir)
    dates = list(filter(lambda x: is_date(x) == True, files))
    latest_date = datetime.strptime(dates[-1], format_str)
    
    # determine date up to which files should be downloaded
    today = datetime.today()
    weekday = today.weekday()

    if weekday == "0": 
        download_up_to_date = today
    else: # if not Monday, only download until Monday
        download_up_to_date = today - timedelta(weekday)

    assert download_up_to_date > latest_date, "Required forecasts already exists in the repo!"

    # generate lists of dates to download
    date_list = [latest_date + timedelta(days=x) for x in range(1, (download_up_to_date-latest_date).days+1)]
    if date_list:
        print("Trying to download forecasts for the following dates: \n", ["".join(str(d.date())) for d in date_list])
    else:
        print("Nothing to update. Repo either contains latest forecasts (do nothing) or empty date folders (delete folders). ")

    crawl_root = "https://github.com/scc-usc/ReCOVER-COVID-19/tree/master/results/historical_forecasts/"
    download_root = "https://raw.githubusercontent.com/scc-usc/ReCOVER-COVID-19/master/results/historical_forecasts/"

    for date in date_list:
        # get available csv files for date dir
        date_str = date.strftime(format_str)
        filenames = get_filenames(date_str, crawl_root, format_str)
        urls = [download_root + date_str + "/" + name for name in filenames]
        date_dir = os.path.join(data_raw_dir, date_str)
        dir_names = [os.path.join(date_dir, name) for name in filenames]

        # create new folder if not already exists
        if not os.path.exists(date_dir):
            os.makedirs(date_dir)
            print("Created directory:", date_dir)
        
        # download and save files
        for url, dir_name in zip(urls, dir_names):
            urllib.request.urlretrieve(url, dir_name)
            print("Downloaded and saved forecast to", dir_name)
            
            # catch URL Errors: 
            # try:
            #     urllib.request.urlretrieve(url, dir_name)
            #     print("Downloaded and saved forecast to", dir_name)
            # except:
            #     print("Download failed for", url)