*   ========================================
* SWEEP Baseline
* Do file to check the quality of data
* Author: Masood and Smita
* July 2018
*   ========================================
*
*
	*   ========================================
	*   Global Directory
	*   ========================================
	clear all
	global user "Masood"
	
	if "$user"=="Masood" {
			global mystart "~/Dropbox/SWEEP shared/Baseline QC Reports"
			}
	if "$user"=="Smita" {
			global mystart "C:\Users\wb490440\OneDrive - WBG\Baseline QC Reports"
			}
	if "$user"=="Virginia" {
			global mystart "C:\Users\"
			}
	if "$user"=="Shubha" {
			global mystart "C:\Users\"
			}
	
	set maxvar 9000
	
	local date : di %tdDmCY daily(c(current_date), "DMY")
	local yesterday : di %tdDmCY daily(c(current_date), "DMY") - 1
	
	global baseline "$mystart"
	global data="$baseline/Data"
	global report="$baseline/Reports"
	global clean="$data/post checks data"
	*=============================================================
	*0. Merge MKP and CBSG Participant survey data, such that each row corresponds to one hhid
	*=============================================================

	* Paste file names and run fix varnames
global cbsgfile "SWEEP_CBSG_Final_2018_11_12_02_31_55_343950"
global mkpfile "SWEEP_MPK_Final_2018_11_12_01_59_54_400807"
*do "$baseline/Do-files/Other do-files/fix varnames.do"					// fix varnames + SUBSET
do "$baseline/Do-files/Other do-files/fix varnames without subset"		// fix varnames + FULL SET

	* import raw CBSG data (csv format)
local cbsg_raw_data "$baseline/Data/cbsg_subset__`date'"
import delimited "`cbsg_raw_data'.csv", varnames(1) case(preserve) encoding(utf8) clear
	* cleans, labels, and prepares Stata file for CBSG data
do "$baseline/Do-files/Other do-files/1 CBSG cleaning and labelling.do"
	* list of variable names and store in a macro
local cbsg_file "$baseline/Data/post checks data/cbsg cleaned and labelled `date'"
qui describe using "`cbsg_file'.dta", varlist
local var2 `r(varlist)'
cap rm "$baseline/Data/cbsg_subset__`yesterday'.csv"

	* import raw MKP data (csv format)
local mkp_raw_data "$baseline/Data/mkp_subset__`date'"
import delimited "`mkp_raw_data'.csv", varnames(1) case(preserve) encoding(utf8) clear
	* cleans, labels, and prepares Stata file for CBSG data
do "$baseline/Do-files/Other do-files/2 MKP cleaning and labelling.do"
	* list of variable names and store in a macro
local mkp_file "$baseline/Data/post checks data/mkp cleaned and labelled `date'"
qui describe using "`mkp_file'.dta", varlist
local var1 `r(varlist)'
cap rm "$baseline/Data/mkp_subset__`yesterday'.csv"

	* matching variable names in both datasets minus hhid
local same : list var2 & var1
local idlist hhid
local same : list same - idlist

* CBSG: Remove duplicate and rename variables
	* add _cbsg and _mkp suffix to matching variables
