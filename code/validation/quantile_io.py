import csv
import math
from collections import defaultdict
import datetime
from itertools import groupby


#
# project-independent variables
#

# prediction classes for use in "JSON IO dict" conversion
BIN_DISTRIBUTION_CLASS = 'bin'
NAMED_DISTRIBUTION_CLASS = 'named'
POINT_PREDICTION_CLASS = 'point'
SAMPLE_PREDICTION_CLASS = 'sample'
QUANTILE_PREDICTION_CLASS = 'quantile'
OBS_PREDICTION_CLASS = "obs"

# quantile csv I/O

REQUIRED_COLUMNS = ('location', 'target', 'type', 'quantile', 'value')
POSSIBLE_COLUMNS = ['location', 'target', 'type', 'quantile', 'value', 'target_end_date', 'forecast_date', 'location_name', 'scenario']


#
# Note: The following code is a somewhat temporary solution to validation during COVID-19 crunch time. As such, we
# hard-code target information: all targets are: "type": "discrete", "is_step_ahead": true. Also, all validation
# functions return lists of error messages, formatted for output during processing. Processing continues as long as
# possible (ideally the entire file) so that all errors can be reported to the user. however, catastrophic errors (such
# as an invalid header) must terminate immediately.
# todo refactor this later
#


#
# json_io_dict_from_quantile_csv_file()
#

