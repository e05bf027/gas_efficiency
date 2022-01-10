# demographics.R
# =========================
# this script reads and imports the demographics data for the selected patient.
# it also asks the user to select which admission date they wish to read in.

# re-interrogate the file location and get the full paths
mv_files <- list.files(mv_location, full.names = TRUE)

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

# get inputs for height, weight
patient_height <- as.numeric(readline('Enter the patients height (cm): '))
patient_weight <- as.numeric(readline('Enter the patients weight (kg): '))

# get DOB and admission date, then calculate patient age
birthday <- dmy(readline('Enter the date of birth (DD-MM-YYYY): '))

demo_df$admission_date
admission_date <- ymd_hms(readline('Enter the admission date you wish to process (paste from console): '))

patient_age <- as.integer(time_length(difftime(admission, birthday), "years"))

# Tidy up
rm(demo_file_location,
   demo_df,
   birthday,
   admission_date)
