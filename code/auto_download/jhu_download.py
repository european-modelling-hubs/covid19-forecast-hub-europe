import pandas as pd

current_date = pd.to_datetime('today').date()

# download death data
print('Downloading death data.')
df = pd.read_csv('https://raw.githubusercontent.com/CSSEGISandData/COVID-19/master/csse_covid_19_data/' \
                 'csse_covid_19_time_series/time_series_covid19_deaths_global.csv')

df.to_csv('../../data-truth/JHU/raw/' + str(current_date) + '-Deaths-JHU.csv', index=False)

# download case data
print('Downloading case data.')
df = pd.read_csv('https://raw.githubusercontent.com/CSSEGISandData/COVID-19/master/csse_covid_19_data/csse_covid_19_time_series/time_series_covid19_confirmed_global.csv')

df.to_csv('../../data-truth/JHU/raw/' + str(current_date) + '-Cases-JHU.csv', index=False)