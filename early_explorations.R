# early_explorations.R
# a script to allow early exploration of the large, wide tibbles.
# ===================================

exploratory_destination <- as.character('/Users/davidhannon/Documents/02. Medicine/Med_Programming/00. Patient DB/outputs/wide/patient_003.xlsx')
exploratory_tibble <- read_xlsx(exploratory_destination, guess_max = 1000000)

ABG_data_loc <- '/Users/davidhannon/Documents/02. Medicine/Med_Programming/MD_Metavision_wrangle/wrangled_data/03_KH/Patient_003_verified.xlsx'
ABG_tibble <- read_xlsx(ABG_data_loc, sheet = 'ABG (transcribed to ICU comp)', guess_max = 1000000)


# add PFR
exploratory_tibble$PaO2 <- as.numeric(exploratory_tibble$PaO2)
exploratory_tibble$`Measured Fi02 (PB)` <- as.numeric(exploratory_tibble$`Measured Fi02 (PB)`)

mutate(exploratory_tibble, 
       PF_ratio = PaO2 / (exploratory_tibble$`Measured Fi02 (PB)` * 100))
