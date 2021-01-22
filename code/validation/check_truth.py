"""
Modified 2021-01-22 by Kath

Original: check_truth.py in Germany/Poland forecast hub repo
Modifications:
    - Replace RKI / MZ truth data with ECDC
    - Replace column name 'date' with 'week_start'
Note: some unused infrastructure left in to permit adding future truth datasets
"""

import pandas as pd
import glob
from datetime import datetime

# all possible locations
locations = dict()
locations['ECDC'] = pd.read_csv('../../data-truth/ECDC/truth_ECDC-Incident Deaths.csv').location_name.unique()

with open('check_truth.txt', 'a', encoding='utf-8') as txtfile:
    
    latest_check = 'Latest check of truth data: {}\n'.format(datetime.now().strftime("%Y-%m-%d %H:%M:%S"))
    txtfile.write(latest_check + '\n')
    
    error_count = 0

    for source in ['ECDC']:
        list_of_files = glob.glob('../../data-truth/{}/*Incident*.csv'.format(source))

        for file in list_of_files:
           
            df = pd.read_csv(file, parse_dates=['week_start'])
            latest_date = df.week_start.max()
            latest_data = df[df.week_start == latest_date]

            missing_locations = [l for l in locations[source] if l not in latest_data.location_name.unique()]
            negative_incidence = latest_data[latest_data.value < 0].location_name.values
                        
            if (len(missing_locations) > 0) or (len(negative_incidence) > 0):
                error_count += 1
                warning = 'WARNING\nError(s) in \'{}\' at {}:\n'.format(file.split('\\')[1], str(latest_date.date()))
                txtfile.write(warning + '\n')

                if len(missing_locations) > 0:
                    warning = '- The following locations are missing: {}.\n'.format(str(missing_locations))
                    txtfile.write(warning + '\n')

                if len(negative_incidence) > 0:
                    warning = '- Negative incidence in the following locations: {}.\n'.format(str(negative_incidence))
                    txtfile.write(warning + '\n')
            
    if error_count == 0:
        warning = 'No errors detected.\n'
        txtfile.write(warning + '\n')