**** this do file cleans, labels, and prepares Stata file for CBSG data


* rename variables ****DOESN'T WORK BECAUSE OF VERY LONG VAR NAMES. INSTEAD USE R SCRIPT FOR RENAMING***
*do "~/Dropbox/SWEEP shared/Baseline QC Reports/Do-files/Other do-files/1.1 cbsg_variable_names.do"

* cleaning multiple response questions
do "~/Dropbox/SWEEP shared/Baseline QC Reports/Do-files/Other do-files/1.2 cbsg cleaning multiple response variables.do"

* an empty observation (except for hhid cell) appears when importing data from csv to Stata.
* this code removes that line
keep if sfdistrict != ""

* clean n/a values and destring
qui ds, has(type string)
foreach v of varlist `r(varlist)' {
	replace `v' = "" if `v' == "n/a"
	replace `v' = subinstr(`v', "۰", "0", .)
	replace `v' = subinstr(`v', "۱", "1", .)
	replace `v' = subinstr(`v', "۲", "2", .)
	replace `v' = subinstr(`v', "۳", "3", .)
	replace `v' = subinstr(`v', "۴", "4", .)
	replace `v' = subinstr(`v', "۵", "5", .)
	replace `v' = subinstr(`v', "۶", "6", .)
	replace `v' = subinstr(`v', "۷", "7", .)
	replace `v' = subinstr(`v', "۸", "8", .)
	replace `v' = subinstr(`v', "۹", "9", .)
	
	* removes byte order mark (BOM) that prevents destring (https://en.wikipedia.org/wiki/Byte_order_mark)
	destring `v', replace ignore("﻿")
}

qui ds, has(type string)
cap foreach v of varlist `r(varlist)' {
	replace `v' = "" if `v' == ".n"
}

* format variables
cap format %20.0g deviceid
cap format %25.0g simserial
cap format %12.0g sfnumber*

* drop empty variables.. search dropmiss and install dm89_2
cap dropmiss *NA, force
			
* apply value labels
do "~/Dropbox/SWEEP shared/Baseline QC Reports/Do-files/Other do-files/1.3 cbsg lab def.do"
do "~/Dropbox/SWEEP shared/Baseline QC Reports/Do-files/Other do-files/1.4 cbsg lab val.do"

* apply variable labels
do "~/Dropbox/SWEEP shared/Baseline QC Reports/Do-files/Other do-files/1.5 cbsg lab var.do"

* apply full text questions as variable notes
do "~/Dropbox/SWEEP shared/Baseline QC Reports/Do-files/Other do-files/1.6 cbsg variable note.do"

* save
local date = subinstr("`c(current_date)'", " " , "", .)
save "~/Dropbox/SWEEP shared/Baseline QC Reports/Data/post checks data/cbsg cleaned and labelled `date'.dta", replace
