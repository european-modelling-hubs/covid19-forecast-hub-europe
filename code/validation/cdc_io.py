import csv
import datetime
from itertools import groupby

import pymmwr

#
# date formats
#
from quantile_io import POINT_PREDICTION_CLASS, BIN_DISTRIBUTION_CLASS


YYYY_MM_DD_DATE_FORMAT = '%Y-%m-%d'  # e.g., '2017-01-17'

#
# This file defines utilities to convert to the CDC's CSV format from Zoltar's native JSON one. NB: this is currently a
# duplicate of https://github.com/reichlab/forecast-repository/blob/master/utils/cdc.py , which also contains the unit
# tests.
#


#
# *.cdc.csv file variables
#

CDC_OBSERVED_ROW_TYPE = "Observed"
CDC_POINT_ROW_TYPE = 'Point'
CDC_QUANTILE_ROW_TYPE = "Quantile"
CDC_BIN_ROW_TYPE = 'Bin'
CDC_CSV_HEADER = ['location', 'target', 'type', 'unit', 'bin_start_incl', 'bin_end_notincl', 'value']

# This number is the internal reichlab standard: "We used week 30. I don't think this is a standardized concept outside
# of our lab though. We use separate concepts for a "season" and a "year". So, e.g. the "2016/2017 season" starts with
# EW30-2016 and ends with EW29-2017."
SEASON_START_EW_NUMBER = 30


#
# json_io_dict_from_cdc_csv_file()
#

def json_io_dict_from_cdc_csv_file(season_start_year, cdc_csv_file_fp):
    """
    Utility that extracts the two types of predictions found in CDC CSV files (PointPredictions and BinDistributions),
    returning them as a "JSON IO dict" suitable for loading into the database (see
    `load_predictions_from_json_io_dict()`). Note that the returned dict's "meta" section is empty.

    :param season_start_year
    :param cdc_csv_file_fp: an open cdc csv file-like object. the CDC CSV file format is documented at
        https://predict.cdc.gov/api/v1/attachments/flusight/flu_challenge_2016-17_update.docx
    :return a "JSON IO dict" (aka 'json_io_dict' by callers) that contains the three types of predictions. see docs for
        details
    """
    return {'meta': {},
            'predictions': _prediction_dicts_for_csv_rows(season_start_year,
                                                          _cleaned_rows_from_cdc_csv_file(cdc_csv_file_fp))}


def _cleaned_rows_from_cdc_csv_file(cdc_csv_file_fp):
    """
    Loads the rows from cdc_csv_file_fp, cleans them, and then returns them as a list. Does some basic validation,
    but does not check units and targets. This is b/c Units and Targets might not yet exist (if they're
    dynamically created by this method's callers). Does *not* skip bin rows where the value is 0.

    :param cdc_csv_file_fp: the *.cdc.csv data file to load
    :return: a list of rows: location_name, target_name, is_point_row, bin_start_incl, bin_end_notincl, value
    """
    csv_reader = csv.reader(cdc_csv_file_fp, delimiter=',')

    # validate header. must be 7 columns (or 8 with the last one being '') matching
    try:
        orig_header = next(csv_reader)
    except StopIteration:  # a kind of Exception, so much come first
        raise RuntimeError("empty file.")
    except Exception as exc:
        raise RuntimeError(f"error reading from cdc_csv_file_fp={cdc_csv_file_fp}. exc={exc}")

    header = orig_header
    if (len(header) == 8) and (header[7] == ''):
        header = header[:7]
    header = [h.lower() for h in [i.replace('"', '') for i in header]]
    if header != CDC_CSV_HEADER:
        raise RuntimeError(f"invalid header. header={header!r}, orig_header={orig_header!r}")

    # collect the rows. first we load them all into memory (processing and validating them as we go)
    rows = []
    for row in csv_reader:  # might have 7 or 8 columns, depending on whether there's a trailing ',' in file
        if (len(row) == 8) and (row[7] == ''):
            row = row[:7]

        if len(row) != 7:
            raise RuntimeError(f"Invalid row (wasn't 7 columns): {row!r}")

        # NB: 'unit' here is confusing because it's used two different ways:
        # - in Zoltar, what was locations is called units
        # - in cdc csv files there is both location and a 'unit' columns
        location_name, target_name, row_type, unit, bin_start_incl, bin_end_notincl, value = row  # unit column ignored

        # validate row_type
        row_type = row_type.lower()
        if (row_type != CDC_POINT_ROW_TYPE.lower()) and (row_type != CDC_BIN_ROW_TYPE.lower()):
            raise RuntimeError(f"row_type was neither '{CDC_POINT_ROW_TYPE}' nor '{CDC_BIN_ROW_TYPE}': {row_type!r}")
        is_point_row = (row_type == CDC_POINT_ROW_TYPE.lower())

        # _parse_value() handles non-numeric cases like 'NA' and 'none', which it turns into None. o/w it's a number
        bin_start_incl = _parse_value(bin_start_incl)
        bin_end_notincl = _parse_value(bin_end_notincl)
        value = _parse_value(value)
        rows.append([location_name, target_name, is_point_row, bin_start_incl, bin_end_notincl, value])

    return rows


