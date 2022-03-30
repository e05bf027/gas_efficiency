# assemble_prone_df.R
# =======================================================================
# this script assembles a new df with the following key information. it
# is executed manually line-by-line.
# - source of admission (ED/GUH ward/outside institution)
# - patient ID
# - proning status (pre-prone/post-prone/pre-unprone/post-unprone)
# - previous proning sessions
# - primary diagnosis (usually Covid-19)
# =======================================================================

# initialise the proning df = use patient_002, obs 72. ONBLY DO THIS ONCE!!!
# prone_df <- filter(tidy_tibble, observation == '72')

# select the NEXT the tidy_tibble will be the next patient read in
# manually inspect the df to find the right moment.
row_for_df_prone <- filter(tidy_tibble, observation == '93')

# =======================================================================

# add the patient ID
row_for_df_prone$patient_ID <- 'patient_002'

# add admission time
row_for_df_prone$admission_time <- dmy_hm('09/04/2020 19:25')

# add the primary diagnosis
# 'covid_19'
# 'pneumonia_bacterial'
# etc...
row_for_df_prone$diagnosis <- 'covid_19'

# add the source of admission
# 'ed_uhg'
# 'ward_uhg'
# 'external_icu'
row_for_df_prone$source_of_admission <- 'ward_uhg'

# add previous asleep pronings in this admission
row_for_df_prone$previous_prone <- as.integer(0)

# add the proning status for this admission
# 'pre_prone'
# 'post_prone'
# 'pre_unprone'
# 'post_unprone'
row_for_df_prone$prone_status <- 'post_unprone'

# add time since admission to ICU for that datapoint
row_for_df_prone$time_since_admission <- hms::as_hms(row_for_df_prone$time - row_for_df_prone$admission_time)

# =======================================================================
# join the row to the existing df
# =======================================================================

prone_df <- full_join(x = prone_df, y = row_for_df_prone)
