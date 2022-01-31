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

# initialise the proning df
# select the relevant row
row_for_df_prone <- patient_002[73, ]
prone_df <- row_for_df_prone

# select the relevant row
row_for_df_prone <- tidy_tibble[XXX , ]

# =======================================================================

# add the patient ID
row_for_df_prone$patient_ID <- 'patient_0XX'

# add admission time
row_for_df_prone$admission_time <- dmy_hm('XXX')

# add the primary diagnosis
# 'covid_19'
# 'pneumonia_bacterial'
# etc...
row_for_df_prone$diagnosis

# add the source of admission
# 'ed_uhg'
# 'ward_uhg'
# 'external_icu'
row_for_df_prone$source_of_admission <- 'XXX'

# add previous asleep pronings in this admission
row_for_df_prone$previous_prone <- as.integer(XXX)

# add the proning status for this admission
# 'pre_prone'
# 'post_prone'
# 'pre_unprone'
# 'post_unprone'
row_for_df_prone$prone_status <- 'XXX'

# =======================================================================
# join the row to the existing df
# =======================================================================

# add time since admission to ICU for that datapoint
row_for_df_prone$time_since_admission <- hms::as_hms(row_for_df_prone$time - row_for_df_prone$admission_time)
