# Script Settings and Resources
setwd(dirname(rstudioapi::getActiveDocumentContext()$path))
library(tidyverse)




# Data Import and Cleaning
week7_tbl <- read_csv(file = "../data/week3.csv", col_types = "?Tffiiiiiiiiii") %>% 
  mutate(timeStart = ymd_hms(timeStart)) %>% #This step is necessary because when I tried to do this in the col_types above, timeStart had NAs
  mutate(condition = recode_factor(condition, A = "Block A", B = "Block B", C = "Control")) %>% 
  mutate(gender = recode_factor(gender, M = "Male", F = "Female")) %>% 
  filter(q6 == 1) %>% 
  select(-q6) %>% 
  mutate(timeSpent = difftime(timeEnd, timeStart, units = "mins"))





# Visualization