def _prediction_dicts_for_csv_rows(season_start_year, rows):
    """
    json_io_dict_from_cdc_csv_file() helper that returns a list of prediction dicts for the 'predictions' section of the
    exported json. Each dict corresponds to either a PointPrediction or BinDistribution depending on each row in rows.
    Uses season_start_year to convert EWs to YYYY_MM_DD_DATE_FORMAT dates.

    Recall the seven cdc-project.json targets and their types:
    -------------------------+-------------------------------+-----------+-----------+---------------------
    Target name              | target_type                   | unit      | data_type | step_ahead_increment
    -------------------------+-------------------------------+-----------+-----------+---------------------
    "Season onset"           | Target.NOMINAL_TARGET_TYPE    | "week"    | date      | n/a
    "Season peak week"       | Target.DATE_TARGET_TYPE       | "week"    | text      | n/a
    "Season peak percentage" | Target.CONTINUOUS_TARGET_TYPE | "percent" | float     | n/a
    "1 wk ahead"             | Target.CONTINUOUS_TARGET_TYPE | "percent" | float     | 1
    "2 wk ahead"             | ""                            | ""        | ""        | 2
    "3 wk ahead"             | ""                            | ""        | ""        | 3
    "4 wk ahead"             | ""                            | ""        | ""        | 4
    -------------------------+-------------------------------+-----------+-----------+---------------------

    Note that the "Season onset" target is nominal and not date. This is due to how the CDC decided to represent the
    case when predicting no season onset, i.e., the threshold is not exceeded. This is done via a "none" bin where
    both Bin_start_incl and Bin_end_notincl are the strings "none" and not an EW week number. Thus, we have to store
    all bin starts as strings and not dates. At one point the lab was going to represent this case by splitting the
    "Season onset" target into two: "season_onset_binary" (a Target.BINARY that indicates whether there is an onset or
    not) and "season_onset_date" (a Target.DATE_TARGET_TYPE that is the onset date if "season_onset_binary" is true).
    But we dropped that idea and stayed with the original single nominal target.

    :param season_start_year
    :param rows: as returned by _cleaned_rows_from_cdc_csv_file():
        location_name, target_name, is_point_row, bin_start_incl, bin_end_notincl, value
    :return: a list of PointPrediction or BinDistribution prediction dicts
    """
    prediction_dicts = []  # return value
    rows.sort(key=lambda _: (_[0], _[1], _[2]))  # sorted for groupby()
    for (location_name, target_name, is_point_row), bin_start_end_val_grouper in \
            groupby(rows, key=lambda _: (_[0], _[1], _[2])):
        if target_name not in ['Season onset', 'Season peak week', 'Season peak percentage', '1 wk ahead', '2 wk ahead',
                               '3 wk ahead', '4 wk ahead', '1_biweek_ahead', '2_biweek_ahead', '3_biweek_ahead',
                               '4_biweek_ahead', '5_biweek_ahead']:  # all CDC and Thai targets
            raise RuntimeError(f"invalid target_name: {target_name!r}")

        # fill values for points and bins. NB: should only be one point row per location/target pair, but collect all
        # (i.e., don't validate here)
        point_values = []
        bin_cats, bin_probs = [], []
        for _, _, _, bin_start_incl, bin_end_notincl, value in bin_start_end_val_grouper:  # all 3 are numbers or None
            if is_point_row:
                point_value = _process_csv_point_row(season_start_year, target_name, value)
                point_values.append(point_value)
            else:
                bin_cat, bin_prob = _process_csv_bin_row(season_start_year, target_name, value,
                                                         bin_start_incl, bin_end_notincl)
                bin_cats.append(bin_cat)
                bin_probs.append(bin_prob)

        # add the actual prediction dicts
        if point_values:
            if len(point_values) > 1:
                raise RuntimeError(f"len(point_values) > 1: {point_values}")

            point_value = point_values[0]
            prediction_dicts.append({"unit": location_name,
                                     "target": target_name,
                                     'class': POINT_PREDICTION_CLASS,  # PointPrediction
                                     'prediction': {
                                         'value': point_value}})
        if bin_cats:
            prediction_dicts.append({"unit": location_name,
                                     "target": target_name,
                                     'class': BIN_DISTRIBUTION_CLASS,  # BinDistribution
                                     'prediction': {
                                         "cat": bin_cats,
                                         "prob": bin_probs}})
    return prediction_dicts


