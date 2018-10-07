**** this do file cleans, labels, and prepares Stata file for MKP data


* rename variables ****DOESN'T WORK BECAUSE OF VERY LONG VAR NAMES. INSTEAD USE R SCRIPT FOR RENAMING***
*do "~/Dropbox/SWEEP shared/Baseline QC Reports/Do-files/Other do-files/2.1 mkp_variable_names.do"

* clean n/a values and destring
qui ds, has(type string)
foreach v of varlist `r(varlist)' {
	replace `v' = ".n" if `v' == "n/a"
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
foreach v of varlist `r(varlist)' {
	replace `v' = "" if `v' == ".n"
}

* format variables
cap format %20.0g deviceid
cap format %25.0g simserial
cap format %12.0g sfnumber*

* drop empty variables.. search dropmiss and install dm89_2
cap dropmiss *NA, force

* apply value labels
do "~/Dropbox/SWEEP shared/Baseline QC Reports/Do-files/Other do-files/2.3 mkp lab def.do"
do "~/Dropbox/SWEEP shared/Baseline QC Reports/Do-files/Other do-files/2.4 mkp lab val.do"

* apply variable labels
do "~/Dropbox/SWEEP shared/Baseline QC Reports/Do-files/Other do-files/2.5 mkp lab var.do"

* save
local date : di %tdDmCY daily(c(current_date), "DMY")
save "~/Dropbox/SWEEP shared/Baseline QC Reports/Data/post checks data/mkp cleaned and labelled `date'.dta", replace