def json_io_dict_from_quantile_csv_file(csv_fp, valid_target_names, codes, row_validator=None, addl_req_cols=()):
    """
    Utility that validates and extracts the two types of predictions found in quantile CSV files (PointPredictions and
    QuantileDistributions), returning them as a "JSON IO dict" suitable for loading into the database (see
    `load_predictions_from_json_io_dict()`). Note that the returned dict's "meta" section is empty. This function is
    flexible with respect to the inputted column contents and order: It allows the required columns to be in any
    position, and it ignores all other columns. The required columns are:

    - `target`: a unique id for the target
    - `location`: translated to Zoltar's `unit` concept.
    - `type`: one of either `point` or `quantile`
    - `quantile`: a value between 0 and 1 (inclusive), representing the quantile displayed in this row. if
        `type=="point"` then `NULL`.
    - `value`: a numeric value representing the value of the cumulative distribution function evaluated at the specified
        `quantile`

    :param csv_fp: an open quantile csv file-like object. the quantile CSV file format is documented at
        https://docs.zoltardata.com/
    :param valid_target_names: list of strings of valid targets to validate against
    :param codes: unit codes i.e. location codes (e.g. FIPS in US, ISO-3 in EU)
    :param row_validator: an optional function of these args that is run to perform additional project-specific
        validations. returns a list of `error_messages`.
        - column_index_dict: as returned by _validate_header(): a dict that maps column_name -> its index in header (row)
        - row: the raw row being validated. NB: the order of columns is variable, but callers can use column_index_dict
            to index into row
    :param addl_req_cols: an optional list of strings naming columns in addition to REQUIRED_COLUMNS that are required
    :return 2-tuple: (json_io_dict, error_messages) where the former is a "JSON IO dict" (aka 'json_io_dict' by callers)
        that contains the two types of predictions. see https://docs.zoltardata.com/ for details. json_io_dict is None
        if there were errors
    """
    # load and validate the rows (validation step 1/2). error_messages is one of the the return values (filled next)
    rows, error_messages = _validated_rows_for_quantile_csv(csv_fp, valid_target_names, codes, row_validator, addl_req_cols)

    if error_messages:
        return None, error_messages  # terminate processing b/c we can't proceed to step 1/2 with invalid rows

    # step 1/3: process rows, validating and collecting point and quantile values for each row. then add the actual
    # prediction dicts. each point row has its own dict, but quantile rows are grouped into one dict.
    prediction_dicts = []  # the 'predictions' section of the returned value. filled next

    rows.sort(key=lambda _: (_[0], _[1], _[2]))  # sorted for groupby()

    for (target_name, location, is_point_row), quantile_val_grouper in \
            groupby(rows, key=lambda _: (_[0], _[1], _[2])):
        # fill values for points and bins
        point_values = []
        quant_quantiles, quant_values = [], []
        for _, _, _, quantile, value in quantile_val_grouper:
            if is_point_row:
                point_values.append(value)  # quantile is NA

            else:
                quant_quantiles.append(quantile)
                quant_values.append(value)

        # add the actual prediction dicts
        for point_value in point_values:
            prediction_dicts.append({'unit': location,
                                     'target': target_name,
                                     'class': POINT_PREDICTION_CLASS,  # PointPrediction
                                     'prediction': {
                                         'value': point_value}})
        if quant_quantiles:
            prediction_dicts.append({'unit': location,
                                     'target': target_name,
                                     'class': QUANTILE_PREDICTION_CLASS,  # QuantileDistribution
                                     'prediction': {
                                         'quantile': quant_quantiles,
                                         'value': quant_values}})

    # step 2/3: validate individual prediction_dicts. along the way fill loc_targ_to_pred_classes, which helps to do
    # "prediction"-level validations at the end of this function. it maps 2-tuples to a list of prediction classes
    # (strs):
    loc_targ_to_pred_classes = defaultdict(list)  # (unit_name, target_name) -> [prediction_class1, ...]
    for prediction_dict in prediction_dicts:
        unit_name = prediction_dict['unit']
        target_name = prediction_dict['target']

        # Hardcoded way around problem with -1 and 0

        prediction_class = prediction_dict['class']
        loc_targ_to_pred_classes[(unit_name, target_name)].append(prediction_class)
        if prediction_dict['class'] == QUANTILE_PREDICTION_CLASS:
            pred_dict_error_messages = _validate_quantile_prediction_dict(prediction_dict)  # raises o/w
            error_messages.extend(pred_dict_error_messages)

    # step 3/3: do "prediction"-level validations
    # validate: "Within a Prediction, there cannot be more than 1 Prediction Element of the same type".
    duplicate_unit_target_tuples = [(unit, target, pred_classes) for (unit, target), pred_classes
                                    in loc_targ_to_pred_classes.items()
                                    if len(pred_classes) != len(set(pred_classes))]
    if duplicate_unit_target_tuples:
        error_messages.append(f"Within a Prediction, there cannot be more than 1 Prediction Element of the same class. "
                              f"Found these duplicate unit/target/classes tuples: {duplicate_unit_target_tuples}")

    # validate: "There must be exactly one point prediction for each location/target pair"
    unit_target_point_count = [(unit, target, pred_classes.count('point')) for (unit, target), pred_classes
                               in loc_targ_to_pred_classes.items()
                               if pred_classes.count('point') != 1]
    if unit_target_point_count:
        error_messages.append(f"There must be exactly one point prediction for each location/target pair. Found these "
                              f"unit, target, point counts tuples did not have exactly one point: "
                              f"{unit_target_point_count}")

    # done
    return {'meta': {}, 'predictions': prediction_dicts}, error_messages


