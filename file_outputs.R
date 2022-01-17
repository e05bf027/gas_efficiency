# file_outputs.R
# =================================
# This script generates output from the wrangled df from the previous series of 
# scripts. This output consists of:
# 1. saving .xlsx of all data to disk
# 2. generating a version of the file for Warwick and saving this to googledrive

# Save a copy of the file
write_xlsx(x = output_sheets, format_headers = T, path = file_name)

# Save the tibble
tibble_file <- 
save(tidy_tibble, file = sprintf('/Users/davidhannon/Documents/02. Medicine/Med_Programming/00. Patient DB/dfs/patient_0%s.Rda', j))

# upload a copy to google drive
# NB: 'drive_put' allows the file to either renew an existing file,
# or placing a brand new file
local_location <- file_name
drive_location <- as_dribble('https://drive.google.com/drive/folders/1SnxmvqQnWsjr5jjSWFY5ht9FOpsi5fkg')
drive_put(local_location, drive_location)

# tidy
rm(all_data, 
   output_sheets, 
   drive_location,
   local_location)
