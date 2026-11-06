#R Code for Scoring the RAI-C

library(tidyverse)

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
         adl_sum = adl_mobility + adl_eating + adl_toileting + adl_hygiene,
         RAI_C = age_cancer + ifelse(sex == 1, 3, 0) +
           ifelse(wtloss == 1, 8, 0) +
           ifelse(dialysis == 1 | renafail == 1, 8, 0) +
           ifelse(hxchf == 1, 5, 0) +
           ifelse(dyspnea == 3, 3, 0) +
           ifelse(independent_living == 0, 1, 0) +
           case_when(adl_sum == 0 & cognitive == 0 ~ 0,
                     adl_sum == 0 & cognitive == 1 ~ 5,
                     adl_sum == 1 & cognitive == 0 ~ 1,
                     adl_sum == 1 & cognitive == 1 ~ 6,
                     adl_sum == 2 & cognitive == 0 ~ 2,
                     adl_sum == 2 & cognitive == 1 ~ 6,
                     adl_sum == 3 & cognitive == 0 ~ 3,
                     adl_sum == 3 & cognitive == 1 ~ 7,
                     adl_sum == 4 & cognitive == 0 ~ 4,
                     adl_sum == 4 & cognitive == 1 ~ 8,
                     adl_sum == 5 & cognitive == 0 ~ 4,
                     adl_sum == 5 & cognitive == 1 ~ 8,
                     adl_sum == 6 & cognitive == 0 ~ 5,
                     adl_sum == 6 & cognitive == 1 ~ 9,
                     adl_sum == 7 & cognitive == 0 ~ 6,
                     adl_sum == 7 & cognitive == 1 ~ 10,
                     adl_sum == 8 & cognitive == 0 ~ 7,
                     adl_sum == 8 & cognitive == 1 ~ 11,
                     adl_sum == 9 & cognitive == 0 ~ 8,
                     adl_sum == 9 & cognitive == 1 ~ 11,
                     adl_sum == 10 & cognitive == 0 ~ 9,
                     adl_sum == 10 & cognitive == 1 ~ 12,
                     adl_sum == 11 & cognitive == 0 ~ 10,
                     adl_sum == 11 & cognitive == 1 ~ 13,
                     adl_sum == 12 & cognitive == 0 ~ 11,
                     adl_sum == 12 & cognitive == 1 ~ 13,
                     adl_sum == 13 & cognitive == 0 ~ 11,
                     adl_sum == 13 & cognitive == 1 ~ 14,
                     adl_sum == 14 & cognitive == 0 ~ 12,
                     adl_sum == 14 & cognitive == 1 ~ 15,
                     adl_sum == 15 & cognitive == 0 ~ 13,
                     adl_sum == 15 & cognitive == 1 ~ 15,
                     adl_sum == 16 & cognitive == 0 ~ 14,
                     adl_sum == 16 & cognitive == 1 ~ 16,
                     TRUE ~ NA_real_))

data <- data %>%
  mutate(RAI_C = case_when(is.na(age_cancer) | is.na(sex) | is.na(wtloss) | is.na(dialysis) |
                             is.na(renafail) | is.na(hxchf) | is.na(dyspnea) | is.na(independent_living) |
                             is.na(adl_sum) | is.na(cognitive) ~ NA_real_,
                           TRUE ~ RAI_C),
         RAI_MISSINGNESS = case_when(is.na(RAI_C) ~ TRUE,
                                     !is.na(RAI_C) ~ FALSE))

data <- data %>%
  mutate(RAI_C2 = case_when(between(RAI_C, 0, 36) ~ "Not Frail",
                            RAI_C >= 37 ~ "Frail"))
