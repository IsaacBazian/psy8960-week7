# Script Settings and Resources
setwd(dirname(rstudioapi::getActiveDocumentContext()$path))
library(tidyverse)
library(GGally)



# Data Import and Cleaning
week7_tbl <- read_csv(file = "../data/week3.csv", col_types = "?Tffiiiiiiiiii") %>% 
  mutate(timeStart = ymd_hms(timeStart)) %>% #This step is necessary because when I tried to do this in the col_types above, timeStart had NAs
  mutate(condition = recode_factor(condition, A = "Block A", B = "Block B", C = "Control")) %>% 
  mutate(gender = recode_factor(gender, M = "Male", F = "Female")) %>% 
  filter(q6 == 1) %>% 
  select(-q6) %>% 
  mutate(timeSpent = difftime(timeEnd, timeStart, units = "mins"))





# Visualization
week7_tbl %>%
  select(q1:q10) %>% 
  ggpairs(lower = list(continuous = wrap("points", position = position_jitter(width = 0.2, height = 0.2)))) #Check later if all this extra specification is required/desired
(ggplot(week7_tbl, aes(timeStart, q1)) +
  geom_point() +
  labs(x = "Date of Experiment", y = "Q1 Score")) %>% 
  ggsave("../figs/fig1.png", ., width = 16, height = 9, units = "in")



  



