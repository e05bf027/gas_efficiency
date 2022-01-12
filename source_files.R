# source_file.R
# =============
# lists all input files in the relevant directory, and asks for your
# selection (which it names 'i'). 'i' will then be used in other scripts.
# =============

# warning to ensure files are pre-processed
print('The .xls files that are generated from the Metavisiion Query wizard')
print('require pre-processing. Have you:')
print('1. changed to extension to .xlsx from .xls?')
print('2. removed the empty rows from the top of the excel file?')
print('====================================================================')
print('If the file(s) has been preprocessed correctly, proceed.')
print('====================================================================')

# List of raw input files
mv_location <- "/Users/davidhannon/Documents/02. Medicine/Med_Programming/00. Patient DB/metavision_outputs"
mv_files <- list.files(mv_location)
view(mv_files)

# choose which file you want to import and process
i <- as.numeric(readline("enter the index of the data file you want to import: "))

# also decide what number you wish to designate for this patient in the final database
j <- as.character(readline('What number do you wish to designate for this patient: '))
file_name <- sprintf('/Users/davidhannon/Documents/02. Medicine/Med_Programming/00. Patient DB/outputs/wide/patient_0%s.xlsx', j)

# run import script
source('demographics.R')
