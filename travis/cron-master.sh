#!/usr/bin/env bash
pip3 install pandas

cd ./code/auto_download

# update and process ECDC truth
python3 ./ecdc_download.py
sleep 5
python3 ./ecdc_preprocessing.py
echo "ECDC done"

# update and process jhu truth
python3 ./jhu_download.py
sleep 5
python3 ./jhu_preprocessing.py
echo "JHU done"

# update RKI data
python3 ./rki_download.py
python3 ./rki_update.py
echo "RKI done"

# update Poland data
python3 ./truth_poland_p.py
echo "Poland done"

# update DIVI data
python3 ./divi_download.py
cd ../../data-truth/DIVI
python3 ./process_data.py
echo "DIVI done"

# update commit dates
cd ../validation
python3 ./get_commit_dates.py
echo "file dates done"

# update Shiny data
cd ../../app_forecasts_de/code
python3 ./data_preparation.py
python3 ./prepare_truth_data.py
python3 ./add_last_observed.py
echo "Shiny done"

# update Readme image
cd ../../code/visualization
Rscript ./plot_current_forecasts.R
echo "Image done"

# validate truth
cd ../validation
python3 ./validate_truth.py
python3 ./check_truth.py
echo "All checks executed"

# Evaluate forecasts
cd ../../evaluation
Rscript ./evaluate_forecasts.R
echo "executed forecast evaluation"

cd ../../
