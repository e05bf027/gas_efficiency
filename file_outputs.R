# file_outputs.R
# Script to output data after it has been wrangled. Outputs to:
# 1. hard drive
# 2. google drive

# Save a copy of the file
file_name <- sprintf('/Users/davidhannon/Documents/02. Medicine/Med_Programming/00. Patient DB/outputs/wide/patient_00%d.xlsx', i)
write_xlsx(tidy_tibble, file_name)

# upload a copy to google drive
# NB: 'drive_put' allows the file to either renew an existing file,
# or placing a brand new file
local_location <- file_name
drive_location <- as_dribble('https://drive.google.com/drive/folders/1SnxmvqQnWsjr5jjSWFY5ht9FOpsi5fkg')
drive_put(local_location, drive_location)