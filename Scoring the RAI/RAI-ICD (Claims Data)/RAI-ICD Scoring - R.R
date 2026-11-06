#R Code for Scoring the RAI-ICD

library(tidyverse)

rai_icd <- data %>% 
  mutate(
    remission_esophagus = ifelse(if_any(starts_with("diagnosis.code."), ~ . %in% "Z8501"), 1, 0),
    cancer_esophagus = ifelse(if_any(starts_with("diagnosis.code."), ~ . %in% c("C153", "C154", "C155", "C158", "C159")), 1, 0),
    remission_liver = ifelse(if_any(starts_with("diagnosis.code."), ~ . %in% "Z8505"), 1, 0),
    cancer_liver = ifelse(if_any(starts_with("diagnosis.code."), ~ . %in% c("C153", "C154", "C155", "C158", "C159","C227", "C228", "C229")), 1, 0),
    remission_pancreas = ifelse(if_any(starts_with("diagnosis.code."), ~ . %in% "Z8507"), 1, 0),
    cancer_pancreas = ifelse(if_any(starts_with("diagnosis.code."), ~ . %in% c("C250", "C251", "C252", "C253", "C254", "C257", "C258", "C259")), 1, 0),
    remission_trachea = ifelse(if_any(starts_with("diagnosis.code."), ~ . %in% "Z8512"), 1, 0),
    cancer_trachea = ifelse(if_any(starts_with("diagnosis.code."), ~ . %in% "C33"), 1, 0),
    remission_bronch_lung = ifelse(if_any(starts_with("diagnosis.code."), ~ . %in% "Z85118"), 1, 0),
    cancer_bronch_lung = ifelse(if_any(starts_with("diagnosis.code."), ~ . %in% c("C3400", "C3401", "C3402", "C3410", "C3411", "C3412", "C342", "C3430", "C3431", "C3432",
                                                                                "C3480", "C3481", "C3482", "C3490", "C3491", "C3492")), 1, 0),
    remission_brain = ifelse(if_any(starts_with("diagnosis.code."), ~ . %in% "Z85841"), 1, 0),
    cancer_brain = ifelse(if_any(starts_with("diagnosis.code."), ~ . %in% c("C710", "C711", "C712", "C713", "C714", "C715", "C716", "C717", "C718", "C719")), 1, 0),
    remission_leukemia = ifelse(if_any(starts_with("diagnosis.code."), ~ . %in% "Z856"), 1, 0),
    cancer_leukemia_severe = ifelse(if_any(starts_with("diagnosis.code."), ~ . %in% c("C9200", "C9202", "C9260", "C9262", "C92A0", "C92A2", "C9300", "C93Z0", "C93Z2", "C9390", "C9392",
                                                                                    "C9302", "C9310", "C9312", "C9330", "C9332")), 1, 0),
    )

rai_icd <- rai_icd %>%
  mutate(
    active_liver = if_else(cancer_liver == 1 & remission_liver != 1, 1, 0),
    active_pancreas = if_else(cancer_pancreas == 1 & remission_pancreas != 1, 1, 0),
    active_trachea = if_else(cancer_trachea == 1 & remission_trachea != 1, 1, 0),
    active_bronch_lung = if_else(cancer_bronch_lung == 1 & remission_bronch_lung != 1, 1, 0),
    active_brain = if_else(cancer_brain == 1 & remission_brain != 1, 1, 0),
    active_leukemia = if_else(cancer_leukemia_severe == 1 & remission_leukemia != 1, 1, 0)
  )

active_cancer_columns <- grep("active_", names(rai_icd), value = TRUE)

rai_icd <- rai_icd %>%
  rowwise() %>%
  mutate(cancer_rai_severe = as.integer(any(c_across(all_of(active_cancer_columns)) == 1, na.rm = TRUE))) %>%
  ungroup()

specific_cancer_codes <- c("C23", "C240", "C241", "C248", "C249", "C450", "C451", "C452", 
                           "C457", "C459", "C770", "C771", "C772", "C773", "C774", "C775", 
                           "C778", "C779", "C7800", "C7801", "C7802", "C781", "C782", "C7830", 
                           "C7839", "C784", "C785", "C786", "C787", "C7880", "C7889", "C7900", 
                           "C7901", "C7902", "C7910", "C7911", "C7919", "C792", "C7931", "C7932", 
                           "C7940", "C7949", "C7951", "C7952", "C7960", "C7961", "C7962", "C7963", 
                           "C7970", "C7971", "C7972", "C7981", "C7982", "C7989", "C799", "C800", 
                           "C7B00", "C7B01", "C7B02", "C7B03", "C7B04", "C7B09", "C7B1", "C7B8")

rai_icd <- rai_icd %>%
  mutate(cancer_rai_severe = if_else(if_any(starts_with("diagnosis.code."), ~ . %in% specific_cancer_codes), 1, cancer_rai_severe))


