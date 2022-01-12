# file_outputs.R
# =================================
# This script generates output from the wrangled df from the previous series of 
# scripts. This output consists of:
# 1. saving .xlsx of all data to disk
# 2. generating a version of the file for Warwick and saving this to googledrive

# Save a copy of the file
write_xlsx(x = tidy_tibble, format_headers = T, path = file_name)
write_xlsx(tidy_tibble, file_name)

# upload a copy to google drive
# NB: 'drive_put' allows the file to either renew an existing file,
# or placing a brand new file
local_location <- file_name
drive_location <- as_dribble('https://drive.google.com/drive/folders/1SnxmvqQnWsjr5jjSWFY5ht9FOpsi5fkg')
drive_put(local_location, drive_location)
