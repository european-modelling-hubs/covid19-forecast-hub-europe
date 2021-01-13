## Auto-download forecasts of Geneva-Team
## Jakob Ketterer
## November 2020

## Use daily JHU based forecasts after ECDC switched to weekly reporting interval
## Jakob Ketterer
## December 2020

import os
import urllib.request
from datetime import datetime, timedelta

if __name__ == "__main__":


    ############ logic to determine which files shall be downloaded

    # search date of most current prediction
    data_raw_dir = "./data-raw/Geneva"
    files = os.listdir(data_raw_dir)

    # determine latest deaths and cases forecast date already present in our repo
    deaths_prefix = "JHU_deaths_predictions_"
    cases_prefix = "JHU_cases_predictions_"
    
    deaths_file_list = sorted([f for f in files if f.startswith(deaths_prefix)], reverse=True)
    cases_file_list = sorted([f for f in files if f.startswith(cases_prefix)], reverse=True)
    
    if deaths_file_list:
        latest_deaths_fc_date_str = deaths_file_list[0].replace(deaths_prefix, "").strip(".csv")
    else:
        raise Exception("Set most_current_date_str manually!")
    
    if cases_file_list:
        latest_cases_fc_date_str = cases_file_list[0].replace(cases_prefix, "").strip(".csv")
    else:
        raise Exception("Set most_current_date_str manually!")
    
    latest_deaths_fc_date = datetime.strptime(latest_deaths_fc_date_str, "%Y_%m_%d")
    latest_cases_fc_date = datetime.strptime(latest_cases_fc_date_str, "%Y_%m_%d")

    # determine date up to which files should be downloaded
    today = datetime.today()
    weekday = today.weekday()

    if weekday == "0": 
        download_up_to_date = today
    else: # if not Monday, only download until Monday
        download_up_to_date = today - timedelta(weekday)

    assert download_up_to_date > latest_deaths_fc_date, "Required deaths forecast already exists in the repo!"
    assert download_up_to_date > latest_cases_fc_date, "Required cases forecast already exists in the repo!"

    # generate lists of dates to download
    deaths_date_list = [latest_deaths_fc_date + timedelta(days=x) for x in range(1, (download_up_to_date-latest_deaths_fc_date).days+1)]
    cases_date_list = [latest_cases_fc_date + timedelta(days=x) for x in range(1, (download_up_to_date-latest_cases_fc_date).days+1)]

    print("Trying to download death forecasts for the following dates: \n", ["".join(str(d.date())) for d in deaths_date_list])
    print("Trying to download case forecasts for the following dates: \n", ["".join(str(d.date())) for d in cases_date_list])


    ############ url generation and download of files
    # root url
    # root = "https://renkulab.io/gitlab/covid-19/covid-19-forecast/-/raw/master/data/ECDC/raw_prediction/" # ecdc
    root = "https://renkulab.io/gitlab/covid-19/covid-19-forecast/-/raw/master/data/JHU/raw_prediction/" # jhu


    # generate date specific death forecast url
    deaths_file_names = [deaths_prefix + date.strftime("%Y_%m_%d") + ".csv" for date in deaths_date_list]
    deaths_urls = [root + name for name in deaths_file_names]

    # generate date specific case forecast url
    cases_file_names = [cases_prefix + date.strftime("%Y_%m_%d") + ".csv" for date in cases_date_list]
    cases_urls = [root + name for name in cases_file_names]

    # create directory names
    deaths_dirs = [os.path.join(data_raw_dir, name) for name in deaths_file_names]
    cases_dirs = [os.path.join(data_raw_dir, name) for name in cases_file_names]

    # download and safe csv files
    urls = deaths_urls + cases_urls
    dir_names = deaths_dirs + cases_dirs
    dates_list = deaths_date_list + cases_date_list

    # download and safe csv files
    errors = False
    for url, dir_name, date in zip(urls, dir_names, dates_list):
        urllib.request.urlretrieve(url, dir_name)
        print(f"Downloaded forecast from {date.date()} and saved it to", dir_name)
    
    # catch URL Errors: 
    #     try:
    #         urllib.request.urlretrieve(url, dir_name)
    #         print(f"Downloaded forecast from {date.date()} and saved it to", dir_name)
    #     except urllib.error.URLError as e:
    #         print(f"URL-ERROR: Download failed for {date.date()}. The file probably doesn't exist in the Geneva repo yet OR the root URL may have changed.")
    #         errors = True

    # if errors:
    #     print("\n↯ Errors occured while downloading Geneva forecasts! See download history for details!\n")
    # else:
    #     print("\n✓ No errors occured\n")