log using  "/Users/katiereitz/OneDrive - UPMC/UPMC Research/NIS/NIS RAI/Round 5/Log/ICD10-RAI-Validation-2020 creating Cancer and RAI variables.log" , replace

/*************************************************
**Add RAI code - SEVERE
Re-generating the RAI code for severe in the 2020 file
Then VALIDATING 
*************************************************/

use  "/Users/katiereitz/OneDrive - UPMC/UPMC Research/NIS/Raw Data/2020/NIS_2020_Core.dta", clear
*use "/Users/katiereitz/OneDrive - UPMC/UPMC Research/NIS/Raw Data/2020/NIS_2020_Core.dta"

destring age, replace

generate remission_esophagus = 0 
foreach num of numlist 1/40 { 
foreach var of varlist i10_dx`num' {
replace remission_esophagus = 1 if (inlist(`var', "Z8501"))
}
}

generate cancer_esophagus = 0 
foreach num of numlist 1/40 { 
foreach var of varlist i10_dx`num' {
replace cancer_esophagus = 1 if (inlist(`var', "C153", "C154", "C155", "C158", "C159"))
}
}

gen active_esophagus = 1 if cancer_esophagus == 1 & remission_esophagus!= 1 

*replace cancer_rai = 0 if remission_esophagus == 1 & cancer_esophagus == 1 // esophagus
//

generate remission_liver = 0 
foreach num of numlist 1/40 { 
foreach var of varlist i10_dx`num' {
replace remission_liver = 1 if (inlist(`var', "Z8505"))
}
}

generate cancer_liver = 0 
foreach num of numlist 1/40 { 
foreach var of varlist i10_dx`num' {
replace cancer_liver = 1 if (inlist(`var', "C220", "C221", "C222", "C223", "C224") | inlist(`var', "C227", "C228", "C229"))
}
}

gen active_liver = 1 if cancer_liver==1 & remission_liver!=1
*replace cancer_rai = 0 if remission_liver == 1 & cancer_liver == 1 // liver 
//

generate remission_pancreas = 0 
foreach num of numlist 1/40 { 
foreach var of varlist i10_dx`num' {
replace remission_pancreas = 1 if (inlist(`var', "Z8507"))
}
}

generate cancer_pancreas = 0 
foreach num of numlist 1/40 { 
foreach var of varlist i10_dx`num' {
replace cancer_pancreas = 1 if (inlist(`var', "C250", "C251", "C252", "C253", "C254") | inlist(`var', "C257", "C258", "C259"))
}
}

gen active_pancreas = 1 if cancer_pancreas==1 & remission_pancreas!=1
*replace cancer_rai = 0 if remission_pancreas == 1 & cancer_pancreas == 1 // pancreas

generate remission_trachea = 0 
foreach num of numlist 1/40 { 
foreach var of varlist i10_dx`num' {
replace remission_trachea = 1 if (inlist(`var', "Z8512"))
}
}

generate cancer_trachea = 0 
foreach num of numlist 1/40 { 
foreach var of varlist i10_dx`num' {
replace cancer_trachea = 1 if (inlist(`var', "C33"))
}
}

gen active_trachea = 1 if cancer_trachea==1 & remission_trachea!=1
*replace cancer_rai = 0 if remission_trachea == 1 & cancer_trachea == 1 // trachea
//

generate remission_bronch_lung = 0 
foreach num of numlist 1/40 { 
foreach var of varlist i10_dx`num' {
replace remission_bronch_lung = 1 if (inlist(`var', "Z85118"))
}
}

generate cancer_bronch_lung = 0 
foreach num of numlist 1/40 { 
foreach var of varlist i10_dx`num' {
replace cancer_bronch_lung = 1 if (inlist(`var', "C3400", "C3401", "C3402", "C3410", "C3411") | inlist(`var', "C3412", "C342", "C3430", "C3431", "C3432") | inlist(`var', "C3480", "C3481", "C3482", "C3490", "C3491") | inlist(`var', "C3492"))
}
}

gen active_bronch = 1 if cancer_bronch_lung==1 & remission_bronch_lung!=1
*replace cancer_rai = 0 if remission_bronch_lung == 1 & cancer_bronch_lung == 1 // bronch&lungs
//

generate remission_brain = 0 
foreach num of numlist 1/40 { 
foreach var of varlist i10_dx`num' {
replace remission_brain = 1 if (inlist(`var', "Z85841"))
}
}

generate cancer_brain = 0 
foreach num of numlist 1/40 { 
foreach var of varlist i10_dx`num' {
replace cancer_brain = 1 if (inlist(`var', "C710", "C711", "C712") | inlist(`var', "C713", "C714", "C715", "C716", "C717") | inlist(`var', "C718", "C719"))
}
}

gen active_brain =1 if cancer_brain==1 & remission_brain!=1
*replace cancer_rai = 0 if remission_brain == 1 & cancer_brain == 1 //brain
//

generate remission_leukemia = 0 
foreach num of numlist 1/40 { 
foreach var of varlist i10_dx`num' {
replace remission_leukemia = 1 if (inlist(`var', "Z856"))
}
}

generate cancer_leukemia_severe = 0 
foreach num of numlist 1/40 { 
foreach var of varlist i10_dx`num' {
replace cancer_leukemia_severe = 1 if (inlist(`var', "C9200", "C9202") | inlist(`var', "C9260", "C9262", "C92A0", "C92A2", "C9300") | inlist(`var', "C9302", "C9310", "C9312", "C9330", "C9332") | inlist(`var', "C93Z0", "C93Z2", "C9390", "C9392"))
}
}

gen active_leukemia_severe = 1 if cancer_leukemia_severe==1 & remission_leukemia!=1
*replace cancer_rai = 0 if remission_leukemia == 1 & cancer_leukemia_severe == 1 //leukemia
//

**This will add in any C codes w/o z codes
gen cancer_rai_severe =0
foreach var of varlist active_* {
	replace cancer_rai_severe = 1 if `var'==1
}

**THIS MUST BE ONLY THE ONES THAT ARE C-CODE WIHTOUT Z-CODES
foreach num of numlist 1/40 { 
foreach var of varlist i10_dx`num' {
replace cancer_rai_severe = 1 if (inlist(`var', "C23" "C240") | inlist(`var', "C241", "C248", "C249", "C450", "C451") | inlist(`var', "C452", "C457", "C459", "C770", "C771") | inlist(`var', "C772") | inlist(`var', "C773", "C774", "C775", "C778", "C779") | inlist(`var', "C7800", "C7801", "C7802", "C781", "C782") | inlist(`var', "C7830", "C7839", "C784", "C785", "C786") | inlist(`var', "C787", "C7880", "C7889") | inlist(`var', "C7900", "C7901", "C7902", "C7910", "C7911") | inlist(`var', "C7919", "C792", "C7931", "C7932", "C7940") | inlist(`var', "C7949", "C7951", "C7952", "C7960", "C7961") | inlist(`var', "C7962", "C7963", "C7970", "C7971", "C7972") | inlist(`var', "C7981", "C7982", "C7989", "C799") | inlist(`var', "C800") | inlist(`var', "C7B00", "C7B01", "C7B02", "C7B03", "C7B04") | inlist(`var', "C7B09", "C7B1", "C7B8"))
}
}

**This will add in any C codes w/o z codes
foreach var of varlist active_* {
	replace cancer_rai_severe=1 if `var'==1
}


*Category 1 AGE & cancer (severe)
gen age_cat_rai_severe=.
replace age_cat_rai_severe=0 if age<=19
replace age_cat_rai_severe=43 if age<=19 & cancer_rai_severe == 1

replace age_cat_rai_severe=2 if age>=20 & age<25
replace age_cat_rai_severe=43 if age>=20 & age<25 & cancer_rai_severe == 1

replace age_cat_rai_severe=4 if age>=25 & age<30
replace age_cat_rai_severe=43 if age>=25 & age<30 & cancer_rai_severe == 1

replace age_cat_rai_severe=6 if age>=30 & age<35
replace age_cat_rai_severe=44 if age>=30 & age<35 & cancer_rai_severe == 1

replace age_cat_rai_severe=9 if age>=35 & age<40
replace age_cat_rai_severe=44 if age>=35 & age<40 & cancer_rai_severe == 1

replace age_cat_rai_severe=11 if age>=40 & age<45
replace age_cat_rai_severe=44 if age>=40 & age<45 & cancer_rai_severe == 1

replace age_cat_rai_severe=13 if age>=45 & age<50
replace age_cat_rai_severe=44 if age>=45 & age<50 & cancer_rai_severe == 1

replace age_cat_rai_severe=15 if age>=50 & age<55
replace age_cat_rai_severe=44 if age>=50 & age<55 & cancer_rai_severe == 1

replace age_cat_rai_severe=18 if age>=55 & age<60
replace age_cat_rai_severe=44 if age>=55 & age<60 & cancer_rai_severe == 1

replace age_cat_rai_severe=20 if age>=60 & age<65
replace age_cat_rai_severe=45 if age>=60 & age<65 & cancer_rai_severe == 1

replace age_cat_rai_severe=22 if age>=65 & age<70
replace age_cat_rai_severe=45 if age>=65 & age<70 & cancer_rai_severe == 1

replace age_cat_rai_severe=25 if age>=70 & age<75
replace age_cat_rai_severe=45 if age>=70 & age<75 & cancer_rai_severe == 1

replace age_cat_rai_severe=27 if age>=75 & age<80
replace age_cat_rai_severe=45 if age>=75 & age<80 & cancer_rai_severe == 1

replace age_cat_rai_severe=29 if age>=80 & age<85
replace age_cat_rai_severe=45 if age>=80 & age<85 & cancer_rai_severe == 1

replace age_cat_rai_severe=31 if age>=85 & age<90
replace age_cat_rai_severe=46 if age>=85 & age<90 & cancer_rai_severe == 1

replace age_cat_rai_severe=34 if age>=90 & age<95
replace age_cat_rai_severe=46 if age>=90 & age<95 & cancer_rai_severe == 1

replace age_cat_rai_severe=36 if age>=95 & age<100
replace age_cat_rai_severe=46 if age>=95 & age<100 & cancer_rai_severe == 1

replace age_cat_rai_severe=38 if age>=100
replace age_cat_rai_severe=46 if age>=100 & cancer_rai_severe == 1


*Category 2 SEX
gen sex_score =.
replace sex_score = 0 if female==3 // F
replace sex_score = 3 if female!=3 // M

*Category 3 weight loss
generate weight_loss_rai = 0

foreach num of numlist 1/40 { 
foreach var of varlist i10_dx`num' {
replace weight_loss_rai = 2 if (inlist(`var', "R634", "R636", "R64", "R627", "M6284") | inlist(`var', "M6250"))
}
}

*Category 4 poor appetite
generate poor_appetite_rai = 0

foreach num of numlist 1/40 { 
foreach var of varlist i10_dx`num' {
replace poor_appetite_rai = 1 if (inlist(`var', "R630", "R6339", "R638", "R6330"))
}
}

*Category 5 renal failure // there was a rounding error here, brought up to 3!
generate renal_failure_rai = 0

foreach num of numlist 1/40 { 
foreach var of varlist i10_dx`num' {
replace renal_failure_rai = 3 if (inlist(`var', "N184", "N185", "N186", "I120", "I1311") | inlist(`var', "I132", "Z4901", "Z4902", "Z4931", "Z4932") | inlist(`var',"Z992", "Z9115"))
}
}


*Category 6 chf
generate chf_rai = 0

foreach num of numlist 1/40 { 
foreach var of varlist i10_dx`num' {
replace chf_rai = 3 if (inlist(`var', "I501", "I5020", "I5021", "I5022", "I5023") | inlist(`var', "I5030", "I5031", "I5032", "I5033") | inlist(`var', "I5040", "I5041", "I5042", "I5043", "I50810") | inlist(`var', "I50811", "I50812", "I50813", "I50814", "I5082") | inlist(`var', "I5083", "I5084", "I5089", "I509") | inlist(`var', "I0981", "I110", "I130"))
}
}

*Category 7 shortness of breath
generate shortness_breath_rai = 0

foreach num of numlist 1/40 { 
foreach var of varlist i10_dx`num' {
replace shortness_breath_rai = 2 if (inlist(`var', "R0600", "R0601", "R0602", "R0603", "R0609") | inlist(`var', "Z9981", "J9610", "J9611", "J9612"))
}
}

