import pandas as pd
from epiweeks import Week, Year

def read_saturdays(source, target, country):
    '''
    Loads the csv file specified by source, target and country, and then extracts only the data for each saturday.
    '''
    target_dict = {'cum_death': 'Cumulative Deaths',
                  'cum_case' : 'Cumulative Cases'}
    
    df = pd.read_csv('../../data-truth/{}/truth_{}-{}_{}.csv'.format(source, source, target_dict[target], country))
    df.date = pd.to_datetime(df.date)
    df.rename(columns = {'value': target}, inplace=True)
    df = df[df.date.dt.day_name() == 'Saturday']
    return df

def load_ecdc():
    '''
    Loads all relevant RKI, MZ and ECDC files.
    '''
    # ECDC data for Germany
    df_cd = read_saturdays('ECDC', 'cum_death', 'Germany')
    df_cc = read_saturdays('ECDC', 'cum_case', 'Germany')
    df1 = df_cd.merge(df_cc, on=['date', 'location', 'location_name'])
    
    # RKI data for Germany and Bundesländer
    df_cd = read_saturdays('RKI', 'cum_death', 'Germany')
    df_cc = read_saturdays('RKI', 'cum_case', 'Germany')
    df2 = df_cd.merge(df_cc, on=['date', 'location', 'location_name'])
    
    # Only use ECDC data until RKI data was available
    df1 = df1[df1.date < df2.date.iloc[0]]
    
    # MZ data for Poland and Voivodeships
    df_cd = read_saturdays('MZ', 'cum_death', 'Poland')
    df_cc = read_saturdays('MZ', 'cum_case', 'Poland')
    df3 = df_cd.merge(df_cc, on=['date', 'location', 'location_name'])

    df = pd.concat([df1, df2, df3]).reset_index(drop=True)
    
    return df

def load_jhu():
    '''
    Loads all relevant JHU files.
    '''
    df_cd = read_saturdays('JHU', 'cum_death', 'Germany')
    df_cc = read_saturdays('JHU', 'cum_case', 'Germany')
    df1 = df_cd.merge(df_cc, on=['date', 'location', 'location_name'])

    df_cd = read_saturdays('JHU', 'cum_death', 'Poland')
    df_cc = read_saturdays('JHU', 'cum_case', 'Poland')
    df2 = df_cd.merge(df_cc, on=['date', 'location', 'location_name'])

    df = pd.concat([df1, df2]).reset_index(drop=True)
    
    return df

def add_incidence(df):
    '''
    Computes incidence based on cumulative numbers.
    '''
    df[['inc_death', 'inc_case']] = df.groupby(['location'])[['cum_death', 'cum_case']].diff()
    df.dropna(inplace=True)
    df[['inc_death', 'inc_case']] = df[['inc_death', 'inc_case']].astype(int)
    df = df.reset_index(drop=True)
    return df

def add_epi_dates(df):
    '''
    Adds epi_week and epi_year to dataframe.
    '''
    df['epi_week'] = df.date.apply(lambda x: Week.fromdate(x).week)
    df['epi_year'] = df.date.apply(lambda x: Week.fromdate(x).year)

    df = df[['epi_week', 'epi_year', 'date', 'location', 'location_name', 
             'cum_death', 'inc_death', 'cum_case', 'inc_case']]
    return df

# ECDC
print('Transforming truth data to weekly format: ECDC.')
df = load_ecdc()
df = add_incidence(df)
df = add_epi_dates(df)

df.to_csv('../data/truth_to_plot_ecdc.csv', index=False)

# JHU
print('Transforming truth data to weekly format: JHU.')
df = load_jhu()
df = add_incidence(df)
df = add_epi_dates(df)

df.to_csv('../data/truth_to_plot_jhu.csv', index=False)