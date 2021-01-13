import pandas as pd
import numpy as np

df = pd.read_csv('../data/forecasts_to_plot.csv', parse_dates=['timezero'])

# load ecdc and jhu truth
ecdc = pd.read_csv('../data/truth_to_plot_ecdc.csv', parse_dates=['date'])
jhu = pd.read_csv('../data/truth_to_plot_jhu.csv', parse_dates=['date'])

# transform to long format
ecdc = pd.melt(ecdc, id_vars=ecdc.columns[:-4], value_vars=['cum_death', 'inc_death', 'cum_case', 'inc_case'], 
               var_name='merge_target', value_name='truth')[['date', 'location', 'merge_target', 'truth']]
ecdc['truth_data_source'] = 'ECDC'

jhu = pd.melt(jhu, id_vars=jhu.columns[:-4], value_vars=['cum_death', 'inc_death', 'cum_case', 'inc_case'], 
               var_name='merge_target', value_name='truth')[['date', 'location', 'merge_target', 'truth']]
jhu['truth_data_source'] = 'JHU'

# store in one dataframe
truth = pd.concat([ecdc, jhu])


# merge forecasts_to_plot and truth
df['saturday0'] = df.timezero - pd.to_timedelta('2 days')
df['merge_target'] = df.target.str[11:].replace(' ', '_', regex=True).str.strip('_')

df = df.merge(truth, left_on=['truth_data_source', 'location', 'saturday0', 'merge_target'], 
              right_on=['truth_data_source', 'location', 'date', 'merge_target'], how='left')

# find 'forecast groups' without 0 wk ahead
temp = df.groupby(['model', 'location', 'saturday0', 'merge_target']).filter(lambda x: ~x.target.str.startswith('0 wk').any())

# reuse first entry in each 'forecast group'
temp = temp.groupby(['model', 'location', 'saturday0', 'merge_target']).first().reset_index()

# adjust relevant cells
temp.type = 'observed'
temp.loc[:, 'quantile'] = np.nan
temp.target = '0 wk ahead ' + temp.merge_target.replace('_', ' ', regex=True)
temp.value = temp.truth
temp.target_end_date = temp.saturday0

# concat old forecasts_to_plot and newly added last observed values (0 wk ahead)
df_new = pd.concat([df, temp])

# sort models and adjust format
models = df_new.model.unique().tolist()
models.sort(key=str.casefold)

ensembles = ['KITCOVIDhub-mean_ensemble', 'KITCOVIDhub-median_ensemble', 'KITCOVIDhub-inverse_wis_ensemble']
baselines = [m for m in models if 'baseline' in m]
individual_models = [m for m in models if m not in ensembles + baselines ]

models = ensembles + individual_models +  baselines

df_new.model = pd.Categorical(df_new.model, models, ordered=True)
df_new = df_new.sort_values(['model', 'forecast_date', 'target_end_date', 'location', 'target', 'type', 'quantile']).reset_index(drop=True)

df_new = df_new[['forecast_date', 'target', 'target_end_date', 'location', 'type',
       'quantile', 'value', 'timezero', 'model', 'truth_data_source',
       'shift_ECDC', 'shift_JHU', 'first_commit_date']]

# export csv
df_new.to_csv('../data/forecasts_to_plot.csv', index=False)