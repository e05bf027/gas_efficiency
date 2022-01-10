# coerce_datatypes.R
# =========================
# this script splits the wide dataframe into two. One will remain in character
# format, but the other has all variables coerced to numeric. They are then 
# rejoined.

#===================== COERCE TO NUMERIC ==================================

# select columns that will become numeric
tidy_tibble_coerce <- tidy_tibble %>% 
  select(-airvo_mode,
         -cardiac_rhythm,
         -gcs_manual_entry,
         -patient_positioning,
         -patient_positioning_abg,
         -pb_mode_of_ventilation,
         -servo_i_modes,
         -set_i_e_ratio_pb,
         -summary)

# use sapply to coerce remaining columns to numeric
col_coerce <- ncol(tidy_tibble_coerce)
tidy_tibble_coerce <-  as_tibble(sapply(tidy_tibble_coerce[, 1:col_coerce],
                                        as.numeric))

# fix coercion of 'time' by resetting to POSIXct
tidy_tibble_coerce$time <- as.POSIXct(tidy_tibble_coerce$time,
                                      tz = 'UTC',
                                      origin = "1970-01-01")

#===================== SEPARATE CHR AND REJOIN ==============================

tidy_tibble_chr <- tidy_tibble %>% 
  select(time,
         airvo_mode,
         cardiac_rhythm,
         gcs_manual_entry,
         patient_positioning,
         patient_positioning_abg,
         pb_mode_of_ventilation,
         servo_i_modes,
         set_i_e_ratio_pb,
         summary) %>% 
  full_join(tidy_tibble_coerce,
            by = 'time')