*Category 8 living status N/A


*Category 9 ADL
generate cogn_decline_rai = 0

foreach num of numlist 1/40 { 
foreach var of varlist i10_dx`num' {
replace cogn_decline_rai = 1 if (inlist(`var', "F0150", "F01511", "F01518", "F0280", "F02811") | inlist(`var', "F02818", "F0390", "F03911", "F03918") | inlist(`var', "F04", "G300", "G301", "G308", "G309") | inlist(`var', "G3101", "G3109", "G311", "G312", "G3181") | inlist(`var', "G3182", "G3183", "G3184", "G3185", "G3189") | inlist(`var', "G319", "R4181", "F1096", "F1027", "F1097") | inlist(`var', "F1327", "F1397", "F1897", "F1917", "F1927") | inlist(`var', "F1997"))
}
}


//Partially dependent 
generate partially_dependent_rai = 0

foreach num of numlist 1/40 { 
foreach var of varlist i10_dx`num' {
replace partially_dependent_rai = 1 if (inlist(`var', "G8100", "G8101", "G8102", "G8103", "G8104") | inlist(`var', "G8110", "G8111", "G8112", "G8113", "G8114") | inlist(`var', "G8190", "G8191", "G8192", "G8193", "G8194") | inlist(`var', "G8221", "G8222") | inlist(`var', "G8310", "G8311", "G8312", "G8313", "G8314") | inlist(`var', "G8320", "G8321", "G8322", "G8323", "G8324") | inlist(`var', "Z741", "Z742", "Z736", "Z9181", "R260") | inlist(`var', "R261", "R262", "R2681", "R269", "R54") | inlist(`var', "R531", "R5381", "R5382", "R5383", "R530") | inlist(`var', "M6281", "M623") | inlist(`var', "L89000", "L89001", "L89002", "L89003", "L89004") | inlist(`var', "L89006", "L89009", "L89010", "L89011", "L89012") | inlist(`var', "L89013", "L89014", "L89016", "L89019", "L89020") | inlist(`var', "L89021", "L89022", "L89023",  "L89024", "L89026") | inlist(`var', "L89029", "L89100", "L89101", "L89102", "L89103") | inlist(`var', "L89104", "L89106", "L89109", "L89110", "L89111") | inlist(`var', "L89112", "L89113", "L89114", "L89116", "L89119") | inlist(`var', "L89120", "L89121", "L89122", "L89123", "L89124") | inlist(`var', "L89126", "L89129", "L89130", "L89131", "L89132") | inlist(`var', "L89133", "L89134", "L89136", "L89139", "L89140") | inlist(`var', "L89141", "L89142", "L89143", "L89144", "L89146") | inlist(`var', "L89149", "L89150", "L89151", "L89152", "L89153") | inlist(`var', "L89154", "L89156", "L89159", "L89200", "L89201") | inlist(`var', "L89202", "L89203", "L89204", "L89206", "L89209") | inlist(`var', "L89210", "L89211", "L89212", "L89213", "L89214") | inlist(`var', "L89216", "L89219", "L89220", "L89221", "L89222") | inlist(`var', "L89223", "L89224", "L89226", "L89229", "L89300") | inlist(`var', "L89301", "L89302", "L89303", "L89304", "L89306") | inlist(`var', "L89309", "L89310", "L89311", "L89312", "L89313") | inlist(`var', "L89314", "L89316", "L89319", "L89320", "L89321") | inlist(`var', "L89322", "L89323", "L89324", "L89326", "L89329") | inlist(`var', "L8940", "L8941", "L8942", "L8943", "L8944") | inlist(`var', "L8945", "L8946", "L89500", "L89501", "L89502") | inlist(`var', "L89503", "L89504", "L89506", "L89509", "L89510") | inlist(`var', "L89511", "L89512", "L89513", "L89514", "L89516") | inlist(`var', "L89519", "L89520", "L89521", "L89522", "L89523") | inlist(`var', "L89524", "L89526", "L89529", "L89600", "L89601") | inlist(`var', "L89602", "L89603", "L89604", "L89606", "L89609") | inlist(`var', "L89610", "L89611", "L89612", "L89613", "L89614") | inlist(`var', "L89616", "L89619", "L89620", "L89621", "L89622") | inlist(`var', "L89623", "L89624", "L89626", "L89629", "L89810") | inlist(`var', "L89811", "L89812", "L89813", "L89814", "L89816") | inlist(`var', "L89819", "L89890", "L89891", "L89892", "L89893") | inlist(`var', "L89894", "L89896", "L89899", "L8990", "L8991") | inlist(`var', "L8992", "L8993", "L8994", "L8995", "L8996"))
}
}


//Totally dependent
generate totally_dependent_rai = 0

foreach num of numlist 1/40 {
foreach var of varlist i10_dx`num' { 
replace totally_dependent_rai = 1 if (inlist(`var', "Z7401", "Z7409", "Z743", "Z993", "R532") | inlist(`var', "Z9989", "G8250", "G8251", "G8252", "G8253") | inlist(`var', "G8254"))
}
}

