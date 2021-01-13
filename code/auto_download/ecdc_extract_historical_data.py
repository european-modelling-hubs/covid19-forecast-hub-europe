import os
import glob
import pandas as pd

def preprocess_ecdc(filename, country_names=['Germany', 'Poland'], fips_codes=['GM', 'PL']):
    # contains data from all countries
    df_all = pd.read_csv(filename)

    df_all['date'] = pd.to_datetime(df_all.dateRep, dayfirst=True)
    
    last_date = str(df_all.date.max().date())
    
    # create folder for historical dta
    outdir = '../../data-truth/ECDC/historical/'
    if not os.path.exists(outdir):
        os.mkdir(outdir)
    
    # create folder for each date
    outdir = '../../data-truth/ECDC/historical/{}/'.format(last_date)
    if not os.path.exists(outdir):
        os.mkdir(outdir)
        
    print(last_date)
    
    # extract data for given targets
    for target in ['Deaths', 'Cases']:
        for country, code in zip(country_names, fips_codes):
            print('- Extracting data for {} in {}.'.format(target.lower(), country))

            # select one country
            df = df_all[df_all.countriesAndTerritories == country].copy()
            
            # adjust data format and naming
            df.rename(columns={'countriesAndTerritories' : 'location_name', target.lower() : 'value', }, inplace=True)
            df['location'] = code
            df = df[['date', 'location', 'location_name', 'value']].sort_values('date').reset_index(drop=True)
            
            # export incident target
            df.to_csv(outdir + 'truth_ECDC-Incident {}_{}.csv'.format(target, country), index=False)

            # compute cumulative target
            df.value = df.value.cumsum()
            
            # export cumulative target
            df.to_csv(outdir + 'truth_ECDC-Cumulative {}_{}.csv'.format(target, country), index=False)
            
            
list_of_files = glob.glob('../../data-truth/ECDC/raw/*')   

for f in list_of_files:
    preprocess_ecdc(f, ['Germany', 'Poland'], ['GM', 'PL'])