rai_icd <- merge(rai_icd,
                 rai_icd_main[, c("empi", "gender")],
                 by = "empi",
                 all.x = TRUE)

rai_icd <- rai_icd %>%
  mutate(
    age_cat_rai_severe = case_when(
      age_r <= 19 & cancer_rai_severe == 1 ~ 43,
      age_r <= 19 ~ 0,
      age_r >= 20 & age_r < 25 & cancer_rai_severe == 1 ~ 43,
      age_r >= 20 & age_r < 25 ~ 2,
      age_r >= 25 & age_r < 30 & cancer_rai_severe == 1 ~ 43,
      age_r >= 25 & age_r < 30 ~ 4,
      age_r >= 30 & age_r < 35 & cancer_rai_severe == 1 ~ 44,
      age_r >= 30 & age_r < 35 ~ 6,
      age_r >= 35 & age_r < 40 & cancer_rai_severe == 1 ~ 44,
      age_r >= 35 & age_r < 40 ~ 9,
      age_r >= 40 & age_r < 45 & cancer_rai_severe == 1 ~ 44,
      age_r >= 40 & age_r < 45 ~ 11,
      age_r >= 45 & age_r < 50 & cancer_rai_severe == 1 ~ 44,
      age_r >= 45 & age_r < 50 ~ 13,
      age_r >= 50 & age_r < 55 & cancer_rai_severe == 1 ~ 44,
      age_r >= 50 & age_r < 55 ~ 15,
      age_r >= 55 & age_r < 60 & cancer_rai_severe == 1 ~ 44,
      age_r >= 55 & age_r < 60 ~ 18,
      age_r >= 60 & age_r < 65 & cancer_rai_severe == 1 ~ 45,
      age_r >= 60 & age_r < 65 ~ 20,
      age_r >= 65 & age_r < 70 & cancer_rai_severe == 1 ~ 45,
      age_r >= 65 & age_r < 70 ~ 22,
      age_r >= 70 & age_r < 75 & cancer_rai_severe == 1 ~ 45,
      age_r >= 70 & age_r < 75 ~ 25,
      age_r >= 75 & age_r < 80 & cancer_rai_severe == 1 ~ 45,
      age_r >= 75 & age_r < 80 ~ 27,
      age_r >= 80 & age_r < 85 & cancer_rai_severe == 1 ~ 45,
      age_r >= 80 & age_r < 85 ~ 29,
      age_r >= 85 & age_r < 90 & cancer_rai_severe == 1 ~ 46,
      age_r >= 85 & age_r < 90 ~ 31,
      age_r >= 90 & age_r < 95 & cancer_rai_severe == 1 ~ 46,
      age_r >= 90 & age_r < 95 ~ 34,
      age_r >= 95 & age_r < 100 & cancer_rai_severe == 1 ~ 46,
      age_r >= 95 & age_r < 100 ~ 36,
      age_r >= 100 & cancer_rai_severe == 1 ~ 46,
      age_r >= 100 ~ 38,
      TRUE ~ NA_real_  # Default case if none of the above conditions are met
    )
  )

rai_icd <- rai_icd %>% mutate(sex_score = ifelse(gender == "M", 3, 0))

