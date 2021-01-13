from pathlib import Path
import pandas as pd
import numpy as np
import warnings

warnings.simplefilter(action='ignore', category=FutureWarning)

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

path = Path('../../data-processed')

models = [f.name for f in path.iterdir() if not f.name.endswith('.csv')]

forecasts_to_exclude = pd.read_csv('../data/forecasts_to_exclude.csv').filename.to_list()

VALID_TARGETS = [f"{_} wk ahead inc death" for _ in range(-1, 5)] + \
                [f"{_} wk ahead cum death" for _ in range(-1, 5)] + \
                [f"{_} wk ahead inc case" for _ in range(-1, 5)] + \
                [f"{_} wk ahead cum case" for _ in range(-1, 5)] + \
                [f"{_} wk ahead curr ICU" for _ in range(-1, 5)]+ \
                [f"{_} wk ahead curr ventilated" for _ in range(-1, 5)]

VALID_QUANTILES = [0.025, 0.25, 0.75, 0.975]

dfs = []
for m in models:
    p = path/m
    forecasts = [f.name for f in p.iterdir() if '.csv' in f.name and f.name not in forecasts_to_exclude]
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
        (df['quantile'].isin(VALID_QUANTILES) | (df.type=='point') | (df.type=='observed'))].reset_index(drop=True)

df['timezero'] = df.forecast_date.apply(next_monday)

df = df[['forecast_date', 'target', 'target_end_date', 'location', 'type', 'quantile', 'value', 'timezero', 'model']]

### Adding truth data source for each model, location, date

truth_used = pd.read_csv('../data/truth_data_use_detailed.csv')

df_temp = df.merge(truth_used, left_on=['model', 'location'], right_on=['model', 'location'], how='left')#.dropna()

if df_temp.truth_data_source.isnull().any():
    missing = df_temp[df_temp.truth_data_source.isnull()].set_index(['model', 'location']).index.unique().values
    missing = str(missing).strip('[]').replace('\n', '')
    warnings.warn('The truth data sources are not defined in truth_data_use_detailed.csv for the following combinations: \n' + missing)

df_temp.forecast_date = pd.to_datetime(df_temp.forecast_date)
df_temp.starting_from = pd.to_datetime(df_temp.starting_from)

df_temp['quantile'].fillna('point', inplace=True)
id_cols = list(df_temp.columns[:-2]) # all but 'truth_data_source' and 'starting_from'

matched_source = df_temp.dropna().groupby(id_cols).apply(
    lambda x: x.loc[x.starting_from[x.starting_from <= x.forecast_date].idxmax()].truth_data_source) \
            .reset_index().rename(columns={0:'truth_data_source'})

matched_source['quantile'].replace({'point': None}, inplace=True)

df = df.merge(matched_source, how='left', left_on=id_cols, right_on=id_cols)

df['saturday0'] = df.timezero - pd.to_timedelta('2 days')

### Computing shift_ECDC (By how much do we need to shift the forecast value to make it fit to ECDC data?) and shift_JHU

truth_ecdc = pd.read_csv('../data/truth_to_plot_ecdc.csv')
truth_jhu = pd.read_csv('../data/truth_to_plot_jhu.csv')

truth_ecdc.set_index(['epi_week', 'epi_year', 'date', 'location', 'location_name'], inplace=True)
truth_jhu.set_index(['epi_week', 'epi_year', 'date', 'location', 'location_name'], inplace=True)

diff = (truth_ecdc - truth_jhu).fillna(0).astype(int).reset_index()
diff = pd.melt(diff, id_vars=diff.columns[:-4], value_vars=['cum_death', 'cum_case'])
diff = diff[['date', 'location', 'variable', 'value']].rename(columns={'variable': 'shift_target', 'value': 'shift_ECDC'})
diff.date = pd.to_datetime(diff.date)

# to indicate death/case
df['shift_target'] = df.target.str[11:].replace(' ', '_', regex=True).str.strip('_') # cum_death or cum_case

df = df.merge(diff, left_on=['saturday0', 'location', 'shift_target'], right_on=['date', 'location', 'shift_target'], how='left')

df.shift_ECDC = df.shift_ECDC.fillna(0).astype(int)
df['shift_JHU'] = -df.shift_ECDC
df.loc[df.truth_data_source == 'ECDC', 'shift_ECDC'] = 0
df.loc[df.truth_data_source == 'JHU', 'shift_JHU'] = 0
df.loc[df.truth_data_source.isnull(), 'shift_ECDC'] = np.nan
df.loc[df.truth_data_source.isnull(), 'shift_JHU'] = np.nan

df.loc[df.location.isin(['GM01', 'GM02', 'GM03', 'GM04', 'GM05', 'GM06', 'GM07',
       'GM08', 'GM09', 'GM10', 'GM11', 'GM12', 'GM13', 'GM14', 'GM15', 'GM16']), 'shift_JHU'] = np.nan

df.drop(columns=['saturday0', 'date', 'shift_target'], inplace=True)


# adding first_commit_date

commit_dates = pd.read_csv('../../code/validation/commit_dates.csv')

commit_dates['forecast_date'] = pd.to_datetime(commit_dates.filename.str[:10])
commit_dates['country'] = commit_dates.filename.transform(lambda x: x[11:].split('-')[0])
commit_dates['model_case'] = commit_dates.filename.transform(lambda x: x[11:].split('-', 1)[1][:-4])

GM = ['GM', 'GM01', 'GM02', 'GM03', 'GM04', 'GM05', 'GM06', 'GM07', 'GM08', 
      'GM09', 'GM10', 'GM11', 'GM12', 'GM13', 'GM14', 'GM15', 'GM16']

location_dict = dict()
for gm in GM:
    location_dict[gm] = 'Germany'
location_dict['PL'] = 'Poland'

df['country'] = df.location.replace(location_dict)

def append_case(x):
    if 'case' in x.target:
        return '-'.join([x.model, 'case'])
    else:
        return x.model

df['model_case'] = df.apply(lambda x: append_case(x), axis=1)

commit_dates.drop(columns=['filename', 'latest_commit'], inplace=True)

df = df.merge(commit_dates, how='left', left_on=['forecast_date', 'country', 'model_case'], 
              right_on=['forecast_date', 'country', 'model_case'])

df.drop(columns=['country', 'model_case'], inplace=True)
df.rename(columns={'first_commit': 'first_commit_date'}, inplace=True)

df.to_csv('../data/forecasts_to_plot.csv', index=False)