def _validated_rows_for_quantile_csv(csv_fp, valid_target_names, fips_codes,  row_validator, addl_req_cols):
    """
    `json_io_dict_from_quantile_csv_file()` helper function.

    :return: 2-tuple: (validated_rows, error_messages)
    """
    from cdc_io import CDC_POINT_ROW_TYPE, CDC_OBSERVED_ROW_TYPE, CDC_QUANTILE_ROW_TYPE, _parse_value  # avoid circular imports


    error_messages = []  # list of strings. return value. set below if any issues

    csv_reader = csv.reader(csv_fp, delimiter=',')
    header = next(csv_reader)
    try:
        column_index_dict = _validate_header(header, addl_req_cols)
    except RuntimeError as re:
        error_messages.append(re.args[0])
        return [], error_messages  # terminate processing

    error_targets = set()  # output set of invalid target names

    rows = []  # list of parsed and validated rows. filled next
    for row in csv_reader:
        if len(row) != len(header):
            error_messages.append(f"invalid number of items in row. len(header)={len(header)} but len(row)={len(row)}. "
                                  f"row={row}")
            return [], error_messages  # terminate processing

        # do optional application-specific row validation. NB: error_messages is modified in-place as a side-effect
        location, target_name, row_type, quantile, value = [row[column_index_dict[column]] for column in
                                                            REQUIRED_COLUMNS]
        if row_validator:
            error_messages.extend(row_validator(column_index_dict, row, fips_codes))

        # validate target_name
        if target_name not in valid_target_names:
            error_targets.add(target_name)

        # validate quantile and value
        row_type = row_type.lower()
        is_point_row = (row_type == CDC_POINT_ROW_TYPE.lower())
        is_observed_row = (row_type == CDC_OBSERVED_ROW_TYPE.lower())
        is_quantile_row = (row_type == CDC_QUANTILE_ROW_TYPE.lower())

        if is_observed_row:
            is_point_row = is_observed_row
       # print(is_observed_row)
        quantile = _parse_value(quantile)  # None if not an int, float, or Date. float might be inf or nan
        value = _parse_value(value)  # ""
        if not (is_point_row or is_observed_row) and ((quantile is None)  or
                                   (isinstance(quantile, datetime.date)) or
                                   (not math.isfinite(quantile)) or  # inf, nan
                                   not (0 <= quantile <= 1)) and is_quantile_row:
            error_messages.append(f"entries in the `quantile` column must be an int or float in [0, 1]: "
                                  f"{quantile}. row={row}")
        elif is_point_row and ((value is None) or
                               (isinstance(value, datetime.date)) or
                               (not math.isfinite(value))):  # inf, nan
            error_messages.append(f"entries in the `value` column must be an int or float: {value}. row={row}")

        elif is_observed_row and ((value is None) or
                               (isinstance(value, datetime.date)) or
                               (not math.isfinite(value))):   # inf, nan
            error_messages.append(f"entries in the `value` column must be nan if type is observed: {value}. row={row}")

        # convert parsed date back into string suitable for JSON.
        # NB: recall all targets are "type": "discrete", so we only accept ints and floats
        # if isinstance(value, datetime.date):
        #     value = value.strftime(YYYY_MM_DD_DATE_FORMAT)
        rows.append([target_name, location, is_point_row, quantile, value])

    # Add invalid targets to errors
    if len(error_targets) > 0:
        error_messages.append(f"invalid target name(s): {error_targets!r}")

    return rows, error_messages


def _validate_header(header, addl_req_cols):
    """
    `json_io_dict_from_quantile_csv_file()` helper function.

    :param header: first row from the csv file
    :param addl_req_cols: an optional list of strings naming columns in addition to REQUIRED_COLUMNS that are required
    :return: column_index_dict: a dict that maps column_name -> its index in header
    """
    required_columns = list(REQUIRED_COLUMNS)
    required_columns.extend(addl_req_cols)
    counts = [header.count(required_column) == 1 for required_column in required_columns]

    for elem in header:
        if elem not in POSSIBLE_COLUMNS:
            raise RuntimeError(f"invalid header. contains invalid column. column={elem}, "
                                f"possible_columns={POSSIBLE_COLUMNS}")


    if not all(counts):
        raise RuntimeError(f"invalid header. did not contain the required columns. header={header}, "
                           f"required_columns={required_columns}")

    return {column: header.index(column) for column in header}


