import pandas as pd

print('Downloading data from ECDC.')
df = pd.read_csv('https://opendata.ecdc.europa.eu/covid19/casedistribution/csv')
#df = pd.read_excel('https://www.ecdc.europa.eu/sites/default/files/documents/COVID-19-geographic-disbtribution-worldwide.xlsx')

current_date = pd.to_datetime('today').date()
df.to_csv('../../data-truth/ECDC/raw/' + str(current_date) + '-Deaths-ECDC.csv', index=False)
