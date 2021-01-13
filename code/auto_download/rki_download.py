import pandas as pd

# Download data from https://www.arcgis.com/home/item.html?id=f10774f1c63e40168479a1feb6c7ca74
df = pd.read_csv('https://www.arcgis.com/sharing/rest/content/items/f10774f1c63e40168479a1feb6c7ca74/data')

# Save as compressed csv-file
date = pd.to_datetime('today').date()
df.to_csv('../../data-truth/RKI/raw/' + str(date) + '_RKI_raw.csv.gz', index=False, compression='gzip')