//ADL
gen fxn_dependent_rai = 0  
replace fxn_dependent_rai = 1 if partially_dependent_rai ==1
replace fxn_dependent_rai = 2 if totally_dependent_rai ==1

generate adl_rai = 0

//without cogn decline
replace adl_rai = 0 if cogn_decline_rai == 0
replace adl_rai = 10 if cogn_decline_rai == 0 & partially_dependent_rai == 1
replace adl_rai = 20 if cogn_decline_rai == 0 & totally_dependent_rai == 1


//with cogn decline
replace adl_rai = 9 if cogn_decline_rai == 1
replace adl_rai = 15 if cogn_decline_rai == 1 & partially_dependent_rai == 1
replace adl_rai = 21 if cogn_decline_rai == 1 & totally_dependent_rai == 1 

*************************************************
*RAI- Severe
egen rai_severe=rowtotal(age_cat_rai_severe sex_score weight_loss_rai poor_appetite_rai renal_failure_rai chf_rai shortness_breath_rai adl_rai)
sum rai_severe
hist rai_severe

foreach num of numlist 1/81 {
	gen rai_severe_`num' = 0
	replace rai_severe_`num' = 1 if rai_severe==`num'
} 
tab rai_severe

*save "/Users/katiereitz/Desktop/NIS_2020_severe temp file.dta", replace
/*************************************************
log close
*************************************************


*************************************************
log using "/Users/katiereitz/Documents/UPMCResident/UPMCResearch/Frailty:Operative Stress Score/RAI-ICD10/Round 3/Log/ICD10-RAI-Validation-2020 Cancer MODERATE.log" , replace
*************************************************
*************************************************
**MODERATE - RAI VALIDATION in full cohort surgical in 2020
*************************************************/

//Moderate cancer variables 

generate remission_oral = 0 
foreach num of numlist 1/40 { 
foreach var of varlist i10_dx`num' {
replace remission_oral = 1 if (inlist(`var', "Z85818"))
}
}

generate cancer_oral_moderate = 0 
foreach num of numlist 1/40 { 
foreach var of varlist i10_dx`num' {
replace cancer_oral_moderate = 1 if (inlist(`var', "C030", "C031", "C039") | inlist(`var', "C040", "C041", "C048", "C049") | inlist(`var', "C050"))
}
}

gen active_oral_moderate = 1 if cancer_oral_moderate == 1 & remission_oral != 1
*replace cancer_rai = 0 if remission_oral == 1 & cancer_oral == 1 //oral
//

generate remission_stomach = 0 
foreach num of numlist 1/40 { 
foreach var of varlist i10_dx`num' {
replace remission_stomach = 1 if (inlist(`var', "Z85028"))
}
}

generate cancer_stomach = 0 
foreach num of numlist 1/40 { 
foreach var of varlist i10_dx`num' {
replace cancer_stomach = 1 if (inlist(`var', "C160", "C161", "C162", "C163", "C164") | inlist(`var', "C165", "C166", "C168", "C169"))
}
}

gen active_stomach =1 if cancer_stomach ==1 & remission_stomach!=1 
*replace cancer_rai = 0 if remission_stomach == 1 & cancer_stomach == 1 // stomach
//
generate remission_colon = 0 
foreach num of numlist 1/40 { 
foreach var of varlist i10_dx`num' {
replace remission_colon = 1 if (inlist(`var', "Z85038"))
}
}

generate cancer_colon = 0 
foreach num of numlist 1/40 { 
foreach var of varlist i10_dx`num' {
replace cancer_colon = 1 if (inlist(`var', "C180", "C181", "C182", "C183", "C184") | inlist(`var', "C185", "C186", "C188", "C189"))
}
}

gen active_colon = 1 if cancer_colon==1 & remission_colon!=1
*replace cancer_rai = 0 if remission_colon == 1 & cancer_colon == 1 // colon
//
generate remission_rectum_anus = 0 
foreach num of numlist 1/40 { 
foreach var of varlist i10_dx`num' {
replace remission_rectum_anus = 1 if (inlist(`var', "Z85048"))
}
}

generate cancer_rectosigmoid = 0 
foreach num of numlist 1/40 { 
foreach var of varlist i10_dx`num' {
replace cancer_rectosigmoid = 1 if (inlist(`var', "C19"))
}
}

gen active_rectosigmoid = 1 if cancer_rectosigmoid == 1 & remission_rectum_anus != 1
*replace cancer_rai = 0 if remission_rectum_anus == 1 & cancer_rectum_anus == 1 // rectum
//
generate remission_ent = 0 
foreach num of numlist 1/40 { 
foreach var of varlist i10_dx`num' {
replace remission_ent = 1 if (inlist(`var', "Z8522"))
}
}

generate cancer_ent = 0 
foreach num of numlist 1/40 { 
foreach var of varlist i10_dx`num' {
replace cancer_ent = 1 if (inlist(`var', "C300", "C301", "C310", "C311", "C312") | inlist(`var', "C313", "C318","C319"))
}
}

gen active_ent = 1 if cancer_ent==1 & remission_ent!=1
*replace cancer_rai = 0 if remission_ent == 1 & cancer_ent == 1 // ent
//

generate remission_larynx = 0 
foreach num of numlist 1/40 { 
foreach var of varlist i10_dx`num' {
replace remission_larynx = 1 if (inlist(`var', "Z8521"))
}
}

generate cancer_larynx = 0 
foreach num of numlist 1/40 { 
foreach var of varlist i10_dx`num' {
replace cancer_larynx = 1 if (inlist(`var', "C320", "C321", "C322", "C323", "C328") | inlist(`var', "C329"))
}
}

gen active_larynx = 1 if cancer_larynx==1 & remission_larynx!=1
*replace cancer_rai = 0 if remission_larynx == 1 & cancer_larynx == 1 // larynx
//

generate remission_merckel = 0 
foreach num of numlist 1/40 { 
foreach var of varlist i10_dx`num' {
replace remission_merckel = 1 if (inlist(`var', "Z85821"))
}
}

generate cancer_merckel = 0 
foreach num of numlist 1/40 { 
foreach var of varlist i10_dx`num' {
replace cancer_merckel = 1 if (inlist(`var', "C4A0", "C4A10", "C4A111", "C4A112", "C4A121") | inlist(`var', "C4A122", "C4A20", "C4A21", "C4A22", "C4A30") | inlist(`var', "C4A31", "C4A39", "C4A4", "C4A51", "C4A52") | inlist(`var', "C4A59", "C4A60", "C4A61", "C4A62", "C4A70") | inlist(`var', "C4A71", "C4A72", "C4A8", "C4A9"))
}
}

gen active_merckel =1 if cancer_merckel==1 & remission_merckel!=1
*replace cancer_rai = 0 if remission_merckel == 1 & cancer_merckel == 1 //merckel
//

generate remission_nervous_other = 0 
foreach num of numlist 1/40 { 
foreach var of varlist i10_dx`num' {
replace remission_nervous_other = 1 if (inlist(`var', "Z85848"))
}
}

generate cancer_nervous_other = 0 
foreach num of numlist 1/40 { 
foreach var of varlist i10_dx`num' {
replace cancer_nervous_other = 1 if (inlist(`var', "C720", "C721", "C7220", "C7221", "C7222") | inlist(`var', "C7230", "C7231", "C7232", "C7240", "C7241") | inlist(`var', "C7242", "C7250", "C7259", "C729") | inlist(`var', "C470", "C4710", "C4711", "C4712", "C4720") | inlist(`var', "C4721", "C4722", "C473", "C474", "C475") | inlist(`var', "C476", "C478", "C479") | inlist(`var', "C700", "C701", "C709"))
}
}

gen active_nervous_other = 1 if  cancer_nervous_other ==1 & remission_nervous_other!=1
*replace cancer_rai = 0 if remission_nervous_other == 1 & cancer_nervous_other == 1 //nervous_other
//


generate remission_soft_tissue = 0 
foreach num of numlist 1/40 { 
foreach var of varlist i10_dx`num' {
replace remission_soft_tissue = 1 if (inlist(`var', "Z85831"))
}
}

generate cancer_soft_tissue = 0 
foreach num of numlist 1/40 { 
foreach var of varlist i10_dx`num' {
replace cancer_soft_tissue = 1 if (inlist(`var', "C490", "C4910", "C4911", "C4912", "C4920") | inlist(`var', "C4921", "C4922", "C493", "C494", "C495") | inlist(`var', "C496", "C498", "C499", "C49A0", "C49A1") | inlist(`var', "C49A2", "C49A3", "C49A4", "C49A5", "C49A9"))
}
}

