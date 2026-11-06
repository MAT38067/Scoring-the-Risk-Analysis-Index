*Stata Code for Scoring the RAI-A

*NSQIP
// sex is coded as Male=1 and Female=0
gen sex_score=.
replace sex_score=3 if sex=="male"
replace sex_score=0 if sex=="female"

// discancr==2 means cancer, discancr==1 means no cancer
//if desired, radio and chemo can also be used here to determine disseminated cancer
gen cancer = discancr=="Yes" | radio=="Yes" | chemo=="Yes"
replace cancer=. if mi(discancr) & mi(radio) & mi(chemo)

gen age_cancer_score= 0 if age <= 19 & cancer==0
replace age_cancer_score = 28 if age <= 19 & cancer==1
replace age_cancer_score=1 if (age >= 20 & age <= 24) & cancer==0
replace age_cancer_score = 29 if (age >= 20 & age <= 24) & cancer==1
replace age_cancer_score=4 if (age >= 25 & age <= 29) & cancer==0
replace age_cancer_score = 29 if (age >= 25 & age <= 29) & cancer==1
replace age_cancer_score=6 if (age >= 30 & age <= 34) & cancer==0
replace age_cancer_score = 30 if (age >= 30 & age <= 34) & cancer==1
replace age_cancer_score=8 if (age >= 35 & age <= 39) & cancer==0
replace age_cancer_score = 30 if (age >= 35 & age <= 39) & cancer==1
replace age_cancer_score=10 if (age >= 40 & age <= 44) & cancer==0
replace age_cancer_score = 31 if (age >= 40 & age <= 44) & cancer==1
replace age_cancer_score=12 if (age >= 45 & age <= 49) & cancer==0
replace age_cancer_score = 31 if (age >= 45 & age <= 49) & cancer==1
replace age_cancer_score=14 if (age >= 50 & age <= 54) & cancer==0
replace age_cancer_score = 32 if (age >= 50 & age <= 54) & cancer==1
replace age_cancer_score=16 if (age >= 55 & age <= 59) & cancer==0
replace age_cancer_score = 32 if (age >= 55 & age <= 59) & cancer==1
replace age_cancer_score=18 if (age >= 60 & age <= 64) & cancer==0
replace age_cancer_score = 33 if (age >= 60 & age <= 64) & cancer==1
replace age_cancer_score=20 if (age >= 65 & age <= 69) & cancer==0
replace age_cancer_score = 34 if (age >= 65 & age <= 69) & cancer==1
replace age_cancer_score=22 if (age >= 70 & age <= 74) & cancer==0
replace age_cancer_score = 34 if (age >= 70 & age <= 74) & cancer==1
replace age_cancer_score=24 if (age >= 75 & age <= 79) & cancer==0
replace age_cancer_score = 35 if (age >= 75 & age <= 79) & cancer==1
replace age_cancer_score=26 if (age >= 80 & age <= 84) & cancer==0
replace age_cancer_score = 35 if (age >= 80 & age <= 84) & cancer==1
replace age_cancer_score=28 if (age >= 85 & age <= 89) & cancer==0
replace age_cancer_score = 36 if (age >= 85 & age <= 89) & cancer==1
replace age_cancer_score=30 if (age >= 90 & age <= 94) & cancer==0
replace age_cancer_score = 36 if (age >= 90 & age <= 94) & cancer==1
replace age_cancer_score=32 if (age >= 95 & age <= 99) & cancer==0
replace age_cancer_score = 37 if (age >= 95 & age <= 99) & cancer==1
replace age_cancer_score=34 if age >= 100 & cancer==0
replace age_cancer_score = 37 if age >= 100 & cancer==1

*weight loss
gen wtloss_score=.
replace wtloss_score=8 if wtloss=="Yes"
replace wtloss_score=0 if wtloss=="No"

*renal failure
gen renal_fail=.
replace renal_fail=1 if renafail=="Yes" | dialysis=="Yes"
replace renal_fail=0 if renafail=="No" & dialysis=="No"
gen renal_score=.
replace renal_score=8 if renal_fail==1
replace renal_score=0 if renal_fail==0

*CHF
gen chf_score=.
replace chf_score=5 if hxchf=="Yes"
replace chf_score=0 if hxchf=="No"

*Dyspnea
gen dyspnea_score=.
replace dyspnea_score=3 if dyspnea=="AT REST"
replace dyspnea_score=0 if dyspnea=="MODERATE EXERTION" | dyspnea=="No"

*Residence not Independent
gen new_transt=.
replace new_transt=1 if transt=="Nursing home - Chronic care - Intermediate care" | transt=="Transfer from other"
replace new_transt=0 if new_transt==.
gen transt_score=.
replace transt_score=1 if new_transt==1
replace transt_score=0 if new_transt==0

*ADL
gen adl=.
replace adl=1 if fnstatus2=="Independent"
replace adl=2 if fnstatus2=="Partially Dependent"
replace adl=3 if fnstatus2=="Totally Dependent"

*Cog (impsens, coma, and cva were phased out in 2015; this code uses the data if available and otherwise assignes a value of 0 assuming no cognitive deterioration)
gen cog=.
replace cog=1 if impsens=="Yes" | coma=="Yes" | cva=="Yes"
replace cog=0 if cog==.

