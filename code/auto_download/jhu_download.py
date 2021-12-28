import os
import glob
import pandas as pd

# dict matching target to download link
source_dict = {'Deaths': 'https://raw.githubusercontent.com/CSSEGISandData/COVID-19/master/csse_covid_19_data/' \
                   'csse_covid_19_time_series/time_series_covid19_deaths_global.csv',
               'Cases': 'https://raw.githubusercontent.com/CSSEGISandData/COVID-19/master/csse_covid_19_data/' \
                   'csse_covid_19_time_series/time_series_covid19_confirmed_global.csv'}

locs = pd.read_csv('data-locations/locations_eu.csv')

# extract data for given targets
for target in ['Deaths', 'Cases']:

    # contains data from all countries
    df = pd.read_csv(source_dict[target])

    # countries
    df = df[df['Country/Region'].isin(locs.location_name)]

    # drop provinces etc. (e.g. Bermuda)
    df = df[df['Province/State'].isnull()].copy()

    # reformat
    df.drop(columns=['Province/State', 'Lat', 'Long'], inplace=True)
    df.rename(columns={'Country/Region':'location_name'}, inplace=True)
    df = pd.melt(df, id_vars=['location_name'], var_name='date')
    df.date = pd.to_datetime(df.date)

    # add location code
    df = locs[['location', 'location_name']].merge(df, how='right')

    # compute incidence
    df.value = df.groupby('location').value.diff()
    df.dropna(inplace=True)
    df.value = df.value.astype(int)

    # export to csv
    df.to_csv('data-truth/JHU/truth_JHU-Incident {}.csv'.format(target), index=False)
