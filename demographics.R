# demographics.R
# =========================
# this script reads and imports the demographics data for the selected patient.
# it also asks the user to select which admission date they wish to read in.

# Enter the path to the demographics file and import it
demo_file_location <- mv_files[i-1]
demo_df <- read_xlsx(demo_file_location, guess_max = 1000000) %>% 
  clean_names()

# select only parameters of interest
demo_df <- demo_df %>% 
  select(admission_date, parameter_name, value, validation_time) %>% 
  pivot_wider(id_cols = admission_date,
              names_from = parameter_name,
              values_from = value) %>% 
  clean_names()
view(demo_df)

# get DOB and admission date, then calculate patient age
birthday <- dmy(readline('Enter the date of birth (DD-MM-YYYY): '))
admission_date <- ymd_hms(readline('Enter the admission date you wish to process (paste from console): '))
patient_age <- as.integer(time_length(difftime(admission_date, birthday), "years"))

# get inputs for height, weight, gender
patient_height <- as.numeric(readline('Enter the patients height (cm): '))
patient_weight <- as.numeric(readline('Enter the patients weight (kg): '))
patient_gender <- as.character(readline('Enter the patients gender (M/F): '))

# wait for user to CLOSE EXCEL before hitting enter (if Excel is open it will
# cause the total file number to change which creates problems in the next script)
readline(prompt="CLOSE EXCEL, then press [enter] to continue")

# Tidy up
rm(demo_file_location,
   demo_df,
   birthday)

# ======= CALL NEXT SCRIPT =========
source('import_data.R')
