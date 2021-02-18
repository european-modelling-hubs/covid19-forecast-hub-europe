from pathlib import Path
import pandas as pd
import numpy as np
import json

def next_monday(date):
    return pd.date_range(start=date, end=date + pd.offsets.Day(6), freq='W-MON')[0]

def get_relevant_dates(dates):
    wds = pd.Series(d.day_name() for d in dates)
    next_mondays = pd.Series(next_monday(d) for d in dates)
    relevant_dates = []
    
    for day in ['Monday', 'Sunday', 'Saturday', 'Friday', "Thursday", "Wednesday", "Tuesday"]:
        relevant_dates.extend(dates[(wds == day) &
                                   ~pd.Series(n in relevant_dates for n in next_mondays) &
                                   ~pd.Series(n in relevant_dates for n in (next_mondays - pd.offsets.Day(1))) &
                                   ~pd.Series(n in relevant_dates for n in (next_mondays - pd.offsets.Day(2))) &
                                   ~pd.Series(n in relevant_dates for n in (next_mondays - pd.offsets.Day(3))) &
                                   ~pd.Series(n in relevant_dates for n in (next_mondays - pd.offsets.Day(4))) &
                                   ~pd.Series(n in relevant_dates for n in (next_mondays - pd.offsets.Day(5)))
                                   ])
    return [str(r.date()) for r in relevant_dates] # return as strings

path = Path('data-processed')

models = [f.name for f in path.iterdir() if not f.name.endswith('.csv')]

VALID_TARGETS = [f"{_} wk ahead inc death" for _ in range(1, 5)] + \
                [f"{_} wk ahead inc case" for _ in range(1, 5)]

VALID_QUANTILES = [0.025, 0.25, 0.75, 0.975]

dfs = []
for m in models:
    p = path/m
    forecasts = [f.name for f in p.iterdir() if '.csv' in f.name]
    available_dates = pd.Series(pd.to_datetime(filename[:10]) for filename in forecasts)
    relevant_dates = get_relevant_dates(available_dates)
    relevant_forecasts = [f for f in forecasts if f[:10] in relevant_dates]
    for f in relevant_forecasts:
        df_temp = pd.read_csv(path/m/f)
        df_temp['model'] = m
        dfs.append(df_temp)

df = pd.concat(dfs)
df.forecast_date = pd.to_datetime(df.forecast_date)
df.target_end_date = pd.to_datetime(df.target_end_date)

df = df[df.target.isin(VALID_TARGETS) & 
        (df['quantile'].isin(VALID_QUANTILES) | (df.type=='point'))].reset_index(drop=True)

df['timezero'] = df.forecast_date.apply(next_monday)

if 'scenario_id' not in df.columns:
    df['scenario_id'] = 'forecast'

    df = df[['scenario_id','model','location','forecast_date','timezero','target',
         'target_end_date','type','quantile','value']].sort_values(
    ['scenario_id', 'model', 'forecast_date', 'target_end_date', 'location', 'target', 'type', 'quantile']).reset_index(drop=True)


### Adding last observations

df['saturday0'] = df.timezero - pd.to_timedelta('2 days')
df['merge_target'] = 'inc_' + df.target.str.split().str[-1]

truth = pd.read_csv('viz/truth_to_plot.csv')
truth.date = pd.to_datetime(truth.date)

truth = pd.melt(truth, id_vars=['date', 'location', 'location_name'], value_vars=['inc_death', 'inc_case'], 
               var_name='merge_target', value_name='truth')[['date', 'location', 'merge_target', 'truth']]

df = df.merge(truth, left_on=['location', 'saturday0', 'merge_target'], 
              right_on=['location', 'date', 'merge_target'], how='left')


# reuse first entry in each 'forecast group'
temp = df.groupby(['scenario_id', 'model', 'location', 'saturday0', 'merge_target']).first().reset_index()

# adjust relevant cells
temp.type = 'observed'
temp.loc[:, 'quantile'] = np.nan
temp.target = '0 wk ahead ' + temp.merge_target.replace('_', ' ', regex=True)
temp.value = temp.truth
temp.target_end_date = temp.saturday0

# concat newly added last observed values (0 wk ahead)
df = pd.concat([df, temp])

df = df.sort_values(['scenario_id', 'target_end_date', 'location', 'model', 'target', 'type', 'quantile']).reset_index(drop=True)


df = df[["scenario_id", "model", "location", "forecast_date", "timezero", "target", "target_end_date", "type", "quantile", "value"]]

df.to_csv('viz/forecasts_to_plot.csv', index=False)


### Export to .json

def createForecastDataItem(row):
    time_ahead, target = row['target'].split(' wk ahead ')
    target_type = ''
    if (target == 'inc death'):
        target_type = 'death'
    elif (target == 'inc case'):
        target_type = 'cases'
    else:
        raise NameError('Invalid target')
    
    return {
        'forecast_date': row['forecast_date'],
        'location': row['location'],
        'type': row['type'],
        'value': row['value'],
        'timezero': row['timezero'],
        'model': row['model'],
        'quantile': row['quantile'],
        'target': {
            'type': target_type,
            'time_ahead': int(time_ahead),
            'end_date': row['target_end_date']
        }
    }

df = df.replace({np.nan: None})
df.forecast_date = df.forecast_date.astype(str)
df.target_end_date = df.target_end_date.astype(str)
df.timezero = df.timezero.astype(str)

result = {}
for index, row in df.iterrows():
    item = createForecastDataItem(row)
    
    location = item['location']
    target_type = item['target']['type']
    if(location not in result):
        result[location] = {}
    if(target_type not in result[location]):
        result[location][target_type] = {'data': [], 'availableDates': []}
    
    if(item['timezero'] not in result[location][target_type]['availableDates']):
        result[location][target_type]['availableDates'].append(item['timezero'])
    result[location][target_type]['data'].append(item)
    
json.dump(result, open("viz/forecasts_to_plot.json","w"), indent=4, sort_keys=True)
