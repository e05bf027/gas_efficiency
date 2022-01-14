# coerce_datatypes.R
# =========================
# this script splits the wide dataframe into two. One will remain in character
# format, but the other has all variables coerced to numeric. They are then 
# rejoined.

# ================= CREATE VECTOR OF VENTILATOR PARAMETERS ================

pb_char <- c('pb_mandatory_mode_type',
             'pb_mode_of_ventilation',
             'pb_spontaneous_type',
             'pb_vent_type',
             'pb_ventilation_mode',
             'set_i_e_ratio_pb',
             'trigger_type_setting')

niv_char <- c('airvo_mode',
              'respironics_mode')

# ================= CREATE VECTOR OF STANDARD PARAMETERS ==================

constant_char <- c('time',
                   'cardiac_rhythm',
                   'gcs_manual_entry',
                   'patient_positioning',
                   'patient_positioning_abg',
                   'summary')

coerce_char <- c(constant_char, pb_char, niv_char) 
# all variables that might need coercion
rm(constant_char, pb_char, niv_char)

# ==================== COERCE TO NUMERIC ==================================

# create vector of variable names that will be coerced to character, and 
# initialise df
tidy_tibble_char <- select(.data = tidy_tibble, observation)
variables_present <- 'observation'

# select columns that will become character
for (y in 1:length(coerce_char)) {
  if (coerce_char[y] %in% colnames(tidy_tibble)) {
    tidy_tibble_char <-  left_join(tidy_tibble_char,
                                   tidy_tibble[, c('observation', coerce_char[y])],
                                   by = 'observation')
    variables_present <- c(variables_present, coerce_char[y])
  }
}

# remove these columns from the main df (but keep 'observation' for later joining)
tidy_tibble <- select(tidy_tibble, -variables_present, observation)

# use sapply to coerce remaining columns to numeric, then rejoin
tidy_tibble_nums <-  as_tibble(sapply(tidy_tibble[, 1:ncol(tidy_tibble)],
                                        as.numeric))

# reform tidy_)tibble by joining the coerced and character dfs
tidy_tibble <-  full_join(tidy_tibble_char, tidy_tibble_nums, by = 'observation')

# tidy up
rm(coerce_char, variables_present, tidy_tibble_char, tidy_tibble_nums)

# ==================== CALL NEXT SCRIPT =======================
source('add_new_gas_indices.R')