def _validate_quantile_prediction_dict(prediction_dict):
    """
    `json_io_dict_from_quantile_csv_file()` helper function. Implements the quantile checks at
    https://docs.zoltardata.com/validation/#quantile-prediction-elements . NB: this function is a copy/paste (with
    simplifications) of Zoltar's `utils.forecast._validate_quantile_prediction_dict()`

    :param prediction_dict: as documented at https://docs.zoltardata.com/
    :return list of strings, one per error. [] if prediction_dict is valid
    """
    error_messages = []  # list of strings. return value. set below if any issues

    # validate: "The number of elements in the `quantile` and `value` vectors should be identical."
    prediction_data = prediction_dict['prediction']
    pred_data_quantiles = prediction_data['quantile']
    pred_data_values = prediction_data['value']
    if len(pred_data_quantiles) != len(pred_data_values):
        # note that this error must stop processing b/c subsequent steps rely on their being the same lengths
        # (e.g., `zip()`)
        error_messages.append(f"The number of elements in the `quantile` and `value` vectors should be identical. "
                              f"|quantile|={len(pred_data_quantiles)}, |value|={len(pred_data_values)}, "
                              f"prediction_dict={prediction_dict}")
        return error_messages  # terminate processing

    # validate: `quantile`s must be unique."
    if len(set(pred_data_quantiles)) != len(pred_data_quantiles):
        error_messages.append(f"`quantile`s must be unique. quantile column={pred_data_quantiles}, "
                              f"prediction_dict={prediction_dict}")

    # validate: "Entries in `value` must be non-decreasing as quantiles increase." (i.e., are monotonic).
    # note: there are no date targets, so we format as strings for the comparison (incoming are strings).
    # note: we do not assume quantiles are sorted, so we first sort before checking for non-decreasing

    # per https://stackoverflow.com/questions/7558908/unpacking-a-list-tuple-of-pairs-into-two-lists-tuples
    pred_data_quantiles, pred_data_values = zip(*sorted(zip(pred_data_quantiles, pred_data_values), key=lambda _: _[0]))


    def le_with_tolerance(a, b):  # a <= b ?
        return True if math.isclose(a, b, rel_tol=1e-05) else a <= b  # default: rel_tol=1e-09


    is_le_values = [le_with_tolerance(a, b) for a, b in zip(pred_data_values, pred_data_values[1:])]
    if not all(is_le_values):
        error_messages.append(f"Entries in `value` must be non-decreasing as quantiles increase. "
                              f"value column={pred_data_values}, is_le_values={is_le_values}, "
                              f"prediction_dict={prediction_dict}")

    # validate: "Entries in `value` must obey existing ranges for targets." recall: "The range is assumed to be
    # inclusive on the lower bound and open on the upper bound, # e.g. [a, b)."
    # NB: range is not tested per @nick: "All of these should be [0, Inf]"

    # done
    return error_messages


#
# quantile_csv_rows_from_json_io_dict()
#

def quantile_csv_rows_from_json_io_dict(json_io_dict):
    """
    The same as `csv_rows_from_json_io_dict()`, but only returns data in REQUIRED_COLUMNS ('location', 'target', 'type',
    'quantile', 'value').

    :param json_io_dict: a "JSON IO dict" to load from. see docs for details. the "meta" section is ignored
    :return: a list of CSV rows including header - see CSV_HEADER
    """
    from zoltpy.util import csv_rows_from_json_io_dict  # avoid circular imports


    # since we've already implemented `csv_rows_from_json_io_dict()`, our approach is to use it, transforming as needed
    csv_rows = csv_rows_from_json_io_dict(json_io_dict)
    csv_rows.pop()  # skip header
    rows = [list(REQUIRED_COLUMNS)]  # add header. rename the 'class' column to 'type'
    for location, target, pred_class, value, cat, prob, sample, quantile, family, param1, param2, param3 in csv_rows:
        if pred_class not in ['point', 'quantile']:  # keep only rows whose 'type' is 'point' or 'quantile'
            continue

        rows.append([location, target, pred_class, quantile, value])  # keep only quantile-related columns
    return rows
