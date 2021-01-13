import os
import glob
import pandas as pd

def preprocess_by_country(country_names=['Germany'], fips_codes=['GM']):
    
    # extract data for given targets
    for target in ['Deaths', 'Cases']:
        list_of_files = glob.glob('../../data-truth/JHU/raw/*')
        
        # only keep files with the respective target
        list_of_files = [f for f in list_of_files if target in f]

        # get latest file
        latest_file = max(list_of_files, key=os.path.getctime)

        # contains data from all countries
        df_all = pd.read_csv(latest_file)

        for country, code in zip(country_names, fips_codes):
            print('Extracting data for {} in {}.'.format(target.lower(), country))
            
            # select one country
            df = df_all[df_all['Country/Region'] == country].copy()
            
            # adjust data format and naming
            df.drop(columns=['Province/State', 'Country/Region', 'Lat', 'Long'], inplace=True)
            df = df.T.reset_index()
            df.columns=['date', 'value']
            df.date = pd.to_datetime(df.date)
            df['location'] = code
            df['location_name'] = country
            df = df[['date', 'location', 'location_name', 'value']].sort_values('date')
            
            # export cumulative target
            df.to_csv('../../data-truth/JHU/truth_JHU-Cumulative {}_{}.csv'.format(target, country), index=False)

            # compute incident target
            df_inc = df.copy()
            df_inc.value = df_inc.value.diff()
            df_inc = df_inc.iloc[1:]
            df_inc.value = df_inc.value.astype(int)
            
            # export incident target
            df_inc.to_csv('../../data-truth/JHU/truth_JHU-Incident {}_{}.csv'.format(target, country), index=False)

preprocess_by_country(['Germany', 'Poland'], ['GM', 'PL'])
