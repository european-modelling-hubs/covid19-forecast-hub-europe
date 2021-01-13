import os
import sys
import glob
import warnings
import pandas as pd
from slack_alerts import *

# Load latest file 
list_of_files = glob.glob('../../data-truth/RKI/raw/*')
latest_file = max(list_of_files, key=os.path.getctime)

df = pd.read_csv(latest_file, compression='gzip')

if df.Bundesland.nunique() < 16:
    send_notification(title='RKI Data', message='Check Failed', details='Some states are missing.', 
                  link='https://github.com/KITmetricslab/covid19-forecast-hub-de/tree/master/data-truth/RKI', color='danger')
    sys.exit('Some states are missing. Try again later.')

else:
    send_notification(title='RKI Data', message='Check Passed', details='Data for all states available.', 
                  link='https://github.com/KITmetricslab/covid19-forecast-hub-de/tree/master/data-truth/RKI', color='good')
    
# Add column 'DatenstandISO'
df['DatenstandISO'] = pd.to_datetime(df.Datenstand.str.replace('Uhr', ''), dayfirst=True).astype(str)
#df['DatenstandISO'] = str((pd.to_datetime('today') - pd.Timedelta('1 days')).date())
    
for target in ['Deaths', 'Cases', 'Deaths by Age', 'Cases by Age']:
    print('Extracting data for cumulative {}.'.format(target.lower()))
    
    # Aggregation on state level (Bundesländer)
    if target == 'Deaths':
        # compute the sum for each date within each state
        df_agg = df[df.NeuerTodesfall >= 0].groupby(['DatenstandISO', 'Bundesland'])['AnzahlTodesfall'].sum().reset_index()
        df_agg.rename(columns = {'AnzahlTodesfall': 'value'}, inplace=True)
        
    elif target == 'Deaths by Age':
        # compute the sum for each date within each state and age group
        df_agg = df[df.NeuerTodesfall >= 0].groupby(['DatenstandISO', 'Bundesland', 'Altersgruppe'])['AnzahlTodesfall'].sum().reset_index()
        df_agg.rename(columns = {'AnzahlTodesfall': 'value'}, inplace=True)
        
    elif target == 'Cases':
        # compute the sum for each date within each state
        df_agg = df[df.NeuerFall >= 0].groupby(['DatenstandISO', 'Bundesland'])['AnzahlFall'].sum().reset_index()
        df_agg.rename(columns = {'AnzahlFall': 'value'}, inplace=True)
        
    elif target == 'Cases by Age':
        # compute the sum for each date within each state and age group
        df_agg = df[df.NeuerFall >= 0].groupby(['DatenstandISO', 'Bundesland', 'Altersgruppe'])['AnzahlFall'].sum().reset_index()
        df_agg.rename(columns = {'AnzahlFall': 'value'}, inplace=True)

    ### Add FIPS region codes - given by https://en.wikipedia.org/wiki/List_of_FIPS_region_codes_(G–I)#GM:_Germany.

    state_names = ['Baden-Württemberg', 'Bayern', 'Bremen', 'Hamburg', 'Hessen', 'Niedersachsen', 'Nordrhein-Westfalen', 'Rheinland-Pfalz',
    'Saarland', 'Schleswig-Holstein', 'Brandenburg', 'Mecklenburg-Vorpommern', 'Sachsen', 'Sachsen-Anhalt', 'Thüringen', 'Berlin']
    gm = ['GM0' + str(i) for i in range(1, 10)] + ['GM' + str(i) for i in range(10, 17)] 

    fips_codes = pd.DataFrame({'Bundesland':state_names, 'location':gm})

    # add fips codes to dataframe with aggregated data
    df_agg = df_agg.merge(fips_codes, left_on='Bundesland', right_on='Bundesland')

    ### Change location_name to English names

    fips_english = pd.read_csv('../../template/base_germany.csv')
    df_agg = df_agg.merge(fips_english, left_on='location', right_on='V1')
    
    
    if 'Age' in target:
        ### Rename columns and sort by date and location
        df_agg = df_agg.rename(columns={'DatenstandISO': 'date', 'V2':'location_name', 'Altersgruppe': 'age_group'})[
            ['date', 'location', 'location_name', 'age_group', 'value']].sort_values(['date', 'location']).reset_index(drop=True)
        df_germany = df_agg.groupby(['date', 'age_group'])['value'].sum().reset_index()

    else:
        ### Rename columns and sort by date and location
        df_agg = df_agg.rename(columns={'DatenstandISO': 'date', 'V2':'location_name'})[
            ['date', 'location', 'location_name', 'value']].sort_values(['date', 'location']).reset_index(drop=True)
        df_germany = df_agg.groupby('date')['value'].sum().reset_index()
    
    df_germany['location'] = 'GM'
    df_germany['location_name'] = 'Germany'

    # add data for Germany to dataframe with states
    df_cum = pd.concat([df_agg, df_germany]).sort_values(['date', 'location']).reset_index(drop=True)

    # save as csv    
    if target == 'Deaths':
        df_cum.to_csv('../../data-truth/RKI/processed/' + df_cum.date[0] + '_RKI_processed.csv', index=False)

    # Load Current Dataframe
    if 'Age' in target:
        df_all = pd.read_csv('../../data-truth/RKI/by_age/truth_RKI-Cumulative {}_Germany.csv'.format(target))
    else:
        df_all = pd.read_csv('../../data-truth/RKI/truth_RKI-Cumulative {}_Germany.csv'.format(target))

    # Add New Dataframe
    df_cum = pd.concat([df_all, df_cum])
    df_cum.reset_index(drop=True, inplace=True)

    # Drop duplicates - in case we accidentally load the same file twice.
    if 'Age' in target:
        df_cum.drop_duplicates(subset=['date', 'location', 'age_group'], keep='last', inplace=True)
    else:
        df_cum.drop_duplicates(subset=['date', 'location'], keep='last', inplace=True)

    # Incidence
    print('Extracting data for incident {}.'.format(target.lower()))
    df_inc = df_cum.copy()
    
    if 'Age' in target:
        df_inc.value = df_inc.groupby(['location', 'age_group'])['value'].diff()
    else:
        df_inc.value = df_inc.groupby(['location'])['value'].diff()

    df_inc.dropna(inplace=True)
    df_inc.value = df_inc.value.astype(int)
    
    if 'Age' in target:
        ### Export Cum. Deaths
        df_cum.to_csv('../../data-truth/RKI/by_age/truth_RKI-Cumulative {}_Germany.csv'.format(target), index=False)

        ### Export Inc. Deaths
        df_inc.to_csv('../../data-truth/RKI/by_age/truth_RKI-Incident {}_Germany.csv'.format(target), index=False)
        
    else:
        ### Export Cum. Deaths
        df_cum.to_csv('../../data-truth/RKI/truth_RKI-Cumulative {}_Germany.csv'.format(target), index=False)

        ### Export Inc. Deaths
        df_inc.to_csv('../../data-truth/RKI/truth_RKI-Incident {}_Germany.csv'.format(target), index=False)
