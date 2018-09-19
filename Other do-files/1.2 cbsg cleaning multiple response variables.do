* This do file cleans multiple response variables
* it turns TRUE/FALSE into labelled data

foreach i of varlist Q6g1_* Q3b* {
	replace `i' = "" if inlist(`i', "FALSE", "False")
}
replace Q6g1_1 = "1" if inlist(Q6g1_1, "TRUE", "True")
replace Q6g1_2 = "2" if inlist(Q6g1_2, "TRUE", "True")
replace Q6g1_3 = "3" if inlist(Q6g1_3, "TRUE", "True")
replace Q6g1_4 = "4" if inlist(Q6g1_4, "TRUE", "True")
replace Q6g1_5 = "5" if inlist(Q6g1_5, "TRUE", "True")
replace Q6g1_6 = "6" if inlist(Q6g1_6, "TRUE", "True")
replace Q6g1_7 = "7" if inlist(Q6g1_7, "TRUE", "True")
replace Q6g1_8 = "8" if inlist(Q6g1_8, "TRUE", "True")
replace Q6g1_9 = "9" if inlist(Q6g1_9, "TRUE", "True")
replace Q6g1_10 = "10" if inlist(Q6g1_10, "TRUE", "True")
replace Q6g1_11 = "11" if inlist(Q6g1_11, "TRUE", "True")
replace Q6g1_12 = "12" if inlist(Q6g1_12, "TRUE", "True")
replace Q6g1_13 = "13" if inlist(Q6g1_13, "TRUE", "True")
replace Q6g1_14 = "14" if inlist(Q6g1_14, "TRUE", "True")
replace Q6g1_15 = "15" if inlist(Q6g1_15, "TRUE", "True")
replace Q6g1_16 = "16" if inlist(Q6g1_16, "TRUE", "True")
replace Q6g1_17 = "17" if inlist(Q6g1_17, "TRUE", "True")
replace Q6g1_96 = "96" if inlist(Q6g1_96, "TRUE", "True")
