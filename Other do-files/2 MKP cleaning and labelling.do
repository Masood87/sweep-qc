**** this do file cleans, labels, and prepares Stata file for MKP data


* rename variables
do "~/Dropbox/SWEEP shared/Baseline QC Reports/Do-files/Other do-files/2.1 mkp_variable_names.do"

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

	destring `v', replace ignore("﻿")
}

qui ds, has(type string)
foreach v of varlist `r(varlist)' {
	replace `v' = "" if `v' == ".n"
}

* drop empty variables
dropmiss *, force

* apply value labels
do "~/Dropbox/SWEEP shared/Baseline QC Reports/Do-files/Other do-files/2.3 mkp lab def.do"
do "~/Dropbox/SWEEP shared/Baseline QC Reports/Do-files/Other do-files/2.4 mkp lab val.do"

* apply variable labels
do "~/Dropbox/SWEEP shared/Baseline QC Reports/Do-files/Other do-files/2.5 mkp lab var.do"

* save
save "~/Dropbox/SWEEP shared/Baseline QC Reports/Data/mkp cleaned and labelled.dta", replace
