#!/bin/bash

# This script uses csvkit (specifically in2csv) to convert FAA fixed-width files 
# into CSVs based on external schema files (FILENAME_schema.csv).

# Ensure csvkit is installed
if ! command -v in2csv &> /dev/null; then
    echo "Error: csvkit (in2csv) is not installed. Please install it with 'pip install csvkit'."
    exit 1
fi

echo "Beginning FAA data conversion using schema files..."

# 1. Convert Master Parts and Stack
echo "Processing MASTER chunks..."
# We assume master_schema.csv exists in the current directory
in2csv --skip-lines 1 -f fixed --schema ./schema/MASTER_schema.csv ./input/MASTER-1.txt > MASTER-1.csv
in2csv --skip-lines 1 -f fixed --schema ./schema/MASTER_schema.csv ./input/MASTER-2.txt > MASTER-2.csv
in2csv --skip-lines 1 -f fixed --schema ./schema/MASTER_schema.csv ./input/MASTER-3.txt > MASTER-3.csv
in2csv --skip-lines 1 -f fixed --schema ./schema/MASTER_schema.csv ./input/MASTER-4.txt > MASTER-4.csv
in2csv --skip-lines 1 -f fixed --schema ./schema/MASTER_schema.csv ./input/MASTER-5.txt > MASTER-5.csv
in2csv --skip-lines 1 -f fixed --schema ./schema/MASTER_schema.csv ./input/MASTER-6.txt > MASTER-6.csv
in2csv --skip-lines 1 -f fixed --schema ./schema/MASTER_schema.csv ./input/MASTER-7.txt > MASTER-7.csv
in2csv --skip-lines 1 -f fixed --schema ./schema/MASTER_schema.csv ./input/MASTER-8.txt > MASTER-8.csv
in2csv --skip-lines 1 -f fixed --schema ./schema/MASTER_schema.csv ./input/MASTER-9.txt > MASTER-9.csv


echo "Stacking MASTER chunks into MASTER.csv..."
csvstack MASTER-*.csv > output/MASTER.csv

#remove intermediate files
rm -v MASTER-*.csv 

# 2. Convert remaining files using their respective schema CSVs
echo "Converting ACFTREF.txt..."
in2csv --skip-lines 1 -f fixed --schema ./schema/ACFTREF_schema.csv ./input/ACFTREF.txt > output/aircraft.csv

echo "Converting ENGINE.txt..."
in2csv --skip-lines 1 -f fixed --schema ./schema/ENGINE_schema.csv ./input/ENGINE.txt > output/engine.csv

echo "Converting DEALER.txt..."
in2csv --skip-lines 1  -f fixed --schema ./schema/DEALER_schema.csv ./input/DEALER.txt > output/dealer.csv

echo "Converting DOCINDEX.txt..."
in2csv --skip-lines 1  -f fixed --schema ./schema/DOCINDEX_schema.csv ./input/DOCINDEX.txt > output/document_index.csv

echo "Converting RESERVED.txt..."
in2csv --skip-lines 1 -f fixed --schema ./schema/RESERVED_schema.csv ./input/RESERVED.txt > output/reserved_n_number.csv

echo "Conversion complete."

#delete generated files

# rm MASTER-*.csv ACFTREF.csv ENGINE.csv DEALER.csv DOCINDEX.csv RESERVED.csv

cd output
ssconvert --merge-to=output.xlsx *.csv ../data_dictionary.csv