gen active_soft_tissue =1 if cancer_soft_tissue==1 & remission_soft_tissue!=1
*replace cancer_rai = 0 if remission_soft_tissue == 1 & cancer_soft_tissue == 1 //soft_tissue
//
generate remission_female_genital = 0 
foreach num of numlist 1/40 { 
foreach var of varlist i10_dx`num' {
replace remission_female_genital = 1 if (inlist(`var', "Z8544"))
}
}

generate cancer_vagina = 0 
foreach num of numlist 1/40 { 
foreach var of varlist i10_dx`num' {
replace cancer_vagina = 1 if (inlist(`var', "C52"))
}
}

gen active_vagina = 1 if cancer_vagina == 1 & remission_female_genital != 1
*replace cancer_rai = 0 if remission_female_genital == 1 & cancer_female_genital == 1 // female_genital (vagina)
//

generate remission_cervix = 0 
foreach num of numlist 1/40 { 
foreach var of varlist i10_dx`num' {
replace remission_cervix = 1 if (inlist(`var', "Z8541"))
}
}

generate cancer_cervix = 0 
foreach num of numlist 1/40 { 
foreach var of varlist i10_dx`num' {
replace cancer_cervix = 1 if (inlist(`var', "C530", "C531", "C538", "C539"))
}
}

gen active_cervix = 1 if cancer_cervix==1 & remission_cervix!=1
*replace cancer_rai = 0 if remission_cervix == 1 & cancer_cervix == 1 // cervix
//
generate remission_ovary = 0 
foreach num of numlist 1/40 { 
foreach var of varlist i10_dx`num' {
replace remission_ovary = 1 if (inlist(`var', "Z8543"))
}
}

generate cancer_ovary = 0 
foreach num of numlist 1/40 { 
foreach var of varlist i10_dx`num' {
replace cancer_ovary = 1 if (inlist(`var', "C561", "C562", "C563", "C569"))
}
}

gen active_ovary = 1 if cancer_ovary==1 & remission_ovary!=1
*replace cancer_rai = 0 if remission_ovary == 1 & cancer_ovary == 1 // ovary
//
generate remission_renal_pelvis = 0 
foreach num of numlist 1/40 { 
foreach var of varlist i10_dx`num' {
replace remission_renal_pelvis = 1 if (inlist(`var', "Z8553"))
}
}

generate cancer_renal_pelvis = 0 
foreach num of numlist 1/40 { 
foreach var of varlist i10_dx`num' {
replace cancer_renal_pelvis = 1 if (inlist(`var', "C651", "C652", "C659"))
}
}

gen active_renal_pelvix = 1 if cancer_renal_pelvis==1 & remission_renal_pelvis!=1
*replace cancer_rai = 0 if remission_renal_pelvis == 1 & cancer_renal_pelvis == 1 //renal_pelvis
//

generate remission_endocrine = 0 
foreach num of numlist 1/40 { 
foreach var of varlist i10_dx`num' {
replace remission_endocrine = 1 if (inlist(`var', "Z85858"))
}
}

generate cancer_endocrine = 0 
foreach num of numlist 1/40 { 
foreach var of varlist i10_dx`num' {
replace cancer_endocrine = 1 if (inlist(`var', "C7400", "C7401", "C7402", "C7410", "C7411") | inlist(`var', "C7412", "C7490", "C7491", "C7492"))
}
}

gen active_endocrine = 1 if cancer_endocrine==1 & remission_endocrine!=1
*replace cancer_rai = 0 if remission_endocrine == 1 & cancer_endocrine == 1 //endocrine 
//
// Carcinoid
generate remission_carcinoid_stomach = 0 
foreach num of numlist 1/40 { 
foreach var of varlist i10_dx`num' {
replace remission_carcinoid_stomach = 1 if (inlist(`var', "Z85020"))
}
}

generate cancer_carcinoid_stomach = 0 
foreach num of numlist 1/40 { 
foreach var of varlist i10_dx`num' {
replace cancer_carcinoid_stomach = 1 if (inlist(`var', "C7A092"))
}
}

gen active_carcinoid_stomach = 1 if cancer_carcinoid_stomach==1 & remission_carcinoid_stomach!=1
*replace cancer_rai = 0 if remission_carcinoid_stomach == 1 & cancer_carcinoid_stomach == 1 //carcinoid_stomach
//
generate remission_carcinoid_colon = 0 
foreach num of numlist 1/40 { 
foreach var of varlist i10_dx`num' {
replace remission_carcinoid_colon = 1 if (inlist(`var', "Z85030"))
}
}

generate cancer_carcinoid_colon = 0 
foreach num of numlist 1/40 { 
foreach var of varlist i10_dx`num' {
replace cancer_carcinoid_colon = 1 if (inlist(`var', "C7A020", "C7A021", "C7A022", "C7A023", "C7A024") | inlist(`var', "C7A025", "C7A029"))
}
}

gen active_carcinoid_colon = 1 if cancer_carcinoid_colon==1 & remission_carcinoid_colon!=1
*replace cancer_rai = 0 if remission_carcinoid_colon == 1 & cancer_carcinoid_colon == 1 //carcinoid_colon

//
generate remission_carcinoid_rectum = 0 
foreach num of numlist 1/40 { 
foreach var of varlist i10_dx`num' {
replace remission_carcinoid_rectum = 1 if (inlist(`var', "Z85040"))
}
}

generate cancer_carcinoid_rectum = 0 
foreach num of numlist 1/40 { 
foreach var of varlist i10_dx`num' {
replace cancer_carcinoid_rectum = 1 if (inlist(`var', "C7A026"))
}
}

gen active_carcinoid_rectum =1 if cancer_carcinoid_rectum==1 & remission_carcinoid_rectum!=1
*replace cancer_rai = 0 if remission_carcinoid_rectum == 1 & cancer_carcinoid_rectum == 1 //carcinoid_rectum
//
generate remission_carcinoid_small_int = 0 
foreach num of numlist 1/40 { 
foreach var of varlist i10_dx`num' {
replace remission_carcinoid_small_int = 1 if (inlist(`var', "Z85060"))
}
}

generate cancer_carcinoid_small_int = 0 
foreach num of numlist 1/40 { 
foreach var of varlist i10_dx`num' {
replace cancer_carcinoid_small_int = 1 if (inlist(`var', "C7A010", "C7A011", "C7A012", "C7A019"))
}
}

gen active_carcinoid_small_in =1 if cancer_carcinoid_small_int==1 & remission_carcinoid_small_int!=1
*replace cancer_rai = 0 if remission_carcinoid_small_int == 1 & cancer_carcinoid_small_int == 1 //small_int
//
generate remission_carcinoid_bronch_lung = 0 
foreach num of numlist 1/40 { 
foreach var of varlist i10_dx`num' {
replace remission_carcinoid_bronch_lung = 1 if (inlist(`var', "Z85110"))
}
}

generate cancer_carcinoid_bronch_lung = 0 
foreach num of numlist 1/40 { 
foreach var of varlist i10_dx`num' {
replace cancer_carcinoid_bronch_lung = 1 if (inlist(`var', "C7A090"))
}
}

gen active_carcinoid_bronch_lung=1 if cancer_carcinoid_bronch_lung==1 & remission_carcinoid_bronch_lung!=1
*replace cancer_rai = 0 if remission_carcinoid_bronch_lung == 1 & cancer_carcinoid_bronch_lung == 1 //bronch_lung
//
generate remission_carcinoid_thymus = 0 
foreach num of numlist 1/40 { 
foreach var of varlist i10_dx`num' {
replace remission_carcinoid_thymus = 1 if (inlist(`var', "Z85230"))
}
}

generate cancer_carcinoid_thymus = 0 
foreach num of numlist 1/40 { 
foreach var of varlist i10_dx`num' {
replace cancer_carcinoid_thymus = 1 if (inlist(`var', "C7A091"))
}
}

gen active_carcinoid_thymus=1 if cancer_carcinoid_thymus==1 & remission_carcinoid_thymus!=1
*replace cancer_rai = 0 if remission_carcinoid_thymus == 1 & cancer_carcinoid_thymus == 1 //thymus
//
generate remission_carcinoid_kidney = 0 
foreach num of numlist 1/40 { 
foreach var of varlist i10_dx`num' {
replace remission_carcinoid_kidney = 1 if (inlist(`var', "Z85520"))
}
}

