# Auto-download forecasts of UCLA-Team
# Jakob Ketterer, November 2020

import os
import urllib.request
from datetime import datetime, timedelta

if __name__ == "__main__":

    ############ logic to determine which files shall be downloaded

    # search date of most current prediction
    data_raw_dir = "./data-raw/UCLA-SuEIR"
    files = os.listdir(data_raw_dir)

    # determine latest forecast date already present in our repo
    prefix = "pred_world_"

    file_list = sorted([f for f in files if f.startswith(prefix)], reverse=True)
    
    if file_list:
        # manually add current year
        cur_year = str(datetime.today().year)
        latest_fc_date_str = cur_year + "-" + file_list[0].replace(prefix, "").strip(".csv")
    else:
        raise Exception("Set most_current_date_str manually!")
    
    
    latest_fc_date = datetime.strptime(latest_fc_date_str, "%Y-%m-%d")

    # determine date up to which files should be downloaded
    download_up_to_date = datetime.today()

    assert download_up_to_date > latest_fc_date, "Required forecasts already exists in the repo!"

    # generate lists of dates to download
    date_list = [latest_fc_date + timedelta(days=x) for x in range(1, (download_up_to_date-latest_fc_date).days+1)]
    
    # restrict on Sundays (UCLA forecasts are generated on Sundays only)
    date_list = [date for date in date_list if date.weekday() == 6]
    print("Trying to download forecasts for the following dates: ", ["".join(str(d.date())) for d in date_list])

    ############ url generation and download of files
    # root url
    root = "https://raw.githubusercontent.com/uclaml/ucla-covid19-forecasts/master/projection_result/"

    # generate date specific death forecast url
    # reformat date
    file_names = [prefix + date.strftime("%m-%d") + ".csv" for date in date_list]
    urls = [root + name for name in file_names]


    # create directory names
    dir_names = [os.path.join(data_raw_dir, name) for name in file_names]

    # download and safe csv files
    errors = False
    for url, dir_name, date in zip(urls, dir_names, date_list):
        urllib.request.urlretrieve(url, dir_name)
        print(f"Downloaded forecast from {date.date()} and saved it to", dir_name)
        
    # catch URL Errors: 
    #     try:
    #         urllib.request.urlretrieve(url, dir_name)
    #         print(f"Downloaded forecast from {date.date()} and saved it to", dir_name)
    #     except urllib.error.URLError as e:
    #         print(f"URL-ERROR: Download failed for {date.date()}. The file probably doesn't exist in the UCLA repo yet.")
    #         errors = True

    # if errors:
    #     print("\n↯ Errors occured while downloading UCLA forecasts! See download history for details!\n")
    # else:
    #     print("\n✓ No errors occured\n")