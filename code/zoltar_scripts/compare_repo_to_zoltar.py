from zoltpy import util
import os

# 1 Meta info 

## Set connections to Zoltar project and github repo
project_name = 'ECDC European COVID-19 Forecast Hub'
project_obj = None
project_timezeros = []
conn = util.authenticate()
url = 'https://github.com/epiforecasts/covid19-forecast-hub-europe/tree/master/data-processed/'

## Get Zoltar project with all times, models, model names, forecasts
project_obj = [project for project in conn.projects if project.name == project_name][0]
project_timezeros = [timezero.timezero_date for timezero in project_obj.timezeros]
models = [model for model in project_obj.models]
model_names = [model.name for model in models]

# 2 Get forecasts
zoltar_forecasts = []
repo_forecasts = []

## Get all forecasts in Zoltar
for model in models:
    existing_forecasts = [forecast.source for forecast in model.forecasts]
    zoltar_forecasts.extend(existing_forecasts)
    
## Get all forecasts in repo
for directory in [model for model in os.listdir('./data-processed/') if "." not in model]:
    forecasts = [forecast for forecast in os.listdir('./data-processed/'+directory+"/") if ".csv" in forecast]
    repo_forecasts.extend(forecasts)
    
# 3 Return mismatches
print("number of forecasts in zoltar: " + str(len(zoltar_forecasts)))
print("number of forecasts in repo: " + str(len(repo_forecasts)))
for forecast in zoltar_forecasts:
    if forecast not in repo_forecasts:
        print("This forecast in zoltar but not in repo "+forecast)
print()
print('----------------------------------------------------------')
print()
for forecast in repo_forecasts:
    if forecast not in zoltar_forecasts:
        print("This forecast in repo but not in zoltar "+forecast)