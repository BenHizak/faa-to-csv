# FAA Aircraft Registry Data Converter

This project provides a bash script to convert the FAA Releasable Aircraft Database from its native fixed-width format into clean CSV files and a consolidated Excel workbook.

## Features
- **Fixed-width to CSV**: Uses `csvkit` and predefined schemas to accurately parse FAA data.
- **Chunk Handling**: Automatically stacks the fragmented `MASTER` files into a single unified dataset.
- **Excel Export**: Merges all converted CSVs into a single `.xlsx` file with separate tabs.

## Prerequisites
Ensure the following tools are installed on your system:
- **[csvkit](https://csvkit.readthedocs.io/)**: For fixed-width conversion (`pip install csvkit`).
- **gnumeric**: (optional) For the `ssconvert` utility (used to generate the Excel workbook).

## Project Structure
- `input/`: Place your raw FAA `.txt` files here.
- `output/`: The destination for converted CSVs and the final Excel file.
- `schema/`: Contains CSV-based schemas defining the column widths and names for each FAA file.
- `convert_to_csv.sh`: The main execution script.

## Setup & Usage

### 1. Download the Data
1. Download the latest database zip from the [FAA website](https://www.faa.gov/licenses_certificates/aircraft_certification/aircraft_registry/releasable_aircraft_download).
2. Unzip the contents into the `input` directory of this repository.

your input folder should now look like
```
└── input
    ├── ACFTREF.txt
    ├── DEALER.txt
    ├── DOCINDEX.txt
    ├── ENGINE.txt
    ├── MASTER-1.txt
    ├── MASTER-2.txt
    ├── MASTER-3.txt
    ├── MASTER-4.txt
    ├── MASTER-5.txt
    ├── MASTER-6.txt
    ├── MASTER-7.txt
    ├── MASTER-8.txt
    ├── MASTER-9.txt
    └── RESERVED.txt
```



### 2. Run the Conversion
Execute the script from the root of the project:
```bash
chmod +x convert_to_csv.sh
./convert_to_csv.sh
```
your output folder should now look like

```
└── output
    ├── ACFTREF.csv
    ├── DEALER.csv
    ├── DOCINDEX.csv
    ├── ENGINE.csv
    ├── MASTER.csv
    ├── RESERVED.csv
    └── output.xlsx
```

File names become tab names, and are renamed for readability
`ACFTREF.csv` becomes `aircraft.csv`
`DEALER.csv` becomes `dealer.csv`
`DOCINDEX.csv` becomes `document_index.csv`
`ENGINE.csv` becomes `engine.csv`
`MASTER.csv` becomes `registration.csv`
`RESERVED.csv` becomes `reserved_n_number.csv`

### 3. Check Outputs
After the script completes:
- Individual CSVs will be available in the `output/` folder.
- A consolidated `output.xlsx` will be generated in `output/`.

## Related Projects
- See [simonw/scrape-faa-releasable-aircraft](https://github.com/simonw/scrape-faa-releasable-aircraft) which seems to update regularly
- See [ClearAerospace/faa-aircraft-registry](https://github.com/ClearAerospace/faa-aircraft-registry/) which creates python dictionary
