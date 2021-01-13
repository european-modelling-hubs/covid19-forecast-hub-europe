# Setup

import pandas as pd

# Load All Files

### Get filenames from repo

# We first retrieve the filenames of all files listed in the repository:

import requests

user = "ard-data"
repo = "2020-rki-archive"

url = "https://api.github.com/repos/{}/{}/git/trees/master?recursive=1".format(user, repo)
r = requests.get(url)
res = r.json()

# We only keep the files in the folder data/2_parsed

files_parsed = [file["path"] for file in res["tree"] if file["path"].startswith("data/2_parsed/")]

# the first 5 files in the folder data/2_parsed
files_parsed[:5]

files_parsed[-1]

### Retrieve latest file from data/2_parsed

df = pd.read_json('https://github.com/ard-data/2020-rki-archive/raw/master/' + files_parsed[-1], compression='bz2')

df.head()

# Cleaning

# If the column 'DatenstandISO' is missing, we infer it from 'Datenstand'.

if 'DatenstandISO' not in df.columns:
    df['DatenstandISO'] = pd.to_datetime(df.Datenstand.str.replace('Uhr', '')).astype(str)

# Aggregation on state level (Bundesländer)

# compute the sum for each date within each state
df_agg = df[df.NeuerTodesfall >= 0].groupby(['DatenstandISO', 'Bundesland'])['AnzahlTodesfall'].sum().reset_index()

df_agg

### Add FIPS region codes

# We add the corresponding region codes for each state given by https://en.wikipedia.org/wiki/List_of_FIPS_region_codes_(G–I)#GM:_Germany.

state_names = ['Baden-Württemberg', 'Bayern', 'Bremen', 'Hamburg', 'Hessen', 'Niedersachsen', 'Nordrhein-Westfalen', 'Rheinland-Pfalz',
'Saarland', 'Schleswig-Holstein', 'Brandenburg', 'Mecklenburg-Vorpommern', 'Sachsen', 'Sachsen-Anhalt', 'Thüringen', 'Berlin']

gm = ['GM0' + str(i) for i in range(1, 10)] + ['GM' + str(i) for i in range(10, 17)] 

fips_codes = pd.DataFrame({'Bundesland':state_names, 'location':gm})

# add fips codes to dataframe with aggregated data
df_agg = df_agg.merge(fips_codes, left_on='Bundesland', right_on='Bundesland')

### Change location_name to English names

fips_english = pd.read_csv('../../template/base_germany.csv')

df_agg = df_agg.merge(fips_english, left_on='location', right_on='V1')

### Rename columns and sort by date and location

df_agg = df_agg.rename(columns={'DatenstandISO': 'date', 'AnzahlTodesfall': 'value', 'V2':'location_name'})[
    ['date', 'location', 'location_name', 'value']].sort_values(['date', 'location']).reset_index(drop=True)


df_germany = df_agg.groupby('date')['value'].sum().reset_index()
df_germany['location'] = 'GM'
df_germany['location_name'] = 'Germany'

# add data for Germany to dataframe with states
df_cum = pd.concat([df_agg, df_germany]).sort_values(['date', 'location']).reset_index(drop=True)

# Load Current Dataframe

df_all = pd.read_csv('../../data-truth/RKI/truth_cum_deaths.csv')

# Add New Dataframe

df_cum = pd.concat([df_all, df_cum])
df_cum.reset_index(drop=True, inplace=True)

# Drop duplicates - in case we accidentally load the same file twice.

df_cum.drop_duplicates(inplace=True)

# Incidence

# We compute the incident deaths as the difference to the previous day.

df_inc = df_cum.copy()

df_inc.value = df_inc.groupby(['location'])['value'].diff()
df_inc.dropna(inplace=True)
df_inc.value = df_inc.value.astype(int)

### Export Cum. Deaths

df_cum.to_csv('../../data-truth/RKI/truth_cum_deaths.csv', index=False)

### Export Inc. Deaths

df_inc.to_csv('../../data-truth/RKI/truth_inc_deaths.csv', index=False)