*ADL*Cog
gen adl_cog_score=.
replace adl_cog_score=0 if adl==1 & cog==0
replace adl_cog_score=5 if adl==1 & cog==1
replace adl_cog_score=7 if adl==2 & cog==0
replace adl_cog_score=11 if adl==2 & cog==1
replace adl_cog_score=14 if adl==3 & cog==0
replace adl_cog_score=16 if adl==3 & cog==1

*RAI Score
gen rai_score=.
replace rai_score = sex_score + age_cancer_score + wtloss_score + renal_score + chf_score + dyspnea_score + transt_score + adl_cog_score


*VASQIP
gen renal=0 if renafail==0 & dialysis==0
replace renal=1 if renafail==1| dialysis==1

// sex is coded as Male=1 and Female=0
gen sex_score=3 if sex == 1
replace sex_score=0 if sex == 0
replace sex_score=. if sex ==.

//if desired, radio and chemo can also be used here to determine disseminated cancer
gen cancer=1 if discancr==1
replace cancer=0 if discancr==0
gen age_cancer_score= 0 if age <= 19 & cancer==0
replace age_cancer_score = 28 if age <= 19 & cancer==1
replace age_cancer_score=1 if (age >= 20 & age <= 24) & cancer==0
replace age_cancer_score = 29 if (age >= 20 & age <= 24) & cancer==1
replace age_cancer_score=4 if (age >= 25 & age <= 29) & cancer==0
replace age_cancer_score = 29 if (age >= 25 & age <= 29) & cancer==1
replace age_cancer_score=6 if (age >= 30 & age <= 34) & cancer==0
replace age_cancer_score = 30 if (age >= 30 & age <= 34) & cancer==1
replace age_cancer_score=8 if (age >= 35 & age <= 39) & cancer==0
replace age_cancer_score = 30 if (age >= 35 & age <= 39) & cancer==1
replace age_cancer_score=10 if (age >= 40 & age <= 44) & cancer==0
replace age_cancer_score = 31 if (age >= 40 & age <= 44) & cancer==1
replace age_cancer_score=12 if (age >= 45 & age <= 49) & cancer==0
replace age_cancer_score = 31 if (age >= 45 & age <= 49) & cancer==1
replace age_cancer_score=14 if (age >= 50 & age <= 54) & cancer==0
replace age_cancer_score = 32 if (age >= 50 & age <= 54) & cancer==1
replace age_cancer_score=16 if (age >= 55 & age <= 59) & cancer==0
replace age_cancer_score = 32 if (age >= 55 & age <= 59) & cancer==1
replace age_cancer_score=18 if (age >= 60 & age <= 64) & cancer==0
replace age_cancer_score = 33 if (age >= 60 & age <= 64) & cancer==1
replace age_cancer_score=20 if (age >= 65 & age <= 69) & cancer==0
replace age_cancer_score = 34 if (age >= 65 & age <= 69) & cancer==1
replace age_cancer_score=22 if (age >= 70 & age <= 74) & cancer==0
replace age_cancer_score = 34 if (age >= 70 & age <= 74) & cancer==1
replace age_cancer_score=24 if (age >= 75 & age <= 79) & cancer==0
replace age_cancer_score = 35 if (age >= 75 & age <= 79) & cancer==1
replace age_cancer_score=26 if (age >= 80 & age <= 84) & cancer==0
replace age_cancer_score = 35 if (age >= 80 & age <= 84) & cancer==1
replace age_cancer_score=28 if (age >= 85 & age <= 89) & cancer==0
replace age_cancer_score = 36 if (age >= 85 & age <= 89) & cancer==1
replace age_cancer_score=30 if (age >= 90 & age <= 94) & cancer==0
replace age_cancer_score = 36 if (age >= 90 & age <= 94) & cancer==1
replace age_cancer_score=32 if (age >= 95 & age <= 99) & cancer==0
replace age_cancer_score = 37 if (age >= 95 & age <= 99) & cancer==1
replace age_cancer_score=34 if age >= 100 & cancer==0
replace age_cancer_score = 37 if age >= 100 & cancer==1

gen wtloss_score=4 if wtloss == 1
replace wtloss_score=0 if wtloss !=1
replace wtloss_score=. if wtloss==.

gen CHF_score=5 if hxchf == 1
replace CHF_score=0 if hxchf !=1
replace CHF_score=. if hxchf==.

gen PoorApp_score=4 if wtloss == 1
replace PoorApp_score=0 if wtloss !=1
replace PoorApp_score=. if wtloss==.

gen dyspnea_score=3 if dyspnea == 1
replace dyspnea_score=0 if dyspnea !=1
replace dyspnea_score=. if dyspnea==.

gen transt_score=0 if transt == 1 | transt==2 | transt==3 | transt==6
replace transt_score=1 if transt ==4 | transt==5
replace transt_score=. if transt==.

// for fnstatus2, Independent=1 Partially dependent=2 Totally dependent=3 Unknown=4
recode fnstatus 4=.
gen ADLCog_score=0 if fnstatus==1 & cognitive==0
replace ADLCog_score=5 if fnstatus==1 & cognitive==1
replace ADLCog_score=7 if fnstatus==2 & cognitive==0
replace ADLCog_score=11 if fnstatus==2 & cognitive==1
replace ADLCog_score=14 if fnstatus==3 & cognitive==0
replace ADLCog_score=16 if fnstatus==3 & cognitive==1

gen RAI_A=sex_score + age_cancer_score + wtloss_score + renal_score + CHF_score + PoorApp_score + dyspnea_score + transt_score + ADLCog_score
