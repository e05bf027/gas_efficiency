# BMI_processing.R
# ===================
# This script calculates the BMI of the patient if their height and weight is
# available. It also adds a column indicating if their height is present in the
# original dataset.

if (!is.na(tidy_tibble$height[1])) {
  tidy_tibble <- mutate(tidy_tibble, 
         BMI = weight / ((height/100)^2),
         height_recorded = TRUE)
} else {
  tidy_tibble <- mutate(tidy_tibble,
         BMI = NA,
         height_recorded = FALSE)
}

#====== NEXT SCRIPT ==========
source('create_subtibbles.R')