use "`cbsg_file'.dta", clear
rename (`same') (=_cbsg)
	* drop empty observations if any
drop if missing(hhid)
	* In case of duplicate hhid in cbsg data, use the most complete record. If equally complete, use the last record
egen dup_hhid_cbsg = count(hhid), by(hhid)
qui ds Q*, has(type numeric)
egen rowmiss = rcount(`r(varlist)'), c(missing(@))
qui ds Q*, has(type string)
egen rowmty = rcount(`r(varlist)'), c(@=="")
egen miss_values = rowtotal(rowmiss rowmty)
sort hhid miss_values start_cbsg
bysort hhid: keep if _n == _N
bys hhid: keep if _n == _N
compress
save "`cbsg_file'_noduphhid.dta", replace
cap rm "$baseline/Data/post checks data/cbsg cleaned and labelled `yesterday'.dta"

* MKP: Remove duplicate and rename variables
	* add _cbsg and _mkp suffix to matching variables
use "`mkp_file'.dta", clear
rename (`same') (=_mkp)
	* drop empty observations if any
drop if missing(hhid)
	* In case of duplicate hhid in cbsg data, use the most complete record. If equally complete, use the last record
egen dup_hhid_mkp = count(hhid), by(hhid)
qui ds Q*, has(type numeric)
egen rowmiss = rcount(`r(varlist)'), c(missing(@))
qui ds Q*, has(type string)
egen rowmty = rcount(`r(varlist)'), c(@=="")
egen miss_values = rowtotal(rowmiss rowmty)
sort hhid miss_values start_mkp
bysort hhid: keep if _n == _N
bys hhid: keep if _n == _N
compress
save "`mkp_file'_noduphhid.dta", replace
cap rm "$baseline/Data/post checks data/mkp cleaned and labelled `yesterday'.dta"


* MERGE cbsg and mkp datasets by hhid. merge 1-to-1
use "`cbsg_file'_noduphhid.dta", clear
merge m:m hhid using "`mkp_file'_noduphhid.dta"
local date : di %tdDmCY daily(c(current_date), "DMY")
rename _merge match_bw_cbsg_mkp
* ENUMERATOR variables
cap drop enum_name1
cap drop enum_name2
*foreach i of varlist enum_name1_cbsg enum_name1_mkp enum_name2_cbsg enum_name2_mkp {
*	replace `i' = subinstr(`i', "_bad", "", .)
*	replace `i' = subinstr(`i', "_tak", "", .)
*	replace `i' = subinstr(`i', "_tkh", "", .)
*	replace `i' = subinstr(`i', "_bam", "", .)
*	replace `i' = subinstr(`i', "_par", "", .)
*}
gen enum_name1 = enum_name1_cbsg if enum_name1_cbsg != "" & enum_name1_cbsg == enum_name1_mkp & enum_name1_cbsg != enum_name2_cbsg
gen enum_name2 = enum_name2_cbsg if enum_name2_cbsg != "" & enum_name2_cbsg == enum_name2_mkp & enum_name1_cbsg != enum_name2_cbsg
replace enum_name1 = enum_name1_cbsg if enum_name1 == "" & enum_name1_cbsg != "" & enum_name1_mkp == ""
replace enum_name1 = enum_name1_mkp if enum_name1 == "" & enum_name1_cbsg == "" & enum_name1_mkp != ""
replace enum_name1 = enum_name1_cbsg if enum_name1 == "" & enum_name1_cbsg != "" & enum_name1_cbsg == enum_name1_mkp
replace enum_name1 = enum_name1_cbsg if enum_name1 == "" & enum_name1_cbsg != "" & enum_name1_cbsg != enum_name1_mkp
replace enum_name2 = enum_name2_cbsg if enum_name2 == "" & enum_name2_cbsg != "" & enum_name2_mkp == ""
replace enum_name2 = enum_name2_mkp if enum_name2 == "" & enum_name2_cbsg == "" & enum_name2_mkp != ""
replace enum_name2 = enum_name2_cbsg if enum_name2 == "" & enum_name2_cbsg != "" & enum_name2_cbsg == enum_name2_mkp
replace enum_name2 = enum_name2_cbsg if enum_name2 == "" & enum_name2_cbsg != "" & enum_name2_cbsg != enum_name2_mkp


* MERGE with supervisors
merge m:1 enum_name1 using "$baseline/Data/master enumerators list.dta"
drop if _merge==2
drop _merge
rename enum_supervisor supervisor_id
* SAVE
compress
save "$baseline/Data/clean_merge_data__`date'.dta", replace
cap rm "$baseline/Data/post checks data/cbsg cleaned and labelled `yesterday'_noduphhid.dta"
cap rm "$baseline/Data/post checks data/mkp cleaned and labelled `yesterday'_noduphhid.dta"


	* use cleaned and merged dataset
use "$baseline/Data/clean_merge_data__`date'.dta", clear

	*use "clean_merge_data__14Sep2018.dta", clear
* MERGE with sampling frame to check how often the household selected was part of intended sample
merge 1:1 hhid using "$baseline/Data/sampling frame.dta"
drop if _merge == 2
	
	/*=============================================================
	*1. Code missing values
		96 (Other) => .o
		98 (Don't know) => .d
		99 (Refuse) => .r
		Possible to get ODK to insert .s to differentiate skipped values and missing values?
	*=============================================================*/
	qui ds, has(type numeric)
		foreach v of varlist `r(varlist)' {
			*local l`v': var lab `v'
			replace `v' = .o if `v' == 96
			replace `v' = .d if `v' == 98
			replace `v' = .r if `v' == 99
			}
*	ds, has(type string)
*		foreach v of varlist `r(varlist)' {
*			replace `v' = ".n" if `v' == "n/a"
*			}
		
	*=============================================================
	*2. LABEL PREFILLED DATA, MERGE IN SUPERVISOR ID
	*=============================================================
	/*
		foreach v of varlist ... {
				local vlab: var lab `v'
				label var `v' "Prefilled: `vlab'"
			}
		label data ""
	*/	
		*merge in supervisor/enumerator data
		
	*=============================================================
	*3. Generate Survey Status Variable
	*=============================================================
	#d ;
	lab def survey_status 
	1 "Household not located"
	2 "Respondent unavailable, need to revisit"
	3 "No consent/respondent not present long-term"
	4 "CBSG survey incomplete, MKP survey not started"
	5 "CBSG survey complete, MKP survey not started"
	6 "MKP survey incomplete, CBSG survey not uploaded"
	7 "MKP survey complete, CBSG survey not uploaded or incomplete"
	8 "Both surveys incomplete"
	9 "CBSG survey incomplete, MKP survey not uploaded"
	10 "CBSG survey complete, MKP survey incomplete"
	11 "Both surveys complete", modify;
	#d cr


	***** KEY QUESTIONS USED IN SURVEY STATUS VARIABLE: ****
	*Q1f1	Field Officer do not read: have you located the household?
	*Q1l_consent	To CBSG respondent: We are a team working with the Aga Khan Foundation and the World Bank. We are working on a project concerned with developing local economies. The results of the survey will be important for helping design programs on local economic development for the People of Afghanistan. I would like to talk to you about this. The interview will take about 90 minutes. All the information we obtain will remain strictly confidential and your answers will never be identified. During the survey, you may refuse to answer any question or discontinue the survey at any time.  Do we have permission to proceed with the interview? 
	*Q1l_whynot	Why not?
		*1	CBSG respondent is not currently present, but will return
		*2	Family is busy and we must return another time
		*3	CBSG member is not present, and will not return in the following week
		*4	General refusal
		*96	Other(specify)
	*Q1r1	Q1r1 Could my colleague, ${enum_name2}, speak to ${Q1o}, while I interview you?
	*Q1r3	Is there ANOTHER person in the household who will know about the assets of the household, and the age, education, employment, of every household member, with whom we can speak, and who is CURRENTLY PRESENT?
		
	
	* Survey Status Variable
	gen survey_status = .
	
	* Household not located
	replace survey_status = 1 if Q1f1 == 0 
	
	* Respondent unavailable, need to revisit
	replace survey_status = 2 if inlist(Q1l_consent, 0, .) & inlist(Q1l_whynot, 1, 2) // 1) CBSG respondent is not currently present, but will return; 2) Family is busy and we must return another time; 3) CBSG member is not present, and will not return in the following week
	
	* No consent/respondent not present long-term
	replace survey_status = 3 if inlist(Q1l_consent, 0, .) & inlist(Q1l_whynot, 3, 4, .o) // 4) General refusal
	
	* CBSG survey incomplete, MKP survey not started
	replace survey_status = 4 if Q1l_consent == 1 & Q10cbsg89 == . & (inlist(Q1r1, 0, .) & missing(Q1p)) & Q1r3 == 0
	
	* CBSG survey complete, MKP survey not started
	replace survey_status = 5 if Q1l_consent == 1 & Q10cbsg89 != . & (inlist(Q1r1, 0, .) & missing(Q1p)) & Q1r3 == 0
	
	* MKP survey incomplete, CBSG survey not uploaded
	replace survey_status = 6 if match_bw_cbsg_mkp == 2 & Q10m6_mkp==.

	* MKP survey complete, CBSG survey not uploaded
	replace survey_status = 7 if match_bw_cbsg_mkp == 2 & Q10m6_mkp!=.
	replace survey_status = 7 if Q1l_consent == 1 & Q10cbsg89 == . & inlist(1, Q1r1, Q1r3) & Q1p != . & Q10m6_mkp != .

	* Both surveys incomplete
	replace survey_status = 8 if Q1l_consent == 1 & Q10cbsg89 == . & (((Q1r3 == 1 | Q1r1 == 1) & Q10m6_mkp==.) | Q1p==1)
	replace survey_status = 8 if match_bw_cbsg_mkp==3 & Q1p==. & Q2a_cbsg==. & cbsg=="" & Q10cbsg89==. & Q1r3==. & Q1r1==.
	
	* CBSG survey incomplete, MKP survey not uploaded
	replace survey_status = 9 if Q1l_consent == 1 & Q10cbsg89 == . & match_bw_cbsg_mkp == 1
	
	* CBSG survey complete, MKP survey incomplete
	replace survey_status = 10 if Q1l_consent == 1 & Q10cbsg89 != . & (Q1r3 == 1 | Q1r1 == 1) & Q10m6_mkp==.
	
	* Both surveys complete
	replace survey_status = 11 if Q1l_consent == 1 & Q10cbsg89 != . & ((Q1p==1 & Q10m6_cbsg != .) | (Q1p!=1 & (Q1r3 == 1 | Q1r1 == 1) & Q10m6_mkp!=.))
	*replace survey_status = 11 if Q1l_consent == 1 & Q10cbsg89 == . & Q1p!=1 & (Q1r3 == 1 | Q1r1 == 1) & Q2a_mkp!=. & Q5m7_mkp!=. & Q10m6_mkp!=.
	
	lab val survey_status survey_status
	tab survey_status, miss
	
	*note that completeness of survey will not depend on all errors discovered, but on key variables
	
	*=============================================================
	*4. Data checks, Save 
	*=============================================================
	compress
	* (red) error 0: if start or end date-time are missing
*>>>>>>>> missing start and end date-time
*>>>>>>>use Start_time and end_time in cbsg
*>>>>>>>use start_time and end_time in mkp

	* (yellow) Individual savings is higher than estimate group savings, indicates lack of understanding for enumerator/question
	gen err_yellow_save = (Q7k1>Q7n) if Q7k1<. & Q7k1!=99 & Q7k1!=98 & Q7n<. & Q7n!=99 & Q7n!=98
	note err_yellow_save: Individual savings is higher than estimate group savings, indicates lack of understanding for enumerator/question
	note err_yellow_save: Questions used: Q7k1 Q7n
	lab var err_yellow_save "Individual savings is higher than estimate group savings, indicates lack of understanding for enumerator/question"

	
	gen err_red_missing_datetime = (missing(start_cbsg) | missing(start_mkp) | missing(end_cbsg) | missing(end_mkp)) if match_bw_cbsg_mkp == 3
	replace err_red_missing_datetime = (missing(start_cbsg) | missing(end_cbsg)) if match_bw_cbsg_mkp == 1
	replace err_red_missing_datetime = (missing(start_mkp) | missing(end_mkp)) if match_bw_cbsg_mkp == 2
	note err_red_missing_datetime: Missing start and/or end date-time information for interviews
	note err_red_missing_datetime: Questions used: start_cbsg end_cbsg start_mkp end_mkp
	lab var err_red_missing_datetime "Missing start and/or end date-time information for interviews"
****>> yellow
	* (yellow) error 1: flag extremely fast and extremely slow surveys
	* extremely fast: <=30min for cbsg and <=20min for mkp
	* extremely slow: >=4hrs for cbsg and >=3hrs for mkp
	gen start_date_cbsg = clock(substr(start_cbsg, 1, 20), "YMD#hms#"), a(start_cbsg)
	gen start_date_mkp = clock(substr(start_mkp, 1, 20), "YMD#hms#"), a(start_mkp)
	gen end_date_cbsg = clock(substr(end_cbsg, 1, 20), "YMD#hms#"), a(end_cbsg)
	gen end_date_mkp = clock(substr(end_mkp, 1, 20), "YMD#hms#"), a(end_mkp)
	format start_date_cbsg start_date_mkp end_date_cbsg end_date_mkp %tc
	gen interview_length_cbsg = (end_date_cbsg - start_date_cbsg)/60000, a(end_date_cbsg) // interview length in minutes
	gen interview_length_mkp = (end_date_mkp - start_date_mkp)/60000, a(end_date_mkp)
	gen err_red_qui_intw_cbsg = (interview_length_cbsg <= 30) if survey_status == 11
	gen err_red_qui_intw_mkp = (interview_length_mkp <= 20) if survey_status == 11
*	gen err_yellow_slow_intw_cbsg = (interview_length_cbsg >= 240)
*	gen err_yellow_slow_intw_mkp = (interview_length_mkp >= 180)
	note err_red_qui_intw_cbsg: Length of CBSG interview is 30min or less (too short)
	note err_red_qui_intw_cbsg: Questions used: start_cbsg end_cbsg
	note err_red_qui_intw_mkp: Length of MKP interview is 20min or less (too short)
	note err_red_qui_intw_mkp: Questions used: start_mkp end_mkp
*	note err_yellow_slow_intw_cbsg: Length of CBSG interview is 4hrs or more (too long)
*	note err_yellow_slow_intw_cbsg: Questions used: start_cbsg end_cbsg
*	note err_yellow_slow_intw_mkp: Length of MKP interview is 3hrs or more (too long)
*	note err_yellow_slow_intw_mkp: Questions used: start_mkp end_mkp
	lab var err_red_qui_intw_cbsg "Length of CBSG interview is 30min or less (too short)"
	lab var err_red_qui_intw_mkp "Length of MKP interview is 20min or less (too short)"
*	lab var err_yellow_slow_intw_cbsg "Length of CBSG interview is 4hrs or more (too long)"
*	lab var err_yellow_slow_intw_mkp "Length of MKP interview is 3hrs or more (too long)"
***> fix err_red_numhhmem based on AKF comments
	replace err_red_qui_intw_cbsg = 0 if err_red_qui_intw_cbsg==1 & inlist(hhid,59030,32031,71062,180041,31010,504050,187051)
	replace err_red_qui_intw_mkp = 0 if err_red_qui_intw_mkp==1 & inlist(hhid,82102,160122,555050,213030,431070,204041,416022,411121,18111,127080,411070,18150,321011,321071,187051)
***>

	* (red) error 2: Number of household members differs between MKP and CBSG surveys by more than 1
***> fix err_red_numhhmem based on AKF comments
	replace Q1n=Q2a_mkp if inlist(hhid,514120,181081,430052,181040,62181,364081,492171,183050,498050,208100,515091,81050,31010,59061,26040,26081,361062,19111,19021,361072,148071,76070,523071,125121,415151,304091,304041,112030,8061,237072,354161,407030,305062,77130)
	replace Q1n=9 if hhid==199091
	replace Q2a_mkp=9 if hhid==199091
***>
	gen Q2a = Q2a_cbsg if Q2a_cbsg == Q2a_mkp & !missing(Q2a_cbsg) & Q1p != 1
	replace Q2a = Q2a_cbsg if missing(Q2a_mkp) & !missing(Q2a_cbsg)
	replace Q2a = Q2a_mkp if missing(Q2a_cbsg) & !missing(Q2a_mkp)
	replace Q2a = Q2a_cbsg if Q2a_cbsg == Q2a_mkp & Q1p==1
	gen err_red_numhhmem = ((Q1n+1)<Q2a | (Q1n-1)>Q2a) if !missing(Q2a) & !missing(Q1n) & Q1p!=1
	note err_red_numhhmem: Number of household members differs between MKP and CBSG surveys by more than 1
	note err_red_numhhmem: Questions used: Q1n Q2a_cbsg Q2a_mkp
	lab var err_red_numhhmem "Number of household members differs between MKP and CBSG surveys by more than 1"
	replace err_red_numhhmem = ((Q1n+1)<Q2a | (Q1n-1)>Q2a) if !missing(Q2a) & !missing(Q1n) & Q1p!=1
	
	* (red) error 2: check if number of household (Q2a) = names provided in the roster (Q2b)
	foreach i of varlist Q2b* {
		replace `i' = "" if inlist(`i', "0", "00", "No", "no")
	}
	egen length_names_hh_members = rownonmiss(Q2b*), s
	replace length_names_hh_members = length_names_hh_members/2 if Q2a_cbsg == Q2a_mkp & Q1p == 1
	gen err_red2_hh_members = (length_names_hh_members != Q2a) if !missing(length_names_hh_members) & !missing(Q2a)
	replace err_red2_hh_members = 0 if length_names_hh_members-1 == Q2a & err_red2_hh_members==1
	note err_red2_hh_members: Number of hh members and number of name entries are unequal
	note err_red2_hh_members: Questions used: Q2b-questions Q2a_cbsg Q2a_mkp
	lab var err_red2_hh_members "Number of hh members and number of name entries are unequal"
*>hhid==384130, MKP househole members are correct ?

	* (red) error 3: Verify total hh income from past 30 days (Q2_estimate): reported value was >0 & <1000
***> fix err_red_numhhmem based on AKF comments
	replace Q2_estimate_cbsg = 12000 if inlist(hhid,229060,263130)
	replace Q2_estimate_cbsg = 10000 if inlist(hhid,386010)
	replace Q2_estimate_cbsg = 6000 if inlist(hhid,111120)
	replace Q2_estimate_mkp = Q2_estimate_mkp*1000 if inlist(hhid,240022,515060,129051,147051)
	replace Q2_estimate_mkp = Q2_estimate_mkp*10 if inlist(hhid,130030,394060,59030)
***>
	gen err_red_income_cbsg = (Q2_estimate_cbsg>0 & Q2_estimate_cbsg<1000)
	gen err_red_income_mkp = (Q2_estimate_mkp>0 & Q2_estimate_mkp<1000)
	note err_red_income_cbsg: Reported value was >0 & <1000: Verify total hh income from past 30 days in CBSG interview (Q2_estimate)
	note err_red_income_cbsg: Questions used: Q2_estimate_cbsg
	note err_red_income_mkp: Reported value was >0 & <1000: Verify total hh income from past 30 days in MKP interview (Q2_estimate)
	note err_red_income_mkp: Questions used: Q2_estimate_mkp
	lab var err_red_income_cbsg "Reported value was >0 & <1000: Verify total hh income from past 30 days in CBSG interview (Q2_estimate)"
	lab var err_red_income_mkp "Reported value was >0 & <1000: Verify total hh income from past 30 days in MKP interview (Q2_estimate)"
	
	* (yellow) error 4: inconsistent and extreme expenditures on health services and medicine
	gen err_yellow_spd_hlth_incon = ((Q4b1_cbsg + 2000) <= Q4b1_mkp | (Q4b1_cbsg - 2000) >= Q4b1_mkp) if !missing(Q4b1_cbsg) & !missing(Q4b1_mkp)
	gen err_yellow_extspd_hlth = (Q4b1_cbsg >= 500000 | Q4b1_mkp >= 500000) if !missing(Q4b1_cbsg) & !missing(Q4b1_mkp)
	note err_yellow_spd_hlth_incon: Inconsistent (>2000) report on healthcare expenditure b/w CBSG and MKP members
	note err_yellow_spd_hlth_incon: Questions used: Q4b1_cbsg Q4b1_mkp
	note err_yellow_extspd_hlth: Spent 500k afghani or more on healthcare, that is considered very high
	note err_yellow_extspd_hlth: Questions used: Q4b1_cbsg Q4b1_mkp
	lab var err_yellow_spd_hlth_incon "Inconsistent (>2000) report on healthcare expenditure b/w CBSG and MKP members"
	lab var err_yellow_extspd_hlth "Spent 500k afghani or more on healthcare, that is considered very high"
	
	* (yellow) error 5: extreme expenditures on tuition for education
	gen err_yellow_spd_educ_incons = ((Q4b2_cbsg + 2000) <= Q4b2_mkp | (Q4b2_cbsg - 2000) >= Q4b2_mkp) if !missing(Q4b2_cbsg) & !missing(Q4b2_mkp)
	gen err_yellow_extspd_educ = (Q4b2_cbsg >= 15000 | Q4b2_mkp >= 15000) if !missing(Q4b2_cbsg) & !missing(Q4b2_mkp)
	note err_yellow_spd_educ_incons: Inconsistent (>2000) report on education expenditure b/w CBSG and MKP members
	note err_yellow_spd_educ_incons: Questions used: Q4b2_cbsg Q4b2_mkp
	note err_yellow_extspd_educ: Spent 15k afghani or more on education, that is considered very high
	note err_yellow_extspd_educ: Questions used: Q4b2_cbsg Q4b2_mkp
	lab var err_yellow_spd_educ_incons "Inconsistent (>2000) report on education expenditure b/w CBSG and MKP members"
	lab var err_yellow_extspd_educ "Spent 15k afghani or more on education, that is considered very high"

	* (red) error 6: inconsistent response about type of dwelling
***> fix err_red_numhhmem based on AKF comments
	replace Q5a_cbsg = Q5a_mkp if hhid==58011
*>>>
	gen err_red_dwlng_incons = (Q5a_cbsg != Q5a_mkp) if Q5a_cbsg != . & Q5a_mkp != .
	replace err_red_dwlng_incons = 0 if missing(err_red_dwlng_incons) & ((Q5a_cbsg == . & Q5a_mkp != .) | (Q5a_cbsg != . & Q5a_mkp == .))
	note err_red_dwlng_incons: CBSG and MKP provide inconsistent response about type of dwelling
	note err_red_dwlng_incons: Questions used: Q5a_cbsg Q5a_mkp
	lab var err_red_dwlng_incons "CBSG and MKP provide inconsistent response about type of dwelling"
	
	* (red) error 7: cbsg respondent saying she/he is not a member of a cbsg
	gen err_red_cbsg_notmmr = (Q7g1 == 0)
	note err_red_cbsg_notmmr: CBSG member saying she/he is not a member of a CBSG
	note err_red_cbsg_notmmr: Questions used: Q7g1
	lab var err_red_cbsg_notmmr "CBSG member saying she/he is not a member of a CBSG"
	
	* (red) error 8: more than 90% similarity in responses with another survey from the same supervisor
*	qui ds Q*, has(type numeric)
*	local numvars `r(varlist)'
*	qui ds Q3a* Q3c* Q3f*
*	local nousevars `r(varlist)'
*	local varlist : list numvars - nousevars

	local varlist Q10a_cbsg Q10a_mkp Q10a1_cbsg Q10a1_mkp Q10b_cbsg Q10b_mkp Q10c_cbsg Q10c_mkp Q10cbsg89 Q10d_cbsg Q10d_mkp Q10d_note Q10e_cbsg Q10e_mkp Q10f_cbsg Q10f_mkp Q10g_cbsg Q10g_mkp Q10h1 Q10h2_cbsg Q10h2_mkp Q10h3_cbsg Q10h3_mkp Q10h4_cbsg Q10h4_mkp Q10h5_cbsg Q10h5_mkp Q10h6_cbsg Q10h6_mkp Q10h7_cbsg Q10h7_mkp Q10h8_cbsg Q10h8_mkp Q10h9_cbsg Q10h9_mkp Q10i1_cbsg Q10i1_mkp Q10i2_cbsg Q10i2_mkp Q10i3_cbsg Q10i3_mkp Q10j1_cbsg Q10j1_mkp Q10j2_cbsg Q10j2_mkp Q10j3_cbsg Q10j3_mkp Q10k1_cbsg Q10k1_mkp Q10k2_cbsg Q10k2_mkp Q10k3_cbsg Q10k3_mkp Q10l1_cbsg Q10l1_mkp Q10l2_cbsg Q10l2_mkp Q10l3_cbsg Q10l3_mkp Q10m1_cbsg Q10m1_mkp Q10m2_cbsg Q10m2_mkp Q10m3_cbsg Q10m3_mkp Q10m4_cbsg Q10m4_mkp Q10m5_cbsg Q10m5_mkp Q10m6_cbsg Q10m6_mkp Q1ee Q1f1 Q1f2 Q1k Q1k_whynot Q1k2_other Q1l_consent Q1l_date_mkp Q1l_time_mkp Q1l_whynot Q1m3_0_cbsg Q1m3_0_mkp Q1m3_cbsg Q1m3_mkp Q1m4_0_cbsg Q1m4_0_mkp Q1m4_cbsg Q1m4_mkp Q1m5_0_cbsg Q1m5_0_mkp Q1m5_cbsg Q1m5_mkp Q1n Q1p Q1r1 Q1r2 Q1r2_other Q1r3 Q1r4 Q1r5 Q1r5_other Q1s01 Q1s02 Q1s1 Q1s2 Q1t_date Q1t_time Q2_estimate_c~g Q2_estimate_mkp Q2a Q2a_cbsg Q2a_mkp Q2g_1_cbsg Q2g_1_mkp Q2g_10_cbsg Q2g_10_mkp Q2g_11_cbsg Q2g_11_mkp Q2g_12_cbsg Q2g_12_mkp Q2g_13_cbsg Q2g_13_mkp Q2g_14_cbsg Q2g_14_mkp Q2g_15_cbsg Q2g_15_mkp Q2g_16_cbsg Q2g_16_mkp Q2g_17_cbsg Q2g_17_mkp Q2g_18_cbsg Q2g_18_mkp Q2g_19_cbsg Q2g_19_mkp Q2g_2_cbsg Q2g_2_mkp Q2g_20_cbsg Q2g_20_mkp Q2g_21_cbsg Q2g_21_mkp Q2g_22_cbsg Q2g_22_mkp Q2g_23_cbsg Q2g_23_mkp Q2g_24_cbsg Q2g_24_mkp Q2g_25_cbsg Q2g_25_mkp Q2g_26_cbsg Q2g_26_mkp Q2g_27_cbsg Q2g_27_mkp Q2g_28_cbsg Q2g_28_mkp Q2g_29_cbsg Q2g_29_mkp Q2g_3_cbsg Q2g_3_mkp Q2g_30_cbsg Q2g_30_mkp Q2g_31 Q2g_32 Q2g_33 Q2g_34 Q2g_35 Q2g_36 Q2g_37 Q2g_38 Q2g_4_cbsg Q2g_4_mkp Q2g_5_cbsg Q2g_5_mkp Q2g_6_cbsg Q2g_6_mkp Q2g_7_cbsg Q2g_7_mkp Q2g_8_cbsg Q2g_8_mkp Q2g_9_cbsg Q2g_9_mkp Q2g_other_20_cbsg Q2g_other_22_cbsg Q2g_other_23_cbsg Q2g_other_24_cbsg Q2g_other_24_cbsg Q2g_other_25_cbsg Q2g_other_25_cbsg Q2g_other_26_cbsg Q2g_other_26_cbsg Q2g_other_27_cbsg Q2g_other_27_cbsg Q2g_other_28_cbsg Q2g_other_28_cbsg Q2g_other_29_cbsg Q2g_other_30_cbsg Q2g_other_30_cbsg Q2g_other_35 Q2g_other_36 Q2g_other_37 Q2g_other_38 Q2l_1_cbsg Q2l_1_mkp Q2l_10_cbsg Q2l_10_mkp Q2l_11_cbsg Q2l_11_mkp Q2l_12_cbsg Q2l_12_mkp Q2l_13_cbsg Q2l_13_mkp Q2l_14_cbsg Q2l_14_mkp Q2l_15_cbsg Q2l_15_mkp Q2l_16_cbsg Q2l_16_mkp Q2l_17_cbsg Q2l_17_mkp Q2l_18_cbsg Q2l_18_mkp Q2l_19_cbsg Q2l_19_mkp Q2l_2_cbsg Q2l_2_mkp Q2l_20_cbsg Q2l_20_mkp Q2l_21_cbsg Q2l_21_mkp Q2l_22_cbsg Q2l_22_mkp Q2l_23_cbsg Q2l_23_mkp Q2l_24_cbsg Q2l_24_mkp Q2l_25_cbsg Q2l_25_mkp Q2l_26_cbsg Q2l_26_mkp Q2l_27_cbsg Q2l_27_mkp Q2l_28_cbsg Q2l_28_mkp Q2l_29_cbsg Q2l_29_mkp Q2l_3_cbsg Q2l_3_mkp Q2l_30_cbsg Q2l_30_mkp Q2l_31 Q2l_32 Q2l_33 Q2l_34 Q2l_35 Q2l_36 Q2l_37 Q2l_38 Q2l_4_cbsg Q2l_4_mkp Q2l_5_cbsg Q2l_5_mkp Q2l_6_cbsg Q2l_6_mkp Q2l_7_cbsg Q2l_7_mkp Q2l_8_cbsg Q2l_8_mkp Q2l_9_cbsg Q2l_9_mkp Q2n1_1_cbsg Q2n1_1_mkp Q2n1_10_cbsg Q2n1_10_mkp Q2n1_11_cbsg Q2n1_11_mkp Q2n1_12_cbsg Q2n1_12_mkp Q2n1_13_cbsg Q2n1_13_mkp Q2n1_14_cbsg Q2n1_14_mkp Q2n1_15_cbsg Q2n1_15_mkp Q2n1_16_cbsg Q2n1_16_mkp Q2n1_17_cbsg Q2n1_17_mkp Q2n1_18_cbsg Q2n1_18_mkp Q2n1_19_cbsg Q2n1_19_mkp Q2n1_2_cbsg Q2n1_2_mkp Q2n1_20_cbsg Q2n1_20_mkp Q2n1_21_cbsg Q2n1_21_mkp Q2n1_22_cbsg Q2n1_22_mkp Q2n1_23_cbsg Q2n1_23_mkp Q2n1_24_cbsg Q2n1_24_mkp Q2n1_25_cbsg Q2n1_25_mkp Q2n1_26_cbsg Q2n1_26_mkp Q2n1_27_cbsg Q2n1_27_mkp Q2n1_28_cbsg Q2n1_28_mkp Q2n1_29_cbsg Q2n1_29_mkp Q2n1_3_cbsg Q2n1_3_mkp Q2n1_30_cbsg Q2n1_30_mkp Q2n1_31 Q2n1_32 Q2n1_33 Q2n1_34 Q2n1_35 Q2n1_36 Q2n1_37 Q2n1_38 Q2n1_4_cbsg Q2n1_4_mkp Q2n1_5_cbsg Q2n1_5_mkp Q2n1_6_cbsg Q2n1_6_mkp Q2n1_7_cbsg Q2n1_7_mkp Q2n1_8_cbsg Q2n1_8_mkp Q2n1_9_cbsg Q2n1_9_mkp Q2n2_1_cbsg Q2n2_1_mkp Q2n2_10_cbsg Q2n2_10_mkp Q2n2_11_cbsg Q2n2_11_mkp Q2n2_12_cbsg Q2n2_12_mkp Q2n2_13_cbsg Q2n2_13_mkp Q2n2_14_cbsg Q2n2_14_mkp Q2n2_15_cbsg Q2n2_15_mkp Q2n2_16_cbsg Q2n2_16_mkp Q2n2_17_cbsg Q2n2_17_mkp Q2n2_18_cbsg Q2n2_18_mkp Q2n2_19_cbsg Q2n2_19_mkp Q2n2_2_cbsg Q2n2_2_mkp Q2n2_20_cbsg Q2n2_20_mkp Q2n2_21_cbsg Q2n2_21_mkp Q2n2_22_cbsg Q2n2_22_mkp Q2n2_23_cbsg Q2n2_23_mkp Q2n2_24_cbsg Q2n2_24_mkp Q2n2_25_cbsg Q2n2_25_mkp Q2n2_26_cbsg Q2n2_26_mkp Q2n2_27_cbsg Q2n2_27_mkp Q2n2_28_cbsg Q2n2_28_mkp Q2n2_29_cbsg Q2n2_29_mkp Q2n2_3_cbsg Q2n2_3_mkp Q2n2_30_cbsg Q2n2_30_mkp Q2n2_31 Q2n2_32 Q2n2_33 Q2n2_34 Q2n2_35 Q2n2_36 Q2n2_37 Q2n2_38 Q2n2_4_cbsg Q2n2_4_mkp Q2n2_5_cbsg Q2n2_5_mkp Q2n2_6_cbsg Q2n2_6_mkp Q2n2_7_cbsg Q2n2_7_mkp Q2n2_8_cbsg Q2n2_8_mkp Q2n2_9_cbsg Q2n2_9_mkp Q2x1_cbsg Q2x1_mkp Q2x2_cbsg Q2x2_mkp Q2x3_cbsg Q2x3_mkp Q2x4_cbsg Q2x4_mkp Q2x5_cbsg Q2x5_mkp Q2x6_cbsg Q2x6_mkp Q3a_mkp Q3a_name1_mkp Q3a_name10_mkp Q3a_name11_mkp Q3a_name12_mkp Q3a_name13_mkp Q3a_name14_mkp Q3a_name15_mkp Q3a_name16_mkp Q3a_name17_mkp Q3a_name18_mkp Q3a_name19_mkp Q3a_name2_mkp Q3a_name20_mkp Q3a_name3_mkp Q3a_name4_mkp Q3a_name5_mkp Q3a_name6_mkp Q3a_name7_mkp Q3a_name8_mkp Q3a_name9_mkp Q3c_mkp Q3c_name1_mkp Q3c_name10_mkp Q3c_name11_mkp Q3c_name12_mkp Q3c_name13_mkp Q3c_name14_mkp Q3c_name15_mkp Q3c_name16_mkp Q3c_name17_mkp Q3c_name18_mkp Q3c_name19_mkp Q3c_name2_mkp Q3c_name20_mkp Q3c_name3_mkp Q3c_name4_mkp Q3c_name5_mkp Q3c_name6_mkp Q3c_name7_mkp Q3c_name8_mkp Q3c_name9_mkp Q3f_mkp Q3f_na_mkp Q3f_name1_mkp Q3f_name10_mkp Q3f_name11_mkp Q3f_name12_mkp Q3f_name13_mkp Q3f_name14_mkp Q3f_name15_mkp Q3f_name16_mkp Q3f_name17_mkp Q3f_name18_mkp Q3f_name19_mkp Q3f_name2_mkp Q3f_name20_mkp Q3f_name3_mkp Q3f_name4_mkp Q3f_name5_mkp Q3f_name6_mkp Q3f_name7_mkp Q3f_name8_mkp Q3f_name9_mkp Q4b1_cbsg Q4b1_mkp Q4b2_cbsg Q4b2_mkp Q4c_cbsg Q4c_mkp Q5a_cbsg Q5a_mkp Q5m1_cbsg Q5m1_mkp Q5m10_cbsg Q5m10_mkp Q5m2_cbsg Q5m2_mkp Q5m3_cbsg Q5m3_mkp Q5m4_cbsg Q5m4_mkp Q5m5_cbsg Q5m5_mkp Q5m6_cbsg Q5m6_mkp Q5m7_cbsg Q5m7_mkp Q5m8_cbsg Q5m8_mkp Q5m9_cbsg Q5m9_mkp Q6a Q6b Q6c Q6d Q6e Q6f Q6g1_1 Q6g1_10 Q6g1_11 Q6g1_12 Q6g1_13 Q6g1_14 Q6g1_15 Q6g1_16 Q6g1_17 Q6g1_2 Q6g1_3 Q6g1_4 Q6g1_5 Q6g1_6 Q6g1_7 Q6g1_8 Q6g1_9 Q6g1_96 Q7f1 Q7g1 Q7k1 Q7n Q2_memberid_*_cbsg Q2_memberid_*_mkp
	percentmatch `varlist' if survey_status > 1, gen(pmatch) idvar(hhid) matchedid(matched_hhid)
		preserve
		keep hhid supervisor_id
		rename (hhid supervisor_id) (matched_hhid match_supervisor_id)
		save "$baseline/Data/near_dup_matchedid_`date'.dta", replace
		restore
	merge m:1 matched_hhid using "$baseline/Data/near_dup_matchedid_`date'.dta", gen(xxx) keep(master match)
	gen err_red2_close_match = (pmatch > .9 & supervisor_id == match_supervisor_id) if Q1l_consent==1
	note err_red2_close_match: More than 90% similarity in response to questions within the same supervisor, which is considered very high
	note err_red2_close_match: Questions used: All variables
	note matched_hhid: Matched hhid
	note pmatch: Percent matched
	lab var matched_hhid "Matched hhid"
	lab var pmatch "Percent matched"
	lab var err_red2_close_match "More than 90% similarity in response to questions within the same supervisor, which is considered very high"
	cap rm "$baseline/Data/near_dup_matchedid_`yesterday'.dta"
	
	* (red) error 9: CBSG report self (Q1p==1) and MKP questionnaire is filled
	gen err_red_mkp_nt_missing = (Q1p == 1 & match_bw_cbsg_mkp == 3) if Q5m9_mkp != .
	note err_red_mkp_nt_missing: CBSG report self (Q1p==1) and MKP questionnaire is filled
	note err_red_mkp_nt_missing: Questions used: Q1p and MKP Questionnaire
	lab var err_red_mkp_nt_missing "CBSG report self (Q1p==1) and MKP questionnaire is filled"
	
	* (red) error 10: CBSG doesn't report self (Q1p != 1) and MKP q're is missing
	gen err_red_mkp_missing = (Q1p != 1 & Q1p != . & match_bw_cbsg_mkp != 3) if survey_status>1 & survey_status!=3
	note err_red_mkp_missing: CBSG doesn't report self (Q1p != 1) and MKP q're is missing
	note err_red_mkp_missing: Questions used: Q1p and MKP Questionnaire
	lab var err_red_mkp_missing "CBSG doesn't report self (Q1p != 1) and MKP q're is missing"
	
	* (red) error 11: More than one or no head of houshold, ensure that only one individual is selected in Q3a_name
***> fix err_red_numhhmem based on AKF comments
	foreach i of varlist Q3a_name* {
		replace `i' = 1 - `i' if inlist(hhid,557171,182041,163161,114080,26040,474160,330070,289072)
	}
	replace Q3a_name1_mkp = 0 if inlist(hhid,144080)
	replace Q3a_name1_mkp = 0 if inlist(hhid,172122)
	replace Q3a_name3_mkp = 0 if inlist(hhid,100060)
	replace Q3a_name4_mkp = 0 if inlist(hhid,203071,100060)
	replace Q3a_name5_mkp = 0 if inlist(hhid,100060)
	replace Q3a_name6_mkp = 0 if inlist(hhid,100060)
	replace Q3a_name7_mkp = 0 if inlist(hhid,100060)
	replace Q3a_name8_mkp = 0 if inlist(hhid,100060)
	replace Q3a_name9_mkp = 0 if inlist(hhid,100060)
	replace Q3a_name1_cbsg = 0 if inlist(hhid,477120,505102,29130,505172,14162,464190)
	replace Q3a_name2_cbsg = 0 if inlist(hhid,252042,182041,220021,268071,522201,285090,506241,560012,531120,113230,58011)
	replace Q3a_name3_cbsg = 0 if inlist(hhid,268071,529190,285090,335161,448121,520010)
	replace Q3a_name4_cbsg = 0 if inlist(hhid,428120,268071)
***> 
	egen n_hoh_cbsg = rowtotal(Q3a_name*_cbsg)
	egen n_hoh_mkp = rowtotal(Q3a_name*_mkp)
	gen n_hoh = n_hoh_cbsg if n_hoh_mkp == 0 & n_hoh_cbsg > 0
	replace n_hoh = n_hoh_mkp if n_hoh_cbsg == 0 & n_hoh_mkp > 0
	replace n_hoh = n_hoh_cbsg if n_hoh_cbsg == n_hoh_mkp & Q1p == 1
	replace n_hoh = n_hoh_mkp if n_hoh_cbsg == n_hoh_mkp & Q1p > 1
	gen err_red_incons_hoh = (n_hoh>1 | missing(n_hoh))
	note err_red_incons_hoh: More than one or no head of houshold, ensure that only one individual is selected in Q3a_name
	note err_red_incons_hoh: Questions used: Roster Q2b and Q3a_name in cbsg and mkp, and Q1p
	lab var err_red_incons_hoh "More than one or no head of houshold, ensure in Q3a_name only one individual is selected"
	
	* (red) error 12: More than one individual identified as respondent, ensure that only one individual is selected in Q3c
***> fix err_red_numhhmem based on AKF comments
	foreach i of varlist Q3c_name* {
		replace `i' = 1 - `i' if inlist(hhid,557171,100060,114080,289072,216040,240012)
	}
	foreach i of varlist Q3c_name*cbsg {
		replace `i' = 1 - `i' if inlist(hhid,474160)
	}
	replace Q3c_name1_mkp = 1 if inlist(hhid,100060)
	replace Q3c_name2_mkp = 0 if inlist(hhid,100060)
	replace Q3c_name3_mkp = 0 if inlist(hhid,544020)
	replace Q3c_name6_mkp = 0 if inlist(hhid,544020)
	replace Q3c_name1_cbsg = 0 if inlist(hhid,51122)
	replace Q3c_name2_cbsg = 0 if inlist(hhid,308111)
	replace Q3c_name7_cbsg = 0 if inlist(hhid,529190)
***>
	egen n_self_resp_cbsg = rowtotal(Q3c_name*_cbsg)
	egen n_self_resp_mkp = rowtotal(Q3c_name*_mkp)
	gen n_self_resp = n_self_resp_cbsg if n_self_resp_mkp == 0 & n_self_resp_cbsg > 0
	replace n_self_resp = n_self_resp_mkp if n_self_resp_cbsg == 0 & n_self_resp_mkp > 0
	replace n_self_resp = n_self_resp_cbsg if n_self_resp_cbsg == n_self_resp_mkp & Q1p == 1
	replace n_self_resp = n_self_resp_mkp if n_self_resp_cbsg == n_self_resp_mkp & Q1p > 1
	gen err_red_incons_self_resp = (n_self_resp>1 | missing(n_self_resp))
	note err_red_incons_self_resp: More than one individual identified as respondent, ensure that only one individual is selected in Q3c
	note err_red_incons_self_resp: Questions used: Roster Q2b and Q3c_name in cbsg and mkp, and Q1p
	lab var err_red_incons_self_resp "More than one individual identified as respondent, ensure that only one individual is selected in Q3c"
	
	* (red) error 13: No individual is CBSG member, ensure at least one individual is selected for Q3f
***> fix err_red_numhhmem based on AKF comments
	foreach i of varlist Q3f_name*_mkp {
		replace `i' = 1 - `i' if inlist(hhid,554052,319201)
	}
***>
	cap drop n_cbsg_member* err_red_no_cbsg_member
	egen n_cbsg_member_cbsg = rowtotal(Q3f_name*_cbsg)
	egen n_cbsg_member_mkp = rowtotal(Q3f_name*_mkp)
	gen n_cbsg_member = n_cbsg_member_cbsg if n_cbsg_member_mkp == 0 & n_cbsg_member_cbsg > 0
	replace n_cbsg_member = n_cbsg_member_mkp if n_cbsg_member_cbsg == 0 & n_cbsg_member_mkp > 0
	replace n_cbsg_member = n_cbsg_member_cbsg if n_cbsg_member_cbsg == n_cbsg_member_mkp & Q1p == 1
	replace n_cbsg_member = n_cbsg_member_mkp if n_cbsg_member_cbsg == n_cbsg_member_mkp & Q1p > 1
	gen err_red_no_cbsg_member = (n_cbsg_member>1 | missing(n_cbsg_member))
	note err_red_no_cbsg_member: No individual is CBSG member, ensure at least one individual is selected for Q3f
	note err_red_no_cbsg_member: Questions used: Roster Q3f_name in cbsg and mkp, Q1p
	lab var err_red_no_cbsg_member "No individual is CBSG member, ensure at least one individual is selected for Q3f"
	
	* aggregate error variables
	egen error_red = rowtotal(err_red_*)
	lab var error_red "Number of red error variables"
	gen error_red_dummy = (error_red > 0)
	lab def err 1 "Has error" 0 "Doesn't have error"
	lab val error_red_dummy err
	lab var error_red_dummy "number of surveys with any red error/issues"
	
	* parental consent form
	gen parent_consent_req = (below_18 == 1 & parentalhome == 1)
	note parent_consent_req: Verify that physical parental consent form has been signed and saved
	lab var parent_consent_req "Verify that physical parental consent form has been signed and saved"

	* check skips
	*gen skip_q8c = (!missing(Q8c2) & !Q8c1) // loop
	*lab var skip_q8c "Skip logic for q8c"
	gen skip_q7f = (!missing(Q7f2) & !Q7f1)
	lab var skip_q7f "Skip logic for q7f"
	*gen skip_q6n = (!inlist(., Q6n2, Q6n3, Q6n4, Q6n5) & !Q6n1)
	*lab var skip_q6n "Skip logic for q6n"
	gen skip_q5m_cbsg  = (!inlist(., Q5m2_cbsg, Q5m3_cbsg, Q5m4_cbsg, Q5m5_cbsg, Q5m6_cbsg, Q5m7_cbsg, Q5m8_cbsg, Q5m9_cbsg, Q5m10_cbsg) & !Q5m1_cbsg)
	lab var skip_q5m_cbsg "Skip logic for q5m, CBSG respondent"
	gen skip_q5m_mkp  = (!inlist(., Q5m2_mkp, Q5m3_mkp, Q5m4_mkp, Q5m5_mkp, Q5m6_mkp, Q5m7_mkp, Q5m8_mkp, Q5m9_mkp, Q5m10_mkp) & !Q5m1_mkp)
	lab var skip_q5m_mkp "Skip logic for q5m, MKP respondent"
	gen skip_q2x_cbsg = (!missing(Q2x2_cbsg) & !Q2x1_cbsg)
	lab var skip_q2x_cbsg "Skip logic for q2x, CBSG respondent"
	gen skip_q2x_mkp = (!missing(Q2x2_mkp) & !Q2x1_mkp)
	lab var skip_q2x_mkp "Skip logic for q2x, MKP respondent"
	
	* check income from Roster to Module 6
	*Q2v What is the total amount in cash, services or goods ${roster2_name} received for ALL OF THESE economic activities in the last 30 DAYS, if any? (in case of cash include any bonuses, commissions, allowances or tips)
	*gen cash_recieved_discrepancy = abs(Q2v_mkp - Q2v_cbsg)
	*replace cash_recieved_discrepancy_p = cash_recieved_discrepancy / Q2v_mkp
	*replace err_income = ((cash_recieved_discrepancy > .2 & Q2v_cbsg > 2500) | (cash_recieved_discrepancy > 500 & Q2v_cbsg <= 2500))
	*lab var err_income "CBSG and MKP participants report significantly inconsistent incomes"
	
	compress
	save "$baseline/Data/post checks data/sweep_hh_level_data__`date'.dta", replace
	cap rm "$baseline/Data/clean_merge_data__`yesterday'.dta"
	*=============================================================
	*   Set log translator options
	*=============================================================

	translator set smcl2pdf logo off
	translator set smcl2pdf fontsize 8
	translator set smcl2pdf lmargin 0.4
	translator set smcl2pdf rmargin 0.4
	translator set smcl2pdf tmargin 0.4
	translator set smcl2pdf bmargin 0.4
	translator set smcl2pdf pagesize a4
	translator set smcl2pdf headertext ""

	
	*=============================================================
	*R1. Generate Overview report for AKF (including regional managers), Sayara, World Bank
	*=============================================================
	local date : di %tdDmCY daily(c(current_date), "DMY")
	use "$baseline/Data/post checks data/sweep_hh_level_data__`date'.dta", clear
	cap mkdir "$baseline/Reports"
	cap mkdir "$baseline/Reports/Overview"
	cap log close
	
	* Generate variables for number of target interviews and number of completed interviews (status==11)
	preserve
	use "$baseline/data/sampling frame.dta"
	egen target_num_of_intvw = count(order_priority) if order_priority==1, by(district)
	collapse target_num_of_intvw, by(district)
	tempfile sampleframe
	save "`sampleframe'"
	restore
	merge m:1 district using "`sampleframe'", gen(aggregate_sf_merge)
	egen compl_num_of_intvw = count(district) if aggregate_sf_merge==3 & survey_status == 11, by(district)
	
	
	*gen gender = 
	
	
	log using "$baseline/Reports/Overview/Overview__`date'.smcl", replace

	***********************STATUS OF SURVEYS***************************
	*OVERALL
	
	*Survey Status
	tab survey_status if aggregate_sf_merge==3, miss
	
	*Survey Status by District
	*replace compl_num_of_intvw = 0 if aggregate_sf_merge == 2
	qui levelsof district, local(dis)
	foreach i of local dis {
		qui sum target_num_of_intvw if district == "`i'"
		local target = `r(mean)'
		qui sum compl_num_of_intvw if district == "`i'"
		local compl = `r(N)'
		local remain = `target' - `compl'
		local remainP = round((`target' - `compl')/`target', .01)*100
		di "`i': `compl' completed, `target' targetted -- REMAINING: `remain' (-`remainP'%)"
	}
		
	*Order Priority from Sampling Frame
	table survey_status order_priority
	
	*Duplicate hhid in CBSG data
	list hhid dup_hhid_cbsg if dup_hhid_cbsg > 1 & !missing(dup_hhid_cbsg)
	
	*Duplicate hhid in MKP data
	list hhid dup_hhid_mkp if dup_hhid_mkp > 1 & !missing(dup_hhid_mkp)
	
	*Consent
	tab Q1l_consent
	
	*List all errors
	foreach err of varlist err_red* {
		qui sum `err' if !missing(`err') & survey_status == 11, detail
		local `v'_round = 100*round(`r(mean)', .01)
		local `v'_lab = "``err'[note1]'"
		*local `v'_lab: var lab `err'
		di "(RED) ``v'_round'% errors: ``v'_lab' -- ``err'[note2]'"
	}
	foreach err of varlist err_yellow_* {
		qui sum `err' if !missing(`err') & survey_status == 11, detail
		local `v'_round = 100*round(`r(mean)', .01)
		local `v'_lab = "``err'[note1]'"
		*local `v'_lab: var lab `err'
		di "(YELLOW) ``v'_round'% errors: ``v'_lab' -- ``err'[note2]'"
	}
	
	*Relationship between mkp and cbsg member
	tab Q1p if survey_status == 11, miss
	
	*Number of Household Members
	sum Q2a if survey_status == 11, detai
	
	*During the last 12 MONTHS did you always have enough food for your household?
	tab Q4c_cbsg if survey_status == 11, miss
	
	*In the last 7 days, did you work for a wage, salary, commission or any payment in kind; including doing paid domestic work or paid farm work even if for one hour?
	tab Q6a if survey_status == 11, miss
	
	*In the last 7 days, did you run a business of any size for yourself or the household or with partners, even if for one hour?
	tab Q6b if survey_status == 11, miss
	
	*In the last 7 days, did you help in any kind of business run by this household, even if for one hour?
	tab Q6c if survey_status == 11, miss
	
	*In the last 7 days, did you work as a paid or unpaid apprentice even if just for one hour?
	tab Q6d if survey_status == 11, miss
	
	*In the last 7 days, did you work on your household's farm or work with livestock or poultry, even if for one hour?
	tab Q6e if survey_status == 11, miss
	
	*Although you did not work last week, do have work (any of activities above) from which you were temporarily absent?
	tab Q6f if survey_status == 11, miss
	
	*Were you involved in any of the following economic activities to contribute to earning money for yourself OR YOUR FAMILY in the past 12 months?
	mrtab Q6g1_* if survey_status == 11, poly sort des includemissing
	
	log close
	translate "$baseline/Reports/Overview/Overview__`date'.smcl" "$baseline/Reports/Overview/Overview__`date'.pdf", replace

	*=============================================================
	*R2. Generate one report per supervisor
	*=============================================================
	cap mkdir "$baseline/Reports/By Supervisor"
	cap mkdir "$baseline/Reports/By Supervisor/`date'"
	
levelsof supervisor_id, local(uniq_supervisor)

foreach i of local uniq_supervisor {
	
	preserve
	keep if supervisor_id == "`i'"
	log using "$baseline/Reports/By Supervisor/`date'/Report_`i'_`date'.smcl", replace
	
	di ""
	di "*****************************************************************"
	di "**************** STATUS OF SURVEYS BY SUPERVISOR ****************"
	di "*****************************************************************"
	
	fre survey_status
	list hhid survey_status if survey_status != 11
	
	di ""
	di "*****************************************************************"
	di "**************** RED ERRORS : CALL BACK REQUIRED ****************"
	di "*****************************************************************"
	
	foreach err of varlist err_red_* {
		local `v'_lab = "``err'[note1]'"
		*local `v'_lab: var lab `err'
		qui sum `err' if survey_status == 11 & aggregate_sf_merge==3
		if (`r(N)' > 0) {
			if (`r(mean)' > 0) {
				di "(RED): ``v'_lab': List of all hhid"
				list hhid if `err'==1 & survey_status == 11
			}
		}
	}
	
	di "(RED): `err_red2_close_match[note1]': List of all hhid"
	list hhid matched_hhid pmatch if err_red2_close_match & survey_status == 11
	
	di "(RED): `err_red2_hh_members[note1]': List of all hhid"
	list hhid length_names_hh_members Q2a if err_red2_hh_members & survey_status == 11
	
	di ""
	di "*****************************************************************"
	di "************* YELLOW ERRORS : CALL BACK NOT REQUIRED ************"
	di "*****************************************************************"
	
	foreach err of varlist err_yellow_* {
		local `v'_lab = "``err'[note1]'"
		*local `v'_lab: var lab `err'
		qui sum `err' if survey_status == 11 & aggregate_sf_merge==3
		if (`r(N)' > 0) {
			if (`r(mean)' > 0) {
				di "(YELLOW): ``v'_lab': List of all hhid"
				list hhid if `err'==1 & survey_status == 11
			}
		}
	}
	
	di ""
	di "*****************************************************************"
	di "*******************ENUMERATOR TRENDS*****************************"
	di "*****************************************************************"
		
	tab error_red, miss
	table enum_name1 error_red_dummy


	qui levelsof enum_name1, local(uniq_enum)
	foreach enum of local uniq_enum {
		qui sum error_red_dummy if !missing(error_red_dummy) & survey_status == 11 & enum_name1 == "`enum'"
		if (`r(mean)' > 0) {
			
			di "ENUMERATOR: `enum'"
			foreach err of varlist err_red_* {
				
				qui sum `err' if !missing(`err') & survey_status == 11 & enum_name1 == "`enum'"
				if (`r(N)' >  0) {
				if (`r(mean)' > 0) {
					local `v'_round = 100*round(`r(mean)', .01)
					local `v'_lab = "``err'[note1]'"
					*local `v'_lab: var lab `err'
					di "(RED) ``v'_round'% errors: ``v'_lab' -- ``err'[note2]'"
				}
				}
			}
		}
	}

	di ""
	di "********************************************************************"
	di "List of HHID with CBSG member under 18"
	di "Verify that physical parental consent form has been signed and saved"
	di "********************************************************************"

	list hhid if parent_consent_req
	
	
	**********************LIST OF Households requiring callbacks********************
	
	log close
	translate "$baseline/Reports/By Supervisor/`date'/Report_`i'_`date'.smcl" "$baseline/Reports/By Supervisor/`date'/Report_`i'_`date'.pdf", replace
	
	restore
	}

	save "$baseline/Data/post checks data/sweep_hh_level_data__`date'.dta", replace
	cap rm "$baseline/Data/post checks data/sweep_hh_level_data__`yesterday'.dta"
	
	********************** NEW SUPERVISORS REPORT IN EXCEL **********************
	local date : di %tdDmCY daily(c(current_date), "DMY")
	use "$baseline/Data/post checks data/sweep_hh_level_data__`date'.dta", clear
	
	egen ERRORS = rowtotal(err_red_missing_datetime err_red_qui_intw_cbsg err_red_qui_intw_mkp err_red_numhhmem err_red2_hh_members err_red_income_cbsg err_red_income_mkp err_red_dwlng_incons err_red_cbsg_notmmr err_red2_close_match err_red_mkp_nt_missing err_red_mkp_missing err_red_incons_hoh err_red_incons_self_resp err_red_no_cbsg_member)
	note ERRORS: TOTAL RED ERRORS
	lab var ERRORS "TOTAL RED ERRORS"
	
	global keep ERRORS survey_status hhid province district village ///
			cdc cdchead_info ///
			date* today* ///
			enum_name* *supervisor* ///
			_submission_time_cbsg _submission_time_mkp start_cbsg start_date_cbsg start_mkp start_date_mkp ///
			end_cbsg end_time_cbsg end_mkp end_time_mkp ///
			sfcbsg_resp_cbsg resp_corr_cbsg cbsg_resp_cbsg ///
			sfnumber1_cbsg sfnumber2_cbsg sfnumber3_cbsg sfnumber1_mkp sfnumber2_mkp sfnumber3_mkp ///
			err_red_missing_datetime err_red_qui_intw_cbsg err_red_qui_intw_mkp err_red_numhhmem err_red2_hh_members err_red_income_cbsg err_red_income_mkp err_red_dwlng_incons err_red_cbsg_notmmr err_red2_close_match hhid pmatch matched_hhid err_red_mkp_nt_missing err_red_mkp_missing err_red_incons_hoh err_red_incons_self_resp err_red_no_cbsg_member
	
	keep $keep
	order $keep
	sort _submission_time_cbsg
	foreach i of varlist err_red* {
		gen comment_`i' = ""
		order comment_`i', a(`i')
		note comment_`i': COMMENT
	}
	note survey_status: Survey Status
	export excel using "/Users/macbookair/Dropbox/SWEEP shared/Baseline QC Reports/Reports/By Supervisor/Report_Supervisors__`date'.xlsx", firstrow(variables) replace
	save "/Users/macbookair/Dropbox/SWEEP shared/Baseline QC Reports/Reports/By Supervisor/Report_Supervisors__`date'.dta", replace
	
	gen obs = 1
	collapse (sum) obs (mean) err_red* if survey_status == 11, by(province enum_name1)
	export excel using "/Users/macbookair/Dropbox/SWEEP shared/Baseline QC Reports/Reports/By Supervisor/Report_Enumerators_RED__`date'.xlsx", firstrow(variables) replace
	save "/Users/macbookair/Dropbox/SWEEP shared/Baseline QC Reports/Reports/By Supervisor/Report_Enumerators_RED__`date'.dta", replace

	use "/Users/macbookair/Dropbox/SWEEP shared/Baseline QC Reports/Reports/By Supervisor/Report_Supervisors__`date'.dta", clear
	tempname memhold
	tempfile results
	postfile `memhold' str2045(varname labels1 labels2) using "`results'"

	foreach i of varlist * {
		local lab1 = "``i'[note1]'"
		local lab2 = "``i'[note2]'"
		post `memhold' ("`i'") ("`lab1'") ("`lab2'")
	}
	postclose `memhold'
	
	use `results', clear // open the dataset we created in the cloud/meomry
	compress
	
	gen label = labels1 + "; " + labels2 if labels1 != "" & labels2 != ""
	replace label = labels1 if labels1 != "" & labels2 == ""
	replace label = varname if label == ""
	
	export excel using "/Users/macbookair/Dropbox/SWEEP shared/Baseline QC Reports/Reports/By Supervisor/var_labels__`date'.xlsx", firstrow(variables) replace
	

	
