# packages_for_gas_efficiency.R
# loads packages needed for task of creating large tibbles of physiologic data

library(readxl)
Sys.sleep(0.5)

library(janitor)
Sys.sleep(0.5)

library(tidyverse)
Sys.sleep(3)

library(lubridate)
Sys.sleep(3)

library(writexl)
Sys.sleep(0.5)

library(googledrive)
drive_find(n_max = 5) # prompts rstudio to confirm access to drive

# ================= NEXT SCRIPT ===================================

source('source_files.R')