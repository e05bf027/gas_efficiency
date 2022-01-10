# import_data.R
# =============
# imports patient-specific data to create wrangled data and then 
# turns it into a large tidy tibble.
# =============

# Enter the path to the file you want
metavision_file_specific <- mv_files[i] 

# reads file at that location. guess_max tells the command to look 1000000
# rows into the file, and see what unit format suits best/fits them all
untidy_tibble <- read_xlsx(metavision_file_specific, guess_max = 1000000) %>% 
  filter(`Admission Date` == admission)

# now, isolate out only the columns for the parameter name, value, and time
# that the value was recorded
untidy_tibble <-  untidy_tibble %>% 
  select(Time, `Parameter Name`, Value)

# next, factorize the parameter names
untidy_tibble$`Parameter Name` <- as.factor(untidy_tibble$`Parameter Name`)

# The vales in the 'cardiac rhythm;' column are awkward, and often read as
# list_cols. To get around this, isolate the cardiac rhythm values and remove
# them from the larger data frame.
cardiac_rhythm <- filter(untidy_tibble,
                         untidy_tibble$`Parameter Name` == 'Cardiac Rhythm')

untidy_tibble <- filter(untidy_tibble,
                        untidy_tibble$`Parameter Name` != 'Cardiac Rhythm')

# Remove other parameters that are causing an issue with coercion to lists
untidy_tibble <- filter(untidy_tibble,
                        untidy_tibble$`Parameter Name` != 'GCS Eye Response' &
                        untidy_tibble$`Parameter Name` != 'GCS Motor Response' &
                        untidy_tibble$`Parameter Name` != 'GCS Verbal Response' &
                        #untidy_tibble$`Parameter Name` != 'PB Spontaneous  Type' &
                        #untidy_tibble$`Parameter Name` != 'PB Mandatory Mode Type' &
                        untidy_tibble$`Parameter Name` != 'O2 Administration mode' )
                        #untidy_tibble$`Parameter Name` != 'Summary' )

# Now manipulate the cardiac data independently. The initial pivot gives 
# list_cols that are then turned to characters before the original column
# is effectively removed.
cardiac_rhythm <- pivot_wider(cardiac_rhythm, 
                              names_from = `Parameter Name`, 
                              values_from = Value)

cardiac_rhythm$Cardiac_rhythm <- sapply(cardiac_rhythm$`Cardiac Rhythm`, toString)
cardiac_rhythm <- select(cardiac_rhythm, Time, Cardiac_rhythm)

# This same process must be repeated for other character vectors that might be
# coerced to lists


### PIVOT THE UNTIDY TIBBLE INTO WIDE FORMAT and remove the untidy tibble
### replace INIT with the study ID number
tidy_tibble <- pivot_wider(untidy_tibble, 
                           id_cols = Time, 
                           names_from = `Parameter Name`, 
                           values_from = Value)

# Rejoin the cardiac data and arrange everything chronologically
tidy_tibble <- left_join(tidy_tibble, cardiac_rhythm, by = 'Time') %>%
  clean_names() %>% 
  arrange(time)

# add columns for age, height, weight (we will, later, come up with a method
# to designate absent BMI values, and impute them
tidy_tibble$age <- patient_age
tidy_tibble$weight <- patient_weight
tidy_tibble$height <- patient_height

# Tidy up ================================================================
rm(cardiac_rhythm,
   untidy_tibble,
   demo_df,
   demo_file_location,
   mv_files,
   mv_location,
   metavision_file_specific,
   i,
   patient_age,
   patient_height,
   admission,
   birthday,
   DOB)

# Call next script =======================================================
