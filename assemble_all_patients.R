# assemble_all_patients.R
# =============================================================================
# reads in the individual dfs of all patients, and reassembles them into 
# a large df of all points for all patients that can be used to assemble further
# dfs for analysis

library(tidyverse)
library(readxl)
library(writexl)

path <- '/Users/davidhannon/Documents/02. Medicine/Med_Programming/00. Patient DB/ai_df/isolated_dfs'
dfs_list <- list.files(path = path, full.names = TRUE)

df <- tibble()
  
for (i in 1:length(dfs_list)) {
  df <- bind_rows(df, read_xlsx(dfs_list[i]))
}

path <- '/Users/davidhannon/Documents/02. Medicine/Med_Programming/00. Patient DB/ai_df/all_patients_all_points.xlsx'
write_xlsx(x = df, path = path, col_names = T)

rm(list = ls())
