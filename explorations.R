# explorations.R
# early explorations of the immediate effects of prone positioning
# --------------

library(tidyverse)
library(lubridate)
library(readxl)
library(janitor)

# read in the file
path <- ('/Users/davidhannon/Documents/02. Medicine/Med_Programming/00. Patient DB/around_proning_for_ML/first_prone_GUH.xlsx')
data <- read_xlsx(path = path, guess_max = 100)

# alter some variables to factors
data$proning_sequence <- factor(data$proning_sequence, levels = c('pre_prone', 'post_prone', 'pre_unprone', 'post_unprone'))
data$patient_positioning <- as.factor(data$patient_positioning)
data$gender <- as.factor(data$gender)

# add new variables
# - aa gradient
# - cao2
# - mechanical power (chiumello et al referencing gattinoni)
# - ventilatory ratio

data <- data %>% 
  mutate(aa_gradient = ((fi_o2 * (101.3 - 6.3)) - (pa_co2 / 0.8)) - pa_o2,
         pf_ratio = pa_o2 / fi_o2,
         cao2 = (1.34 * total_haemoglobin * (sa_o2_systemic/100)) + (0.0225 * pa_o2))

# ===========================================================================
# the problem with calculating mechanical power is that methods need either/both of:
# 1. plateau pressure
# 2. peak flow
# all recovered data records these as '0' if at all
# ===========================================================================

# begin grouping
data_proning_phase <- data %>% 
  group_by(proning_sequence)

data_position <- data %>% 
  group_by(patient_positioning)

# exploratory plots
ggplot(data = data, 
       mapping = aes(x = proning_sequence, 
                     y = aa_gradient, 
                     col = patient_positioning)) +
  geom_boxplot() +
  theme_gray()