generate cancer_carcinoid_kidney = 0 
foreach num of numlist 1/40 { 
foreach var of varlist i10_dx`num' {
replace cancer_carcinoid_kidney = 1 if (inlist(`var', "C7A093"))
}
}

gen active_carcinoid_kidney =1 if cancer_carcinoid_kidney==1 & remission_carcinoid_kidney!=1
*replace cancer_rai = 0 if remission_carcinoid_kidney == 1 & cancer_carcinoid_kidney == 1 

generate remission_non_hodgkin = 0 
foreach num of numlist 1/40 { 
foreach var of varlist i10_dx`num' {
replace remission_non_hodgkin = 1 if (inlist(`var', "Z8572"))
}
}

generate cancer_non_hodgkin_moderate = 0 
foreach num of numlist 1/40 { 
foreach var of varlist i10_dx`num' {
replace cancer_non_hodgkin_moderate = 1 if (inlist(`var',"C8400", "C8401", "C8402", "C8403", "C8404") | inlist(`var',"C8405", "C8406", "C8407", "C8408", "C8409") | inlist(`var',"C8410", "C8411", "C8412", "C8413", "C8414") | inlist(`var',"C8415", "C8416", "C8417", "C8418", "C8419") | inlist(`var',"C8440", "C8441", "C8442", "C8443", "C8444") | inlist(`var',"C8445", "C8446", "C8447", "C8448", "C8449") | inlist(`var',"C8460", "C8461", "C8462", "C8463", "C8464") | inlist(`var',"C8465", "C8466", "C8467", "C8468", "C8469") | inlist(`var',"C8470", "C8471", "C8472", "C8473", "C8474") | inlist(`var',"C8475", "C8476", "C8477", "C8478", "C8479") | inlist(`var',"C847A") | inlist(`var',"C84A0", "C84A1", "C84A2", "C84A3", "C84A4") | inlist(`var',"C84A5", "C84A6", "C84A7", "C84A8", "C84A9") | inlist(`var',"C84Z0", "C84Z1", "C84Z2", "C84Z3", "C84Z4") | inlist(`var',"C84Z5", "C84Z6", "C84Z7", "C84Z8", "C84Z9") | inlist(`var',"C8490", "C8491", "C8492", "C8493", "C8494") | inlist(`var', "C8495", "C8496", "C8497", "C8498", "C8499"))
}
}

gen active_non_hodgkins_moderate = 1 if cancer_non_hodgkin_moderate == 1 & remission_non_hodgkin != 1 
*replace cancer_rai = 0 if remission_non_hodgkin == 1 & cancer_non_hodgkin == 1 //non_hodgkin
//

generate remission_lymphoid = 0 
foreach num of numlist 1/40 { 
foreach var of varlist i10_dx`num' {
replace remission_lymphoid = 1 if (inlist(`var', "Z8579"))
}
}

generate cancer_lymphoid = 0 
foreach num of numlist 1/40 { 
foreach var of varlist i10_dx`num' {
replace cancer_lymphoid = 1 if (inlist(`var', "C9000", "C9002", "C9010", "C9012", "C9020") | inlist(`var', "C9022", "C9030", "C9032"))
}
}

gen active_lymphoid = 1 if cancer_lymphoid==1 & remission_lymphoid!=1
*replace cancer_rai = 0 if remission_lymphoid == 1 & cancer_lymphoid == 1 //lymphoid

**This will add in any C codes w/o z codes
gen cancer_rai_mod = cancer_rai_severe
foreach var of varlist active_* {
	replace cancer_rai_mod = 1 if `var'==1
}

**THIS MUST BE ONLY THE ONES THAT ARE C-CODE WIHTOUT Z-CODES
foreach num of numlist 1/40 { 
foreach var of varlist i10_dx`num' {
replace cancer_rai_mod = 1 if (inlist(`var', "C380", "C381", "C382", "C383", "C384") | inlist(`var', "C388") | inlist(`var', "C600", "C601", "C602", "C608", "C609") | inlist(`var', "C7A00", "C7A094", "C7A095", "C7A096", "C7A098") |  inlist(`var', "C7A1", "C7A8"))
}
} 

*Category 1 AGE & cancer (severe & moderate)
gen age_cat_rai_mod=.
replace age_cat_rai_mod=0 if age<=19
replace age_cat_rai_mod=41 if age<=19 & cancer_rai_mod == 1

replace age_cat_rai_mod=2 if age>=20 & age<25
replace age_cat_rai_mod=42 if age>=20 & age<25 & cancer_rai_mod == 1

replace age_cat_rai_mod=4 if age>=25 & age<30
replace age_cat_rai_mod=42 if age>=25 & age<30 & cancer_rai_mod == 1

replace age_cat_rai_mod=6 if age>=30 & age<35
replace age_cat_rai_mod=42 if age>=30 & age<35 & cancer_rai_mod == 1

replace age_cat_rai_mod=9 if age>=35 & age<40
replace age_cat_rai_mod=42 if age>=35 & age<40 & cancer_rai_mod == 1

replace age_cat_rai_mod=11 if age>=40 & age<45
replace age_cat_rai_mod=42 if age>=40 & age<45 & cancer_rai_mod == 1

replace age_cat_rai_mod=13 if age>=45 & age<50
replace age_cat_rai_mod=43 if age>=45 & age<50 & cancer_rai_mod == 1

replace age_cat_rai_mod=16 if age>=50 & age<55
replace age_cat_rai_mod=43 if age>=50 & age<55 & cancer_rai_mod == 1

replace age_cat_rai_mod=18 if age>=55 & age<60
replace age_cat_rai_mod=43 if age>=55 & age<60 & cancer_rai_mod == 1

replace age_cat_rai_mod=20 if age>=60 & age<65
replace age_cat_rai_mod=43 if age>=60 & age<65 & cancer_rai_mod == 1

replace age_cat_rai_mod=23 if age>=65 & age<70
replace age_cat_rai_mod=44 if age>=65 & age<70 & cancer_rai_mod == 1

replace age_cat_rai_mod=25 if age>=70 & age<75
replace age_cat_rai_mod=44 if age>=70 & age<75 & cancer_rai_mod == 1

replace age_cat_rai_mod=27 if age>=75 & age<80
replace age_cat_rai_mod=44 if age>=75 & age<80 & cancer_rai_mod == 1

replace age_cat_rai_mod=30 if age>=80 & age<85
replace age_cat_rai_mod=44 if age>=80 & age<85 & cancer_rai_mod == 1

replace age_cat_rai_mod=32 if age>=85 & age<90
replace age_cat_rai_mod=44 if age>=85 & age<90 & cancer_rai_mod == 1

replace age_cat_rai_mod=34 if age>=90 & age<95
replace age_cat_rai_mod=45 if age>=90 & age<95 & cancer_rai_mod == 1

replace age_cat_rai_mod=37 if age>=95 & age<100
replace age_cat_rai_mod=45 if age>=95 & age<100 & cancer_rai_mod == 1

replace age_cat_rai_mod=39 if age>=100
replace age_cat_rai_mod=45 if age>=100 & cancer_rai_mod == 1


*Category 2 SEX
replace sex_score = 3 if sex_score!=0 & sex_score!=. 

*Category 3 weight loss
replace weight_loss_rai = 2 if weight_loss_rai!=0 & weight_loss_rai!=.

*Category 4 poor appetite
replace poor_appetite_rai = 1 if poor_appetite_rai!= 0 & poor_appetite_rai!=.

*Category 5 renal failure // rounded this down to 2
replace renal_failure_rai = 2 if renal_failure_rai!=0 & renal_failure_rai!=.

*Category 6 chf // roudned this up to 4
replace chf_rai = 4 if chf_rai!=0 & chf_rai!=.

*Category 7 shortness of breath
replace shortness_breath_rai = 2 if shortness_breath_rai!=0 & shortness_breath_rai!=.

*Category 8 living status N/A

*Category 9 ADL

//Partially dependent 
	//without cogn decline
	drop adl_rai
	generate adl_rai = 0
	replace adl_rai = 0 if cogn_decline_rai == 0
	replace adl_rai = 10 if cogn_decline_rai == 0 & partially_dependent_rai == 1
	replace adl_rai = 21 if cogn_decline_rai == 0 & totally_dependent_rai == 1


	//with cogn decline

	replace adl_rai = 10 if cogn_decline_rai == 1
	replace adl_rai = 16 if cogn_decline_rai == 1 & partially_dependent_rai == 1
	replace adl_rai = 22 if cogn_decline_rai == 1 & totally_dependent_rai == 1 


************************************************
*RAI-MODERATE
egen rai_mod=rowtotal(age_cat_rai_mod sex_score weight_loss_rai poor_appetite_rai renal_failure_rai chf_rai shortness_breath_rai adl_rai)
sum rai_mod
*hist rai_mod

foreach num of numlist 1/81 {
	gen rai_mod_`num' = 0
	replace rai_mod_`num' = 1 if rai_mod==`num'
} 

/*save "/Users/katiereitz/Desktop/NIS_2020_mod temp file.dta", replace
************************************************
log close
*************************************************


*************************************************
log using "/Users/katiereitz/Documents/UPMCResident/UPMCResearch/Frailty:Operative Stress Score/RAI-ICD10/Round 3/Log/ICD10-RAI-Validation-2020 Cancer Mild aka ALL.log" , replace
*************************************************
**MILD - RAI VALIDATION 
*************************************************
*************************************************/


generate cancer_oral_mild = 0 
foreach num of numlist 1/40 { 
foreach var of varlist i10_dx`num' {
replace cancer_oral_mild = 1 if (inlist(`var', "C000", "C001", "C002", "C003", "C004") | inlist(`var', "C005", "C006", "C008", "C009") | inlist(`var', "C051", "C052", "C058", "C059") | inlist(`var', "C07") | inlist(`var', "C080", "C081", "C089") | inlist(`var', "C090", "C091", "C098", "C099") | inlist(`var', "C100", "C101", "C102", "C103", "C104") | inlist(`var', "C108", "C109") | inlist(`var', "C110", "C111", "C112", "C113", "C118") | inlist(`var', "C119") | inlist(`var', "C12") | inlist(`var', "C130", "C131", "C132", "C138", "C139") | inlist(`var', "C140", "C142", "C148"))
}
}

