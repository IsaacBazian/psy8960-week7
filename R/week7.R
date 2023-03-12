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
  ggpairs()
(ggplot(week7_tbl, aes(timeStart, q1)) +
  geom_point(size = 1.5) +
  labs(x = "Date of Experiment", y = "Q1 Score")) %>% 
  ggsave("../figs/fig1.png", ., width = 8, height = 4.5, units = "in", dpi = 300)


(ggplot(week7_tbl, aes(q1, q2, color = gender)) +
  geom_point(position = position_jitter(width = 0.2), size = 1.5) +
  labs(color = "Participant Gender")) %>% 
  ggsave("../figs/fig2.png", ., width = 8, height = 4.5, units = "in", dpi = 300)

(ggplot(week7_tbl, aes(q1, q2)) +
  geom_point(size = 1.5, position = position_jitter(width = 0.2)) +
  facet_grid(cols = vars(gender)) +
  labs(x = "Score on Q1", y = "Score on Q2")) %>% 
  ggsave("../figs/fig3.png", ., width = 8, height = 4.5, units = "in", dpi = 300)


(ggplot(week7_tbl, aes(gender, timeSpent)) +
  geom_boxplot() +
  labs(x = "Gender", y = "Time Elapsed (mins)")) %>% 
  ggsave("../figs/fig4.png", ., width = 8, height = 4.5, units = "in", dpi = 300)


(ggplot(week7_tbl, aes(q5, q7, color = condition, group = condition)) +
  geom_point(size = 1.5, position = position_jitter(width = 0.2)) +
  geom_smooth(method = "lm", se = F, linewidth = 1) +
  labs(x = "Score on Q5", y = "Score on Q7", color = "Experimental Condition") +
  theme(legend.position = "bottom", legend.background = element_rect(fill = "#e0e0e0"))) %>% 
  ggsave("../figs/fig5.png", ., width = 8, height = 4.5, units = "in", dpi = 300)