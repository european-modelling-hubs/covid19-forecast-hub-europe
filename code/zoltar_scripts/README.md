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

- Create json file with:
```
code/zoltar_scripts/create_validated_files_db.py
```