gen active_oral_mild = 1 if cancer_oral_mild == 1 & remission_oral != 1
*replace cancer_rai = 0 if remission_oral == 1 & cancer_oral == 1 //oral
//

generate remission_tongue = 0 
foreach num of numlist 1/40 { 
foreach var of varlist i10_dx`num' {
replace remission_tongue = 1 if (inlist(`var', "Z85810"))
}
} 

generate cancer_tongue = 0 
foreach num of numlist 1/40 { 
foreach var of varlist i10_dx`num' {
replace cancer_tongue = 1 if (inlist(`var', "C01", "C020", "C021", "C022", "C023") | inlist(`var', "C024", "C028", "C029"))
}
}

gen active_tongue = 1 if cancer_tongue==1 & remission_tongue!=1
*replace cancer_rai = 0 if remission_tongue == 1 & cancer_tongue == 1 //tongue
//

generate remission_small_int = 0 
foreach num of numlist 1/40 { 
foreach var of varlist i10_dx`num' {
replace remission_small_int = 1 if (inlist(`var', "Z85068"))
}
}

generate cancer_small_int = 0 
foreach num of numlist 1/40 { 
foreach var of varlist i10_dx`num' {
replace cancer_small_int = 1 if (inlist(`var', "C170", "C171", "C172", "C173", "C178") | inlist(`var', "C179"))
}
}

gen active_small_int = 1 if cancer_small_int==1 & remission_small_int!=1
*replace cancer_rai = 0 if remission_small_int == 1 & cancer_small_int == 1 // small intestine 
//

generate cancer_rectum_anus = 0 
foreach num of numlist 1/40 { 
foreach var of varlist i10_dx`num' {
replace cancer_rectum_anus = 1 if (inlist(`var', "C20", "C210", "C211", "C212", "C218"))
}
}

gen active_rectum_anus = 1 if cancer_rectum_anus==1 & remission_rectum_anus!=1
*replace cancer_rai = 0 if remission_rectum_anus == 1 & cancer_rectum_anus == 1 // rectum
//

generate remission_thymus = 0 
foreach num of numlist 1/40 { 
foreach var of varlist i10_dx`num' {
replace remission_thymus = 1 if (inlist(`var', "Z85238"))
}
}

generate cancer_thymus = 0 
foreach num of numlist 1/40 { 
foreach var of varlist i10_dx`num' {
replace cancer_thymus = 1 if (inlist(`var', "C37"))
}
}

gen active_thymus = 1 if cancer_thymus==1 & remission_thymus!=1
*replace cancer_rai = 0 if remission_thymus == 1 & cancer_thymus == 1 // thymus
//

generate remission_bone = 0 
foreach num of numlist 1/40 { 
foreach var of varlist i10_dx`num' {
replace remission_bone = 1 if (inlist(`var', "Z85830"))
}
}

generate cancer_bone = 0 
foreach num of numlist 1/40 { 
foreach var of varlist i10_dx`num' {
replace cancer_bone = 1 if (inlist(`var', "C4000", "C4001", "C4002", "C4010", "C4011") | inlist(`var', "C4012", "C4020", "C4021", "C4022", "C4030") | inlist(`var', "C4031", "C4032", "C4080", "C4081", "C4082") | inlist(`var', "C4090", "C4091", "C4092") | inlist(`var', "C410", "C411", "C412", "C413", "C414") | inlist(`var', "C419"))
}
}

gen active_bone = 1 if cancer_bone==1 & remission_bone!=1
*replace cancer_rai = 0 if remission_bone == 1 & cancer_bone == 1 //bone
//

generate remission_melanoma = 0 
foreach num of numlist 1/40 { 
foreach var of varlist i10_dx`num' {
replace remission_melanoma = 1 if (inlist(`var', "Z85820"))
}
}

generate cancer_melanoma = 0 
foreach num of numlist 1/40 { 
foreach var of varlist i10_dx`num' {
replace cancer_melanoma = 1 if (inlist(`var', "C430", "C4310", "C43111", "C43112", "C43121") | inlist(`var', "C43122", "C4320", "C4321", "C4322", "C4330") | inlist(`var', "C4331", "C4339", "C434", "C4351", "C4352") | inlist(`var', "C4359", "C4360", "C4361", "C4362", "C4370") | inlist(`var', "C4370", "C4371", "C4372", "C438", "C439"))
}
}

gen active_melanoma = 1 if cancer_melanoma==1 & remission_melanoma!=1
*replace cancer_rai = 0 if remission_melanoma == 1 & cancer_melanoma == 1 //melanoma
//

generate remission_breast = 0 
foreach num of numlist 1/40 { 
foreach var of varlist i10_dx`num' {
replace remission_breast = 1 if (inlist(`var', "Z853"))
}
}

generate cancer_breast = 0 
foreach num of numlist 1/40 { 
foreach var of varlist i10_dx`num' {
replace cancer_breast = 1 if (inlist(`var', "C50011", "C50012", "C50019", "C50021", "C50022") | inlist(`var', "C50029", "C50111", "C50112", "C50119", "C50121") | inlist(`var', "C50122", "C50129", "C50221", "C50222", "C50229") | inlist(`var', "C50311", "C50312", "C50319", "C50321", "C50322") | inlist(`var', "C50329", "C50411", "C50412", "C50419", "C50421") | inlist(`var', "C50422", "C50429", "C50511", "C50512", "C50519") | inlist(`var', "C50521", "C50522", "C50529", "C50611", "C50612") | inlist(`var', "C50619", "C50621", "C50622", "C50629", "C50811") | inlist(`var', "C50812", "C50819", "C50821", "C50822", "C50829") | inlist(`var', "C50911", "C50912", "C50919", "C50921", "C50922") | inlist(`var', "C50929"))
}
}

gen active_breast = 1 if cancer_breast==1 & remission_breast!=1
*replace cancer_rai = 0 if remission_breast == 1 & cancer_breast == 1 // breast
//

generate cancer_vulva = 0 
foreach num of numlist 1/40 { 
foreach var of varlist i10_dx`num' {
replace cancer_vulva = 1 if (inlist(`var', "C510", "C511", "C512", "C518", "C519"))
}
}

gen active_vulva = 1 if cancer_vulva == 1 & remission_female_genital !=1
*replace cancer_rai = 0 if remission_female_genital == 1 & cancer_female_genital == 1 // female_genital (vulva)
//
generate remission_uterus = 0 
foreach num of numlist 1/40 { 
foreach var of varlist i10_dx`num' {
replace remission_uterus = 1 if (inlist(`var', "Z8542"))
}
}

generate cancer_uterus = 0 
foreach num of numlist 1/40 { 
foreach var of varlist i10_dx`num' {
replace cancer_uterus = 1 if (inlist(`var', "C540", "C541", "C542", "C543", "C548") | inlist(`var', "C549", "C55"))
}
}

gen active_uterus = 1 if cancer_uterus == 1 & remission_uterus !=1
*replace cancer_rai = 0 if remission_uterus == 1 & cancer_uterus == 1 // uterus
//

