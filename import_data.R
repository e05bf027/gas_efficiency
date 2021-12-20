# import_data.R
# =============
# imports patient-specific data to create wrangled data and then 
# turns it into a large tidy tibble.
# =============

# Enter the path to the file you want
metavision_file_specific <- mv_files[i]

# reads file at that location. guess_max tells the command to look 1000000
# rows into the file, and see what unit format suits best/fits them all
untidy_tibble <- read_xlsx(metavision_file_specific, guess_max = 1000000)

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

# Now manipulate the cardiac data independently. The initial pivot gives 
# list_cols that are then turned to characters before the original column
# is effectively removed.
cardiac_rhythm <- pivot_wider(cardiac_rhythm, 
                              names_from = `Parameter Name`, 
                              values_from = Value)

cardiac_rhythm$Cardiac_rhythm <- sapply(cardiac_rhythm$`Cardiac Rhythm`, toString)
cardiac_rhythm <- select(cardiac_rhythm, Time, Cardiac_rhythm)

### PIVOT THE UNTIDY TIBBLE INTO WIDE FORMAT and remove the untidy tibble
### replace INIT with the study ID number
tidy_tibble <- pivot_wider(untidy_tibble, 
                           id_cols = Time, 
                           names_from = `Parameter Name`, 
                           values_from = Value)

# Rejoin the cardiac data and arrange everything chronologically
tidy_tibble <- left_join(tidy_tibble, cardiac_rhythm, by = 'Time') %>%
  arrange(Time)

# Save a copy of this file
file_name <- sprintf('/Users/davidhannon/Documents/02. Medicine/Med_Programming/00. Patient DB/outputs/wide/patient_00%d.xlsx', i)
write_xlsx(tidy_tibble, file_name)

# upload a copy to google drive
# NB: 'drive_put' allows the file to either renew an existing file,
# or placing a brand new file
local_location <- file_name
drive_location <- as_dribble('https://drive.google.com/drive/folders/1SnxmvqQnWsjr5jjSWFY5ht9FOpsi5fkg')
drive_put(local_location, drive_location)
