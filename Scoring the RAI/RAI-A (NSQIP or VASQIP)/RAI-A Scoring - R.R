#R Code for Scoring the RAI-A

#NSQIP
library(tidyverse)

#if desired, radio and chemo can also be used here to determine disseminated cancer
data <- data %>%
  mutate(cancer = case_when(discancr == 1 ~ 1,
                            TRUE ~ 0),
         age_cancer = case_when(cancer == 1 & age <= 19 ~ 28,
                                cancer == 1 & age <= 24 ~ 29,
                                cancer == 1 & age <= 29 ~ 29,
                                cancer == 1 & age <= 34 ~ 30,
                                cancer == 1 & age <= 39 ~ 30,
                                cancer == 1 & age <= 44 ~ 31,
                                cancer == 1 & age <= 49 ~ 31,
                                cancer == 1 & age <= 54 ~ 32,
                                cancer == 1 & age <= 59 ~ 32,
                                cancer == 1 & age <= 64 ~ 33,
                                cancer == 1 & age <= 69 ~ 34,
                                cancer == 1 & age <= 74 ~ 34,
                                cancer == 1 & age <= 79 ~ 35,
                                cancer == 1 & age <= 84 ~ 35,
                                cancer == 1 & age <= 89 ~ 36,
                                cancer == 1 & age <= 94 ~ 36,
                                cancer == 1 & age <= 99 ~ 37,
                                cancer == 1 & age >= 100 ~ 37,
                                cancer == 0 & age <= 19 ~ 0,
                                cancer == 0 & age <= 24 ~ 1,
                                cancer == 0 & age <= 29 ~ 4,
                                cancer == 0 & age <= 34 ~ 6,
                                cancer == 0 & age <= 39 ~ 8,
                                cancer == 0 & age <= 44 ~ 10,
                                cancer == 0 & age <= 49 ~ 12,
                                cancer == 0 & age <= 54 ~ 14,
                                cancer == 0 & age <= 59 ~ 16,
                                cancer == 0 & age <= 64 ~ 18,
                                cancer == 0 & age <= 69 ~ 20,
                                cancer == 0 & age <= 74 ~ 22,
                                cancer == 0 & age <= 79 ~ 24,
                                cancer == 0 & age <= 84 ~ 26,
                                cancer == 0 & age <= 89 ~ 28,
                                cancer == 0 & age <= 94 ~ 30,
                                cancer == 0 & age <= 99 ~ 32,
                                cancer == 0 & age >= 100 ~ 34),
         RAI_A = age_cancer + ifelse(sex == 1, 3, 0) +
           ifelse(wtloss == 1, 8, 0) +
           ifelse(dialysis == 1 | renafail == 1, 8, 0) +
           ifelse(hxchf == 1, 5, 0) +
           ifelse(dyspnea == 3, 3, 0) +
           ifelse(transt %in% c(2, 3, 4, 5), 1, 0) +
           case_when(fnstatus == 2 ~ 7,
                     fnstatus == 3 ~ 14,
                     TRUE ~ 0))

data <- data %>%
  mutate(RAI_A = case_when(is.na(age_cancer) | is.na(sex) | is.na(wtloss) | is.na(dialysis) |
                             is.na(renafail) | is.na(hxchf) | is.na(dyspnea) | is.na(transt) |
                             is.na(fnstatus) | fnstatus == 4 ~ NA_real_,
                           TRUE ~ RAI_A),
         RAI_MISSINGNESS = case_when(is.na(RAI_A) ~ TRUE,
                                     !is.na(RAI_A) ~ FALSE))

data <- data %>%
  mutate(RAI_A4 = case_when(between(RAI_A, 0, 20) ~ "0Robust",
                            between(RAI_A, 21, 29) ~ "1Normal",
                            between(RAI_A, 30, 39) ~ "2Frail",
                            RAI_A >= 40 ~ "3VeryFrail"))

#VASQIP
library(tidyverse)

#if desired, radio and chemo can also be used here to determine disseminated cancer
data <- data %>%
  mutate(cancer = case_when(discancr == 1 ~ 1,
                            TRUE ~ 0),
         age_cancer = case_when(cancer == 1 & age <= 19 ~ 28,
                                cancer == 1 & age <= 24 ~ 29,
                                cancer == 1 & age <= 29 ~ 29,
                                cancer == 1 & age <= 34 ~ 30,
                                cancer == 1 & age <= 39 ~ 30,
                                cancer == 1 & age <= 44 ~ 31,
                                cancer == 1 & age <= 49 ~ 31,
                                cancer == 1 & age <= 54 ~ 32,
                                cancer == 1 & age <= 59 ~ 32,
                                cancer == 1 & age <= 64 ~ 33,
                                cancer == 1 & age <= 69 ~ 34,
                                cancer == 1 & age <= 74 ~ 34,
                                cancer == 1 & age <= 79 ~ 35,
                                cancer == 1 & age <= 84 ~ 35,
                                cancer == 1 & age <= 89 ~ 36,
                                cancer == 1 & age <= 94 ~ 36,
                                cancer == 1 & age <= 99 ~ 37,
                                cancer == 1 & age >= 100 ~ 37,
                                cancer == 0 & age <= 19 ~ 0,
                                cancer == 0 & age <= 24 ~ 1,
                                cancer == 0 & age <= 29 ~ 4,
                                cancer == 0 & age <= 34 ~ 6,
                                cancer == 0 & age <= 39 ~ 8,
                                cancer == 0 & age <= 44 ~ 10,
                                cancer == 0 & age <= 49 ~ 12,
                                cancer == 0 & age <= 54 ~ 14,
                                cancer == 0 & age <= 59 ~ 16,
                                cancer == 0 & age <= 64 ~ 18,
                                cancer == 0 & age <= 69 ~ 20,
                                cancer == 0 & age <= 74 ~ 22,
                                cancer == 0 & age <= 79 ~ 24,
                                cancer == 0 & age <= 84 ~ 26,
                                cancer == 0 & age <= 89 ~ 28,
                                cancer == 0 & age <= 94 ~ 30,
                                cancer == 0 & age <= 99 ~ 32,
                                cancer == 0 & age >= 100 ~ 34),
         RAI_A = age_cancer + ifelse(sex == 1, 3, 0) +
           ifelse(wtloss == 1, 8, 0) +
           ifelse(dialysis == 1 | renafail == 1, 8, 0) +
           ifelse(hxchf == 1, 5, 0) +
           ifelse(dyspnea == 3, 3, 0) +
           ifelse(transt %in% c(2, 3, 4, 5), 1, 0) +
           case_when(fnstatus == 2 ~ 7,
                     fnstatus == 3 ~ 14,
                     TRUE ~ 0))

data <- data %>%
  mutate(RAI_A = case_when(is.na(age_cancer) | is.na(sex) | is.na(wtloss) | is.na(dialysis) |
                             is.na(renafail) | is.na(hxchf) | is.na(dyspnea) | is.na(transt) |
                             is.na(fnstatus) | fnstatus == 4 ~ NA_real_,
                           TRUE ~ RAI_A),
         RAI_MISSINGNESS = case_when(is.na(RAI_A) ~ TRUE,
                                     !is.na(RAI_A) ~ FALSE))

data <- data %>%
  mutate(RAI_A4 = case_when(between(RAI_A, 0, 20) ~ "0Robust",
                            between(RAI_A, 21, 29) ~ "1Normal",
                            between(RAI_A, 30, 39) ~ "2Frail",
                            RAI_A >= 40 ~ "3VeryFrail"))
