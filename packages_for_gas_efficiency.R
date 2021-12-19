# packages_for_gas_efficiency.R
# loads packages needed for task of creating large tibbles of physiologic data

library(readxl)
library(tidyverse)   
library(lubridate)
library(writexl)

library(googledrive)
drive_find(n_max = 10) # prompts rstudio to confirm access to drive
