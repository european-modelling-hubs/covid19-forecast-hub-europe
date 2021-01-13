#!/usr/bin/env bash

# validate file names
echo "TESTING FILENAMES..."
python3 code/validation/validate_filenames.py

# test covid forecast submission formatting
echo "TESTING SUBMISSIONS..."
python3 code/validation/test-formatting.py
