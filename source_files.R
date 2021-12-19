# source_file.R
# =============
# lists all input files in the relevant directory, and asks for your
# selection (which it names 'i'). 'i' will then be used in other scripts.
# =============

# List of raw input files
mv_location <- "/Users/davidhannon/Documents/02. Medicine/Med_Programming/00. Patient DB/metavision_outputs"
mv_files <- list.files(mv_location, full.names = TRUE)
view(mv_files)

# choose which file you want to import and process
i <- as.numeric(readline("enter the index of the file you want to import: "))