rai_icd <- rai_icd %>%
  mutate(weight_loss_rai = if_else(if_any(starts_with("diagnosis.code."), ~ . %in% c("R634", "R636", "R64", "R627", "M6284","M6250")), 2, 0),
         poor_appetite_rai = if_else(if_any(starts_with("diagnosis.code."), ~ . %in% c("R630", "R6339", "R638", "R6330")), 1, 0),
         renal_failure_rai = if_else(if_any(starts_with("diagnosis.code."), ~ . %in% c("N184", "N185", "N186", "I120", "I1311", "I132", "Z4901", "Z4902", "Z4931", "Z4932", "Z992", "Z9115")), 3, 0),
         chf_rai = if_else(if_any(starts_with("diagnosis.code."), ~ . %in% c("I501", "I5020", "I5021", "I5022", "I5023", "I5030", "I5031", "I5032", "I5033", "I5040", "I5041", "I5042", "I5043", "I50810",
                                                                             "I50811", "I50812", "I50813", "I50814", "I5082", "I5083", "I5084", "I5089", "I509", "I0981", "I110", "I130")), 3, 0),
         shortness_breath_rai = if_else(if_any(starts_with("diagnosis.code."), ~ . %in% c("R0600", "R0601", "R0602", "R0603", "R0609", "Z9981", "J9610", "J9611", "J9612")), 2, 0),
         cogn_decline_rai = if_else(if_any(starts_with("diagnosis.code."), ~ . %in% c("F0150", "F01511", "F01518", "F0280", "F02811", "F02818", "F0390", "F03911", "F03918", 
                                                                                      "F04", "G300", "G301", "G308", "G309", "G3101", "G3109", "G311", "G312", "G3181", 
                                                                                      "G3182", "G3183", "G3184", "G3185", "G3189", "G319", "R4181", "F1096", "F1027", "F1097", 
                                                                                      "F1327", "F1397", "F1897", "F1917", "F1927", "F1997")), 1, 0),
         partially_dependent_rai = if_else(if_any(starts_with("diagnosis.code."), ~ . %in% c(
           "G8100", "G8101", "G8102", "G8103", "G8104",
           "G8110", "G8111", "G8112", "G8113", "G8114",
           "G8190", "G8191", "G8192", "G8193", "G8194",
           "G8221", "G8222",
           "G8310", "G8311", "G8312", "G8313", "G8314",
           "G8320", "G8321", "G8322", "G8323", "G8324",
           "Z741", "Z742", "Z736", "Z9181", "R260",
           "R261", "R262", "R2681", "R269", "R54",
           "R531", "R5381", "R5382", "R5383", "R530",
           "M6281", "M623",
           "L89000", "L89001", "L89002", "L89003", "L89004",
           "L89006", "L89009", "L89010", "L89011", "L89012",
           "L89013", "L89014", "L89016", "L89019", "L89020",
           "L89021", "L89022", "L89023", "L89024", "L89026",
           "L89029", "L89100", "L89101", "L89102", "L89103",
           "L89104", "L89106", "L89109", "L89110", "L89111",
           "L89112", "L89113", "L89114", "L89116", "L89119",
           "L89120", "L89121", "L89122", "L89123", "L89124",
           "L89126", "L89129", "L89130", "L89131", "L89132",
           "L89133", "L89134", "L89136", "L89139", "L89140",
           "L89141", "L89142", "L89143", "L89144", "L89146",
           "L89149", "L89150", "L89151", "L89152", "L89153",
           "L89154", "L89156", "L89159", "L89200", "L89201",
           "L89202", "L89203", "L89204", "L89206", "L89209",
           "L89210", "L89211", "L89212", "L89213", "L89214",
           "L89216", "L89219", "L89220", "L89221", "L89222",
           "L89223", "L89224", "L89226", "L89229", "L89300",
           "L89301", "L89302", "L89303", "L89304", "L89306",
           "L89309", "L89310", "L89311", "L89312", "L89313",
           "L89314", "L89316", "L89319", "L89320", "L89321",
           "L89322", "L89323", "L89324", "L89326", "L89329",
           "L8940", "L8941", "L8942", "L8943", "L8944",
           "L8945", "L8946", "L89500", "L89501", "L89502",
           "L89503", "L89504", "L89506", "L89509", "L89510",
           "L89511", "L89512", "L89513", "L89514", "L89516",
           "L89519", "L89520", "L89521", "L89522", "L89523",
           "L89524", "L89526", "L89529", "L89600", "L89601",
           "L89602", "L89603", "L89604", "L89606", "L89609",
           "L89610", "L89611", "L89612", "L89613", "L89614",
           "L89616", "L89619", "L89620", "L89621", "L89622",
           "L89623", "L89624", "L89626", "L89629", "L89810",
           "L89811", "L89812", "L89813", "L89814", "L89816",
           "L89819", "L89890", "L89891", "L89892", "L89893",
           "L89894", "L89896", "L89899", "L8990", "L8991",
           "L8992", "L8993", "L8994", "L8995", "L8996"
         )), 1, 0),
         totally_dependent_rai = if_else(if_any(starts_with("diagnosis.code."), ~ . %in% c("Z7401", "Z7409", "Z743", "Z993", "R532", "Z9989", "G8250", "G8251", "G8252", "G8253", "G8254")), 1, 0)                     
  )

rai_icd <- rai_icd %>%
  mutate(
    adl_rai = case_when(
      cogn_decline_rai == 0 & partially_dependent_rai == 1 ~ 10,
      cogn_decline_rai == 0 & totally_dependent_rai == 1 ~ 20,
      cogn_decline_rai == 1 & partially_dependent_rai == 1 ~ 15,
      cogn_decline_rai == 1 & totally_dependent_rai == 1 ~ 21,
      cogn_decline_rai == 1 ~ 9,
      TRUE ~ 0 
    )
  )

rai_icd <- rai_icd %>%
  rowwise() %>%
  mutate(RAI_ICD = sum(c_across(c(age_cat_rai_severe, sex_score, weight_loss_rai, poor_appetite_rai, renal_failure_rai, chf_rai, shortness_breath_rai, adl_rai)), na.rm = TRUE)) %>%
  ungroup()

rai_icd <- rai_icd %>%
  select(RAI_ICD, everything())
