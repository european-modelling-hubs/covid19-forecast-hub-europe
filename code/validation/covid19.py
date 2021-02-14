import datetime
import click
import pandas as pd
from pathlib import Path
from pyprojroot import here
from quantile_io import json_io_dict_from_quantile_csv_file

#
# functions specific to the COVID19 project
#

# get location codes as list
codes = list(pd.read_csv(here('./template/locations_eu.csv'))['iso2c'])

# set the range of valid targets
VALID_TARGET_NAMES = [f"{_} wk ahead inc death" for _ in range(0, 5)] + \
                     [f"{_} wk ahead inc case" for _ in range(0, 5)]

# set valid quantiles
VALID_QUANTILES = [0.010, 0.025, 0.050, 0.100, 0.150, 0.200, 0.250, 0.300,
                   0.350, 0.400, 0.450, 0.500, 0.550, 0.600, 0.650, 0.700,
                   0.750, 0.800, 0.850, 0.900, 0.950, 0.975, 0.990]


#
# validate_quantile_csv_file()
#


def validate_quantile_csv_file(csv_fp):
    """
    A simple wrapper of `json_io_dict_from_quantile_csv_file()` that tosses
    the json_io_dict and just prints validation error_messages.

    :param csv_fp: as passed to `json_io_dict_from_quantile_csv_file()`
    :return: error_messages: a list of strings
    """
    quantile_csv_file = Path(csv_fp)
    click.echo(f"* validating quantile_csv_file '{quantile_csv_file}'...")
    with open(quantile_csv_file) as ecdc_csv_fp:
        # toss json_io_dict:
        target_names = VALID_TARGET_NAMES

        _, error_messages = json_io_dict_from_quantile_csv_file(
                csv_fp = ecdc_csv_fp,
                valid_target_names = target_names,
                codes = codes,
                row_validator = covid19_row_validator,
                addl_req_cols = ['forecast_date', 'target_end_date'])

        if error_messages:
            return error_messages
        else:
            return "no errors"


#
# `json_io_dict_from_quantile_csv_file()` row validator
#

def covid19_row_validator(column_index_dict, row, codes):
    """
    Does COVID19-specific row validation. Notes:
    - Checks in order:
    1. location
    2. quantiles
    3. forecast_date and target_end_date (terminates if invalid)
    4. integer in "__ week ahead" (terminates if invalid)
    5. date alignment - week starting Monday ending Sunday

    - Expects these `valid_target_names` passed to
     `json_io_dict_from_quantile_csv_file()`:
         VALID_TARGET_NAMES VALID_SCENARIO_ID

    - Expects these `addl_req_cols` passed to
     `json_io_dict_from_quantile_csv_file()`:
         ['forecast_date', 'target_end_date']
    """

    from cdc_io import _parse_date  # avoid circular imports

    error_messages = []  # returned value. filled next

    # 1. validate location (ISO-2 code)
    location = row[column_index_dict['location']]
    if location not in codes:
        error_messages.append(f"Error > invalid ISO-2 location: {location!r}. row={row}")

    row_type = row[column_index_dict['type']]
    if row_type not in ["observed", "point", "quantile"]:
        print(row_type)
        error_messages.append(f"Error > invalid type: {row_type!r}. row={row}")

    # 2. validate quantiles (stored as strings, checked against numeric)
    quantile = row[column_index_dict['quantile']]
    if row[column_index_dict['type']] == 'quantile':
        try:
            if float(quantile) not in VALID_QUANTILES:
                error_messages.append(f"Error > invalid quantile: {quantile!r}. row={row}")
        except ValueError:
            pass  # ignore, caught by `json_io_dict_from_quantile_csv_file()`

    # 3. validate forecast_date and target_end_date date formats
    forecast_date = row[column_index_dict['forecast_date']]
    target_end_date = row[column_index_dict['target_end_date']]
    forecast_date = _parse_date(forecast_date)  # None if invalid format
    target_end_date = _parse_date(target_end_date)  # ""

    if not forecast_date or not target_end_date:
        error_messages.append(f"Error > invalid forecast_date or target_end_date format. forecast_date={forecast_date!r}. "
                              f"target_end_date={target_end_date}. row={row}")
        return error_messages  # terminate - depends on valid dates

    # 4. validate "__ week ahead" increment - must be an int
    target = row[column_index_dict['target']]
    try:
        step_ahead_increment = int(target.split('wk ahead')[0].strip())
    except ValueError:
        error_messages.append(f"Error > non-integer number of weeks ahead in 'wk ahead' target: {target!r}. row={row}")
        return error_messages  # terminate - depends on valid step_ahead_increment

    # 5. Validate date alignment (Sunday-Saturday epi week)
    weekday_to_sun_based = {i: i + 2 if i != 6 else 1 for i in range(7)}  # Sun=1, Mon=2, ..., Sat=7

    # 5.1 for x week ahead targets, weekday(target_end_date) should be a Sat
    if weekday_to_sun_based[target_end_date.weekday()] != 7:
       error_messages.append(f"target_end_date was not a Saturday: {target_end_date}. row={row}")
       return error_messages  # terminate - depends on valid target_end_date

    # 5.2 Forecast date should always be Mon
    if weekday_to_sun_based[forecast_date.weekday()] != 2:
            error_messages.append(f"Error > forecast_date was not a Monday, row={row}")

    # 5.3 For x week ahead targets, ensure x-week ahead forecast is for Sat
    #   - set exp_target_end_date - remove 1 wk (1 wk ahead is actually 0 wk ahead), then validate it
    weekday_diff = datetime.timedelta(days=(weekday_to_sun_based[target_end_date.weekday()] -
                                                weekday_to_sun_based[forecast_date.weekday()]))
    delta_days = weekday_diff + datetime.timedelta(days=(7 * step_ahead_increment - 7))
    exp_target_end_date = forecast_date + delta_days

    if target_end_date != exp_target_end_date:
        error_messages.append(f"Error > target_end_date was not the expected Saturday. forecast_date = {forecast_date}, "
                                  f"target_end_date={target_end_date}. Expected target end date = {exp_target_end_date}, "
                                  f"row={row}")

    # done!
    return error_messages
