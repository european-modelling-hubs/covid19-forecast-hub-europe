import sys
from pathlib import Path

p = Path('./data-processed/')

# all folders in data-processed
folders = [f for f in p.iterdir()]

for folder in folders:
    # all .csv files the given folder
    file_names = [f for f in folder.iterdir() if f.name.endswith('.csv')]

    # remove ending '.csv', remove date, split between country and model name
    model_names = [f.stem[11:] for f in file_names]

    # for each file check if the model name equals the folder name
    for i, m in enumerate(model_names):
        print('\nTesting ' + file_names[i].name + '...')
        if folder.name == m:
            print('✔ Forecast file name = Forecast file path (' +
                 m + ' = ' + folder.name  + ')')
        else:
            error_message = ("\nERROR: Forecast file name: " + file_names[i].name +
                        " does not match forecast file naming convention: " +
                        "<date>-<team>-<model>.csv")
            sys.exit(error_message)

