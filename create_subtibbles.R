# create_subtibbles.R
# ===============================
# this script takes the wide tidy_tibble and divides it into smaller tibbles
# that are useful for analysis by the engineers/mathematicians.

# Create subtibbles
# 1. demographics
demo_tibble <- tidy_tibble %>% 
  select(age,
         gender,
         weight,
         height_recorded,
         BMI)

if (!is.na(tidy_tibble$height[1])) {
  demo_tibble$height <- tidy_tibble$height
}

demo_tibble <- demo_tibble[1,]

# 2. ABG
ABG_tibble <- tidy_tibble %>% 
  select(time,
         patient_positioning,
         patient_positioning_abg,
         ph_abg,
         pa_o2,
         pa_co2,
         bicarbonate_abg_a,
         lactate_abg,
         base_excess_vt,
         potassium_abg,
         sodium_abg,
         anion_gap_abg,
         glucose_abg,
         total_haemoglobin,
         fi_o2,
         tympanic_temperature,
         sa_o2_systemic,
         sp_o2)

# 3. ventilator
pb_variables <- c('time',
                  'patient_positioning',
                  'fi_o2',
                  'set_fraction_inspired_oxygen_pb',
                  'end_tidal_co2_marquette',
                  'pb_mode_of_ventilation',
                  'set_respiratory_rate_pb',
                  'set_tv_pb',
                  'set_peep_pb',
                  'peep',
                  'set_i_e_ratio_pb',
                  'minute_volume_pb',
                  'measured_fi02_pb',
                  'measured_peep_pb',
                  'total_respiratory_rate_pb',
                  'expiratory_tidal_volume_pb',
                  'peak_inspiratory_pressure_measured_pb',
                  'plateau_airway_pressure_pb',
                  'mean_airway_pressure_pb',
                  'peak_inspiratory_pressure_measured_pb',
                  'dynamic_characteristics_pb',
                  'pb_mandatory_mode_type',
                  'pb_spontaneous_type',
                  'pb_vent_type',
                  'pb_ventilation_mode',
                  'set_i_of_i_e_ratio',
                  'set_eof_i_e_ratio')

vent_tibble <- tibble(observation = tidy_tibble$observation)
for (k in 1:length(pb_variables)) {
  if (pb_variables[k] %in% colnames(tidy_tibble)) {
    vent_tibble <- left_join(vent_tibble, 
              tidy_tibble[, c('observation', pb_variables[k])],
              by = 'observation')
  }
}

# 4. Cardiovascular
# The initial columns always exist, after that we must check if cardiac output
# columns exist, and then select them.
cardio_tibble <- tidy_tibble %>% 
  select(time,
         patient_positioning,
         cardiac_rhythm,
         heart_rate,
         arterial_pressure_systolic,
         arterial_pressure_diastolic,
         arterial_pressure_mean,
         non_invasive_arterial_pressure_systolic,
         non_invasive_arterial_pressure_diastolic,
         non_invasive_arterial_pressure_mean)

# check if advanced CO parameters are present and add them if they do
adv_co <- c('central_venous_pressure',
            'sv_o2_venous',
            'cardiac_output)_vigileo',
            'stroke_volume_vigileo',
            'stroke_volume_variation_vigileo',
            'systemic_vascular_resistance_vigileo')

for (z in 1:length(adv_co)) {
  if (adv_co[z] %in% colnames(tidy_tibble)) {
    left_join(cardio_tibble, 
              tidy_tibble[, c('time', adv_co[z])],
              by = 'time')
  }
}

# the final step is to create a list of these that will be passed to the
# write.xlsx function to give a file with different output sheets
all_data <- select(tidy_tibble,
                   -summary) # remove data that could hold sensitive info
  
output_sheets <- list(demographics = demo_tibble,
                      ABG = ABG_tibble,
                      Ventilator = vent_tibble,
                      Cardiovascular = cardio_tibble,
                      All_recorded = all_data)

# tidy up
rm(demo_tibble,
   ABG_tibble,
   pb_variables,
   vent_tibble,
   cardio_tibble,
   adv_co,
   k,
   y,
   z)

# next script
source('file_outputs.R')