generate remission_prostate = 0 
foreach num of numlist 1/40 { 
foreach var of varlist i10_dx`num' {
replace remission_prostate = 1 if (inlist(`var', "Z8546"))
}
}

generate cancer_prostate = 0 
foreach num of numlist 1/40 { 
foreach var of varlist i10_dx`num' {
replace cancer_prostate = 1 if (inlist(`var', "C61"))
}
}

gen active_prostate = 1 if cancer_prostate==1 & remission_prostate!=1
*replace cancer_rai = 0 if remission_prostate == 1 & cancer_prostate == 1 // prostate
//

generate remission_testis = 0 
foreach num of numlist 1/40 { 
foreach var of varlist i10_dx`num' {
replace remission_testis = 1 if (inlist(`var', "Z8547"))
}
}

generate cancer_testis = 0 
foreach num of numlist 1/40 { 
foreach var of varlist i10_dx`num' {
replace cancer_testis = 1 if (inlist(`var', "C6200", "C6201", "C6202", "C6210", "C6211") | inlist(`var', "C6212", "C6290", "C6291", "C6292"))
}
}

gen active_testis = 1 if cancer_testis==1 & remission_testis!=1
*replace cancer_rai = 0 if remission_testis == 1 & cancer_testis == 1 // testis
//

generate remission_kidney = 0 
foreach num of numlist 1/40 { 
foreach var of varlist i10_dx`num' {
replace remission_kidney = 1 if (inlist(`var', "Z85528"))
}
}

generate cancer_kidney = 0 
foreach num of numlist 1/40 { 
foreach var of varlist i10_dx`num' {
replace cancer_kidney = 1 if (inlist(`var', "C641", "C642", "C649"))
}
}

gen active_kidney = 1 if cancer_kidney==1 & remission_kidney!=1
*replace cancer_rai = 0 if remission_kidney == 1 & cancer_kidney == 1 // kidney
// 

generate remission_ureter = 0 
foreach num of numlist 1/40 { 
foreach var of varlist i10_dx`num' {
replace remission_ureter = 1 if (inlist(`var', "Z8554"))
}
}

generate cancer_ureter = 0 
foreach num of numlist 1/40 { 
foreach var of varlist i10_dx`num' {
replace cancer_ureter = 1 if (inlist(`var', "C661", "C662", "C669"))
}
}

gen active_ureter = 1 if  cancer_ureter==1 & remission_ureter!=1
*replace cancer_rai = 0 if remission_ureter == 1 & cancer_ureter == 1 //ureter
//

generate remission_bladder = 0 
foreach num of numlist 1/40 { 
foreach var of varlist i10_dx`num' {
replace remission_bladder = 1 if (inlist(`var', "Z8551"))
}
}

generate cancer_bladder = 0 
foreach num of numlist 1/40 { 
foreach var of varlist i10_dx`num' {
replace cancer_bladder = 1 if (inlist(`var', "C670", "C671", "C672", "C673", "C674") | inlist(`var', "C675", "C676", "C677", "C678", "C679"))
}
}

gen active_bladder =1 if cancer_bladder==1 & remission_bladder!=1
*replace cancer_rai = 0 if remission_bladder == 1 & cancer_bladder == 1 // bladder
//

generate remission_eye = 0 
foreach num of numlist 1/40 { 
foreach var of varlist i10_dx`num' {
replace remission_eye = 1 if (inlist(`var', "Z85840"))
}
}

