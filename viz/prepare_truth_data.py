import pandas as pd
from epiweeks import Week, Year

df1 = pd.read_csv('data-truth/JHU/truth_JHU-Incident Deaths.csv')
df1.rename(columns={'value': 'inc_death'}, inplace=True)

df2 = pd.read_csv('data-truth/JHU/truth_JHU-Incident Cases.csv')
df2.rename(columns={'value': 'inc_case'}, inplace=True)

# merge cases and deaths into one dataframe
df = df1.merge(df2, on=['date', 'location', 'location_name'])

# add epi weeks for aggregation
df.date = pd.to_datetime(df.date)
df['epi_week'] = df.date.apply(lambda x: Week.fromdate(x).week)
df['epi_year'] = df.date.apply(lambda x: Week.fromdate(x).year)

# aggregate to weekly incidence
df = df.groupby(['location', 'location_name', 'epi_year', 'epi_week']).aggregate(
    {'date': max, 'inc_death': sum, 'inc_case':sum}).reset_index()

# only keep Saturdays
df = df[df.date.dt.day_name() == 'Saturday']

# reformat
df = df[['date', 'location', 'location_name', 'inc_case', 'inc_death']].sort_values(['date', 'location'])

# export
df.to_csv('truth_to_plot.csv', index=False)