def _process_csv_point_row(season_start_year, target_name, value):
    # returns: point value for the args
    if target_name == 'Season onset':  # nominal target. value: None or an EW Monday date
        if value is None:
            return 'none'  # convert back from None to original 'none' input
        else:  # value is an EW week number (float)
            # note that value may be a fraction (e.g., 50.0012056690978, 4.96302456525203), so we round
            # the EW number to get an int, but this could cause boundary issues where the value is
            # invalid, either:
            #   1) < 1 (so use last EW in season_start_year), or:
            #   2) > the last EW in season_start_year (so use EW01 of season_start_year + 1)
            ew_week = round(value)
            if ew_week < 1:
                ew_week = pymmwr.mmwr_weeks_in_year(season_start_year)  # wrap back to previous EW
            elif ew_week > pymmwr.mmwr_weeks_in_year(season_start_year):  # wrap forward to next EW
                ew_week = 1
            monday_date = _monday_date_from_ew_and_season_start_year(ew_week, season_start_year)
            return monday_date.strftime(YYYY_MM_DD_DATE_FORMAT)
    elif target_name in ['1_biweek_ahead', '2_biweek_ahead', '3_biweek_ahead', '4_biweek_ahead',
                         '5_biweek_ahead']:  # thai
        return round(value)  # some point predictions are floats
    elif value is None:
        raise RuntimeError(f"None point values are only valid for 'Season onset' targets. "
                           f"target_name={target_name}")
    elif target_name == 'Season peak week':  # date target. value: an EW Monday date
        # same 'wrapping' logic as above to handle rounding boundaries
        ew_week = round(value)
        if ew_week < 1:
            ew_week = pymmwr.mmwr_weeks_in_year(season_start_year)  # wrap back to previous EW
        elif ew_week > pymmwr.mmwr_weeks_in_year(season_start_year):  # wrap forward to next EW
            ew_week = 1
        monday_date = _monday_date_from_ew_and_season_start_year(ew_week, season_start_year)
        return monday_date.strftime(YYYY_MM_DD_DATE_FORMAT)
    else:  # 'Season peak percentage', '1 wk ahead', '2 wk ahead', '3 wk ahead', '4 wk ahead', '1_biweek_ahead', '2_biweek_ahead', '3_biweek_ahead', '4_biweek_ahead',  # thai '5_biweek_ahead'
        return value


def _process_csv_bin_row(season_start_year, target_name, value, bin_start_incl, bin_end_notincl):
    # returns: 2-tuple for the args: (bin_cat, bin_prob)
    if target_name == 'Season onset':  # nominal target. start: None or an EW Monday date
        if (bin_start_incl is None) and (bin_end_notincl is None):  # "none" bin (probability of no onset)
            return 'none', value  # convert back from None to original 'none' input
        elif (bin_start_incl is not None) and (bin_end_notincl is not None):  # regular (non-"none") bin
            monday_date = _monday_date_from_ew_and_season_start_year(bin_start_incl, season_start_year)
            return monday_date.strftime(YYYY_MM_DD_DATE_FORMAT), value
        else:
            raise RuntimeError(f"got 'Season onset' row but not both start and end were None. "
                               f"bin_start_incl={bin_start_incl}, bin_end_notincl={bin_end_notincl}")
    elif (bin_start_incl is None) or (bin_end_notincl is None):
        raise RuntimeError(f"None bins are only valid for 'Season onset' targets. "
                           f"target_name={target_name}. bin_start_incl, bin_end_notincl: "
                           f"{bin_start_incl}, {bin_end_notincl}")
    elif target_name == 'Season peak week':  # date target. start: an EW Monday date
        monday_date = _monday_date_from_ew_and_season_start_year(bin_start_incl, season_start_year)
        return monday_date.strftime(YYYY_MM_DD_DATE_FORMAT), value
    else:  # 'Season peak percentage', '1 wk ahead', '2 wk ahead', '3 wk ahead', '4 wk ahead', '1_biweek_ahead', '2_biweek_ahead', '3_biweek_ahead', '4_biweek_ahead',  # thai '5_biweek_ahead'
        return bin_start_incl, value


#
# utility functions
#

def _parse_date(value_str):
    """
    Tries to parse value_str as a date in YYYY_MM_DD_DATE_FORMAT. Returns a datetime.date if valid, or None o/w
    """
    try:
        return datetime.datetime.strptime(value_str, YYYY_MM_DD_DATE_FORMAT).date()
    except ValueError:
        return None


def _parse_value(value_str):
    """
    Tries to parse value_str (a string) in this order: int, float, or date in YYYY_MM_DD_DATE_FORMAT. Returns None o/w.
    """
    try:
        return int(value_str)
    except ValueError:
        pass

    try:
        return float(value_str)
    except ValueError:
        pass

    return _parse_date(value_str)


#
# ---- CDC EW utilities ----
#

def _monday_date_from_ew_and_season_start_year(ew_week, season_start_year):
    """
    :param ew_week: an epi week from within a cdc csv forecast file. e.g., 1, 30, 52
    :param season_start_year
    :return: a datetime.date that is the Monday of the EW corresponding to the args
    """
    if ew_week < SEASON_START_EW_NUMBER:
        sunday_date = pymmwr.mmwr_week_to_date(season_start_year + 1, ew_week)
    else:
        sunday_date = pymmwr.mmwr_week_to_date(season_start_year, ew_week)
    return sunday_date + datetime.timedelta(days=1)