generate cancer_eye = 0 
foreach num of numlist 1/40 { 
foreach var of varlist i10_dx`num' {
replace cancer_eye = 1 if (inlist(`var', "C6900", "C6901", "C6902", "C6910", "C6911") | inlist(`var', "C6912", "C6920", "C6921", "C6922", "C6930") | inlist(`var', "C6931", "C6932", "C6940", "C6941", "C6942") | inlist(`var', "C6950", "C6951", "C6952", "C6960", "C6961") | inlist(`var', "C6962", "C6980", "C6981", "C6982", "C6990") | inlist(`var', "C6991", "C6992"))
}
}

gen active_eye = 1 if cancer_eye==1 & remission_eye!=1
*replace cancer_rai = 0 if remission_eye == 1 & cancer_eye == 1 //eye
//

generate remission_thyroid = 0 
foreach num of numlist 1/40 { 
foreach var of varlist i10_dx`num' {
replace remission_thyroid = 1 if (inlist(`var', "Z85850"))
}
}

generate cancer_thyroid = 0 
foreach num of numlist 1/40 { 
foreach var of varlist i10_dx`num' {
replace cancer_thyroid = 1 if (inlist(`var', "C73"))
}
}

gen active_thyroid = 1 if cancer_thyroid == 1 & remission_thyroid != 1
*replace cancer_rai = 0 if remission_thyroid == 1 & cancer_thyroid == 1 //thyroid
//

generate remission_hodgkin = 0 
foreach num of numlist 1/40 { 
foreach var of varlist i10_dx`num' {
replace remission_hodgkin = 1 if (inlist(`var', "Z8571"))
}
}

generate cancer_hodgkin = 0 
foreach num of numlist 1/40 { 
foreach var of varlist i10_dx`num' {
replace cancer_hodgkin = 1 if (inlist(`var', "C8100", "C8101", "C8102", "C8103", "C8104") | inlist(`var', "C8105", "C8106", "C8107", "C8108", "C8109") | inlist(`var', "C8110", "C8111", "C8112", "C8113", "C8114") | inlist(`var', "C8115", "C8116", "C8117", "C8118", "C8119") | inlist(`var', "C8120", "C8121", "C8122", "C8123", "C8124") | inlist(`var', "C8125", "C8126", "C8127", "C8128", "C8129") | inlist(`var', "C8130", "C8131", "C8132", "C8133", "C8134") | inlist(`var', "C8135", "C8136", "C8137", "C8138", "C8139") | inlist(`var', "C8140", "C8141", "C8142", "C8143", "C8144") | inlist(`var', "C8145", "C8146", "C8147", "C8148", "C8149") | inlist(`var', "C8170", "C8171", "C8172", "C8173", "C8174") | inlist(`var', "C8175", "C8176", "C8177", "C8178", "C8179") | inlist(`var', "C8190", "C8191", "C8192", "C8193", "C8194") | inlist(`var', "C8195", "C8196", "C8197", "C8198", "C8199"))
}
}

gen active_hodgkins = 1 if cancer_hodgkin==1 & remission_hodgkin!=1
*replace cancer_rai = 0 if remission_hodgkin == 1 & cancer_hodgkin == 1 //hodgkin
//

generate cancer_non_hodgkin_mild = 0 
foreach num of numlist 1/40 { 
foreach var of varlist i10_dx`num' {
replace cancer_non_hodgkin_mild = 1 if (inlist(`var', "C8200", "C8201", "C8202", "C8203", "C8204") | inlist(`var', "C8205", "C8206", "C8207", "C8208", "C8209") | inlist(`var', "C8210", "C8211", "C8212", "C8213", "C8214") | inlist(`var', "C8215", "C8216", "C8217", "C8218", "C8219") | inlist(`var', "C8220", "C8221", "C8222", "C8223", "C8224") | inlist(`var', "C8225", "C8226", "C8227", "C8228", "C8229") | inlist(`var', "C8230", "C8231", "C8232", "C8233", "C8234") | inlist(`var', "C8235", "C8236", "C8237", "C8238", "C8239") | inlist(`var', "C8240", "C8241", "C8242", "C8243", "C8244") | inlist(`var', "C8245", "C8246", "C8247", "C8248", "C8249") | inlist(`var', "C8250", "C8251", "C8252", "C8253", "C8254") | inlist(`var', "C8255", "C8256", "C8257", "C8258", "C8259") | inlist(`var', "C8260", "C8261", "C8262", "C8263", "C8264") | inlist(`var', "C8265", "C8266", "C8267", "C8268", "C8269") | inlist(`var', "C8280", "C8281", "C8282", "C8283", "C8284") | inlist(`var', "C8285", "C8286", "C8287", "C8288", "C8289") | inlist(`var', "C8290", "C8291", "C8292", "C8293", "C8294") | inlist(`var', "C8295", "C8296", "C8297", "C8298", "C8299") | inlist(`var', "C8300", "C8301", "C8302", "C8303", "C8304") | inlist(`var', "C8305", "C8306", "C8307", "C8308", "C8309") | inlist(`var', "C8310", "C8311", "C8312", "C8313", "C8314") | inlist(`var', "C8315", "C8316", "C8317", "C8318", "C8319") | inlist(`var', "C8330", "C8331", "C8332", "C8333", "C8334") | inlist(`var', "C8335", "C8336", "C8337", "C8338", "C8339") | inlist(`var', "C8350", "C8351", "C8352", "C8353", "C8354") | inlist(`var', "C8355", "C8356", "C8357", "C8358", "C8359") | inlist(`var', "C8370", "C8371", "C8372", "C8373", "C8374") | inlist(`var', "C8375", "C8376", "C8377", "C8378", "C8379") | inlist(`var', "C8380", "C8381", "C8382", "C8383", "C8384") | inlist(`var', "C8385", "C8386", "C8387", "C8388", "C8389") | inlist(`var', "C8390", "C8391", "C8392", "C8393", "C8394") | inlist(`var', "C8395", "C8396", "C8397", "C8398", "C8399") | inlist(`var', "C8510", "C8511", "C8512", "C8513", "C8514") | inlist(`var', "C8515", "C8516", "C8517", "C8518", "C8519") | inlist(`var', "C8520", "C8521", "C8522", "C8523", "C8524") | inlist(`var', "C8525", "C8526", "C8527", "C8528", "C8529") | inlist(`var', "C8350", "C8351", "C8352", "C8353", "C8354") | inlist(`var', "C8355", "C8356", "C8357", "C8358", "C8359") | inlist(`var', "C8580", "C8581", "C8582", "C8583", "C8584") | inlist(`var', "C8585", "C8586", "C8587", "C8588", "C8589") | inlist(`var', "C8590", "C8591", "C8592", "C8593", "C8594") | inlist(`var', "C8595", "C8596", "C8597", "C8598", "C8599"))
}
}

gen active_non_hodgkins_mild = 1 if cancer_non_hodgkin_mild == 1 & remission_non_hodgkin != 1 
*replace cancer_rai = 0 if remission_non_hodgkin == 1 & cancer_non_hodgkin == 1 //non_hodgkin
//

generate cancer_leukemia_mild = 0 
foreach num of numlist 1/40 { 
foreach var of varlist i10_dx`num' {
replace cancer_leukemia_mild = 1 if (inlist(`var', "C9100", "C9102", "C9110", "C9112", "C9130") | inlist(`var', "C9132", "C9140", "C9142", "C9150", "C9152") | inlist(`var', "C9160", "C9162", "C91A0", "C91A2", "C91Z0") | inlist(`var', "C91Z2", "C9190", "C9192", "C9200", "C922") | inlist(`var', "C9210", "C9212", "C9220", "C9222", "C9230") | inlist(`var', "C9232", "C9240", "C9242", "C9250", "C9252") | inlist(`var', "C9260", "C9262", "C92A0", "C92A2", "C92Z0") | inlist(`var', "C92Z2", "C9290", "C9292", "C9290", "C9292") | inlist(`var', "C9260", "C9262", "C92A0", "C92A2", "C92Z0") | inlist(`var', "C92Z2", "C9290", "C9292"))
}
}

gen active_leukemia_mild = 1 if cancer_leukemia_mild == 1 & remission_leukemia != 1
*replace cancer_rai = 0 if remission_leukemia == 1 & cancer_leukemia == 1 //leukemia
//

**This will add in any C codes w/o z codes
gen cancer_rai_mild= cancer_rai_mod
foreach var of varlist active_* {
	replace cancer_rai_mild = 1 if `var'==1
}


*Category 1 AGE & cancer (severe)
gen age_cat_rai_mild=.
replace age_cat_rai_mild=0 if age<=19
replace age_cat_rai_mild=38 if age<=19 & cancer_rai_mild == 1

replace age_cat_rai_mild=2 if age>=20 & age<25
replace age_cat_rai_mild=39 if age>=20 & age<25 & cancer_rai_mild == 1

replace age_cat_rai_mild=4 if age>=25 & age<30
replace age_cat_rai_mild=39 if age>=25 & age<30 & cancer_rai_mild == 1

replace age_cat_rai_mild=7 if age>=30 & age<35
replace age_cat_rai_mild=39 if age>=30 & age<35 & cancer_rai_mild == 1

replace age_cat_rai_mild=9 if age>=35 & age<40
replace age_cat_rai_mild=40 if age>=35 & age<40 & cancer_rai_mild == 1

replace age_cat_rai_mild=12 if age>=40 & age<45
replace age_cat_rai_mild=40 if age>=40 & age<45 & cancer_rai_mild == 1

replace age_cat_rai_mild=14 if age>=45 & age<50
replace age_cat_rai_mild=40 if age>=45 & age<50 & cancer_rai_mild == 1

replace age_cat_rai_mild=16 if age>=50 & age<55
replace age_cat_rai_mild=41 if age>=50 & age<55 & cancer_rai_mild == 1

replace age_cat_rai_mild=19 if age>=55 & age<60
replace age_cat_rai_mild=41 if age>=55 & age<60 & cancer_rai_mild == 1

replace age_cat_rai_mild=21 if age>=60 & age<65
replace age_cat_rai_mild=41 if age>=60 & age<65 & cancer_rai_mild == 1

replace age_cat_rai_mild=24 if age>=65 & age<70
replace age_cat_rai_mild=42 if age>=65 & age<70 & cancer_rai_mild == 1

replace age_cat_rai_mild=26 if age>=70 & age<75
replace age_cat_rai_mild=42 if age>=70 & age<75 & cancer_rai_mild == 1

replace age_cat_rai_mild=29 if age>=75 & age<80
replace age_cat_rai_mild=42 if age>=75 & age<80 & cancer_rai_mild == 1

replace age_cat_rai_mild=31 if age>=80 & age<85
replace age_cat_rai_mild=43 if age>=80 & age<85 & cancer_rai_mild == 1

replace age_cat_rai_mild=33 if age>=85 & age<90
replace age_cat_rai_mild=43 if age>=85 & age<90 & cancer_rai_mild == 1

replace age_cat_rai_mild=36 if age>=90 & age<95
replace age_cat_rai_mild=43 if age>=90 & age<95 & cancer_rai_mild == 1

replace age_cat_rai_mild=38 if age>=95 & age<100
replace age_cat_rai_mild=44 if age>=95 & age<100 & cancer_rai_mild == 1

replace age_cat_rai_mild=41 if age>=100
replace age_cat_rai_mild=44 if age>=100 & cancer_rai_mild == 1

*Category 2 SEX
replace sex_score = 3 if sex_score!=0 & sex_score!=. 

*Category 3 weight loss
replace weight_loss_rai = 2 if weight_loss_rai!=0 & weight_loss_rai!=.

*Category 4 poor appetite
replace poor_appetite_rai = 1 if poor_appetite_rai!= 0 & poor_appetite_rai!=.

*Category 5 renal failure
replace renal_failure_rai = 3 if renal_failure_rai!=0 & renal_failure_rai!=.

*Category 6 chf
replace chf_rai = 4 if chf_rai!=0 & chf_rai!=.

*Category 7 shortness of breath
replace shortness_breath_rai = 2 if shortness_breath_rai!=0 & shortness_breath_rai!=.

*Category 8 living status N/A

*Category 9 ADL

//Partially dependent 
	drop adl_rai
	generate adl_rai = 0
	//without cogn decline
	replace adl_rai = 0 if cogn_decline_rai == 0
	replace adl_rai = 11 if cogn_decline_rai == 0 & partially_dependent_rai == 1
	replace adl_rai = 22 if cogn_decline_rai == 0 & totally_dependent_rai == 1


	//with cogn decline
	replace adl_rai = 10 if cogn_decline_rai == 1
	replace adl_rai = 16 if cogn_decline_rai == 1 & partially_dependent_rai == 1
	replace adl_rai = 22 if cogn_decline_rai == 1 & totally_dependent_rai == 1 
	
************************************************
*RAI-Mild
egen rai_mild=rowtotal(age_cat_rai_mild sex_score weight_loss_rai poor_appetite_rai renal_failure_rai chf_rai shortness_breath_rai adl_rai)
sum rai_mild
*hist rai_mild

foreach num of numlist 1/81 {
	gen rai_mild_`num' = 0
	replace rai_mild_`num' = 1 if rai_mild==`num'
} 

save  "/Users/katiereitz/OneDrive - UPMC/UPMC Research/NIS/NIS RAI/Round 5/ICD10_RAI_2020_RAI_Data.dta", replace 

************************************************
log close
*************************************************
/*	
	keep hosp_nis rai_mild rai_mod rai_severe 
	
export  delimited use "/Users/katiereitz/OneDrive - UPMC/UPMC Research/NIS/NIS RAI/Round 4/Export to Bower/ICD10_RAI_2020_RAI_Data - Crosswalk 3-13-2023.cvs", replace */
	
