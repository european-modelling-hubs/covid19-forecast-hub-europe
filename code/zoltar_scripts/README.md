### File contents
 'compare_repo_to_zoltar.py',
 'convert_to_json.py',
 'create_validated_files_db.py',
 'shared_variables.py',
 'upload_all_forcasts.py',
 'upload_covid19_forecasts_to_zoltar.py',
 'upload_single_forecast.py',
 'upload_truth_to_zoltar.py',
 'upload_zoltar.py',
 'validated_file_db.json',
 'validated_file_db.p


### Upload to Zoltar
Complete sequence for conversion and upload running locally

```
# Set working directory
cd Github/covid19-forecast-hub-europe
# Detect modified files, convert to json and upload
python code/zoltar_scripts/upload_zoltar.py
```

Detection, validation, and upload takes ~10 seconds per forecast.


### Other tasks

 - Compare forecasts in the repo with those in Zoltar with:
```
 python code/zoltar_scripts/compare_repo_to_zoltar.py
 # zoltar = 335; repo = 561
 ```

- Create a json file with:
```
code/zoltar_scripts/create_validated_files_db.py
```
