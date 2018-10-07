qui ds, has(type string)
local str_vars `r(varlist)'

foreach i of local str_vars {
	replace `i' = "1" if `i' == "Yes"
	replace `i' = "0" if `i' == "No"
}

replace Q5m1 = "98" if Q5m1 == "Do not know"
