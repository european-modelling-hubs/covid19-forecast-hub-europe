We use Zoltar to store forecasts and metadata. This means all forecasts and metadata can be accessed via web download or programatically using R or Python.

- [View the ECDC European COVID-19 Forecast Hub on Zoltar](https://www.zoltardata.com/project/238)
- [Find out more about Zoltar](https://docs.zoltardata.com/)

----

### Hub developers

#### Local upload to Zoltar

First ensure you have set up  hub Zoltar access by adding `Z_USERNAME` and `Z_PASSWORD` as environment variables.

```
# Clone repo with validations submodule
git clone epiforecasts/covid19-forecast-hub-europe --recurse-submodules

# Set hub as working directory, e.g.
# cd covid19-forecast-hub-europe

# Detect modified files, convert to json and upload
python code/zoltar_scripts/upload_zoltar.py
```
Detection, validation, and upload takes ~10 seconds per forecast file.

#### Other tasks

 - Compare forecasts in the repo with those in Zoltar with:
```
 python code/zoltar_scripts/compare_repo_to_zoltar.py
 ```

- In case of problems connecting to Zoltar programatically, an alternative is to
create and save a json file of modified forecasts and upload to zoltar via web interface. Create this file with:
```
code/zoltar_scripts/create_validated_files_db.py
```
