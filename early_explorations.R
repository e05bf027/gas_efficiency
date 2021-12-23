# early_explorations.R
# a script to allow early exploration of the large, wide tibbles.
# ===================================

exp_tibble <- tidy_tibble

ABG_data_loc <- '/Users/davidhannon/Documents/02. Medicine/Med_Programming/MD_Metavision_wrangle/wrangled_data/04_JM/Patient_004_JM.xlsx'
ABG_tibble <- read_xlsx(ABG_data_loc, sheet = 'ABG (transcribed to ICU comp)', guess_max = 1000000)

# columns are characters, change them to dbl
ABG_tibble[3:12] <- sapply(ABG_tibble[3:12], as.numeric)

# prep ABG tibble for joining
# ABG_join <- select(ABG_tibble, -'Patient Positioning')

# isolate fio2
fio2 <- select(exp_tibble, Time, `Set Fraction Inspired Oxygen (PB)`)

# add fio2 to ABG_tibble
ABG_tibble <- left_join(ABG_tibble, fio2, by = 'Time') %>%
  arrange(Time)

ABG_tibble$`Set Fraction Inspired Oxygen (PB)` <- as.double(ABG_tibble$`Set Fraction Inspired Oxygen (PB)`)

# create PF_ratio
ABG_tibble <- mutate(ABG_tibble, 
       PF_ratio = PaO2 / (ABG_tibble$`Set Fraction Inspired Oxygen (PB)` / 100))

# factorise positioning
ABG_tibble$`Patient Positioning` <- as.factor(ABG_tibble$`Patient Positioning`)

# ============================================
# now create exploratory graphs

PFR_table <- filter(ABG_tibble, PF_ratio > 0)

ggplot(data = PFR_table, aes(x = Time, y = PF_ratio, colour = PaCO2)) +
  geom_line()

ggplot(data = PFR_table, aes(x = Time, y = PF_ratio, colour = `Patient Positioning`)) +
  geom_col() # suggests improvement when prone
