* This do file cleans multiple response variables
* it turns TRUE/FALSE into labelled data

foreach i of varlist Q6g1_* {
	replace `i' = "" if `i' == "FALSE"
}
replace Q6g1_1 = "1" if Q6g1_1 == "TRUE"
replace Q6g1_2 = "2" if Q6g1_2 == "TRUE"
replace Q6g1_3 = "3" if Q6g1_3 == "TRUE"
replace Q6g1_4 = "4" if Q6g1_4 == "TRUE"
replace Q6g1_5 = "5" if Q6g1_5 == "TRUE"
replace Q6g1_6 = "6" if Q6g1_6 == "TRUE"
replace Q6g1_7 = "7" if Q6g1_7 == "TRUE"
replace Q6g1_8 = "8" if Q6g1_8 == "TRUE"
replace Q6g1_9 = "9" if Q6g1_9 == "TRUE"
replace Q6g1_10 = "10" if Q6g1_10 == "TRUE"
replace Q6g1_11 = "11" if Q6g1_11 == "TRUE"
replace Q6g1_12 = "12" if Q6g1_12 == "TRUE"
replace Q6g1_13 = "13" if Q6g1_13 == "TRUE"
replace Q6g1_14 = "14" if Q6g1_14 == "TRUE"
replace Q6g1_15 = "15" if Q6g1_15 == "TRUE"
replace Q6g1_16 = "16" if Q6g1_16 == "TRUE"
replace Q6g1_17 = "17" if Q6g1_17 == "TRUE"
replace Q6g1_96 = "96" if Q6g1_96 == "TRUE"
