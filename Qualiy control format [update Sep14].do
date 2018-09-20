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
	
	local date = subinstr("`c(current_date)'", " " , "", .)
	global baseline "$mystart"
	global raw="$baseline/raw data"
	global report="$baseline/report"
	global clean="$baseline/post checks data"
	*=============================================================
	*0. Merge MKP and CBSG Participant survey data, such that each row corresponds to one hhid
	*=============================================================

	* import raw CBSG data (csv format)
local cbsg_raw_data "cbsg_subset__`date'"
import delimited "$baseline/Data/`cbsg_raw_data'.csv", varnames(1) case(preserve) encoding(utf8) clear
	* cleans, labels, and prepares Stata file for CBSG data
do "$baseline/Do-files/Other do-files/1 CBSG cleaning and labelling.do"
	* list of variable names and save in a macro
local cbsg_file "$baseline/Data/baseline/cbsg cleaned and labelled `date'"
qui describe using "`cbsg_file'.dta", varlist
local var2 `r(varlist)'


	* import raw MKP data (csv format)
local mkp_raw_data "mkp_subset__`date'"
import delimited "$baseline/Data/`mkp_raw_data'.csv", varnames(1) case(preserve) encoding(utf8) clear
	* cleans, labels, and prepares Stata file for CBSG data
do "$baseline/Do-files/Other do-files/2 MKP cleaning and labelling.do"
	* list of variable names and save in a macro
local mkp_file "$baseline/Data/baseline/mkp cleaned and labelled `date'"
qui describe using "`mkp_file'.dta", varlist
local var1 `r(varlist)'


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
rm "`cbsg_file'.dta"

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
rm "`mkp_file'.dta"


* MERGE cbsg and mkp datasets by hhid. merge 1-to-1
use "`cbsg_file'_noduphhid.dta", clear
merge m:m hhid using "`mkp_file'_noduphhid.dta"
local date = subinstr("`c(current_date)'", " " , "", .)
rename _merge match_bw_cbsg_mkp
* ENUMERATOR variables
gen enum_name1 = enum_name1_cbsg if enum_name1_cbsg != "" & enum_name1_cbsg == enum_name1_mkp & enum_name1_cbsg != enum_name2_cbsg
gen enum_name2 = enum_name2_cbsg if enum_name2_cbsg != "" & enum_name2_cbsg == enum_name2_mkp & enum_name1_cbsg != enum_name2_cbsg
replace enum_name1 = enum_name1_cbsg if enum_name1_cbsg != "" & enum_name1 == "" & Q1p == 1
replace enum_name1 = enum_name1_cbsg if enum_name1_cbsg == enum_name2_mkp & enum_name2_cbsg == enum_name1_mkp & enum_name1 == ""
replace enum_name1 = enum_name1_cbsg if enum_name1_mkp == "" & enum_name2_mkp == "" & enum_name1 == ""
replace enum_name1 = enum_name1_mkp if enum_name1_cbsg == "" & enum_name2_cbsg == "" & enum_name1 == ""
* MERGE with supervisors
merge m:1 enum_name1 using "$baseline/Data/master enumerators list.dta"
drop if _merge==2
drop _merge
rename enum_supervisor supervisor_id
* SAVE
compress
save "clean_merge_data__`date'.dta", replace
rm "`cbsg_file'_noduphhid.dta"
rm "`mkp_file'_noduphhid.dta"


	* use cleaned and merged dataset
cd "$baseline/Data/"
use "clean_merge_data__`date'.dta", clear

	*use "clean_merge_data__14Sep2018.dta", clear
* MERGE with sampling frame to check how often the household selected was part of intended sample
merge 1:1 hhid using "sampling frame.dta"
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
	11 "Both survey's complete", modify;
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
	gen survey_status_`date' = .
	
	* Household not located
	replace survey_status_`date' = 1 if Q1f1 == 0 
	
	* Respondent unavailable, need to revisit
	replace survey_status_`date' = 2 if inlist(Q1l_consent, 0, .) & inlist(Q1l_whynot, 1, 2) // 1) CBSG respondent is not currently present, but will return; 2) Family is busy and we must return another time; 3) CBSG member is not present, and will not return in the following week
	
	* No consent/respondent not present long-term
	replace survey_status_`date' = 3 if inlist(Q1l_consent, 0, .) & inlist(Q1l_whynot, 3, 4, .o) // 4) General refusal
	
	* CBSG survey incomplete, MKP survey not started
	replace survey_status_`date' = 4 if Q1l_consent == 1 & Q10cbsg89 == . & (inlist(Q1r1, 0, .) & missing(Q1p)) & Q1r3 == 0
	
	* CBSG survey complete, MKP survey not started
	replace survey_status_`date' = 5 if Q1l_consent == 1 & Q10cbsg89 != . & (inlist(Q1r1, 0, .) & missing(Q1p)) & Q1r3 == 0
	
	* MKP survey incomplete, CBSG survey not uploaded
	replace survey_status_`date' = 6 if match_bw_cbsg_mkp == 2 & missing(Q10m6_mkp)

	* MKP survey complete, CBSG survey not uploaded
	replace survey_status_`date' = 7 if match_bw_cbsg_mkp == 2 & !missing(Q10m6_mkp)
	replace survey_status_`date' = 7 if Q1l_consent == 1 & Q10cbsg89 == . & inlist(1, Q1r1, Q1r3) & Q1p != . & Q10m6_mkp != .

	* Both surveys incomplete
	replace survey_status_`date' = 8 if Q1l_consent == 1 & Q10cbsg89 == . & (((Q1r3 == 1 | Q1r1 == 1) & missing(Q10m6_mkp)) | Q1p==1)
	replace survey_status_`date' = 8 if match_bw_cbsg_mkp==3 & Q1p==. & Q2a_cbsg==. & cbsg=="" & Q10cbsg89==. & Q1r3==. & Q1r1==.
	
	* CBSG survey incomplete, MKP survey not uploaded
	replace survey_status_`date' = 9 if Q1l_consent == 1 & Q10cbsg89 == . & match_bw_cbsg_mkp == 1
	
	* CBSG survey complete, MKP survey incomplete
	replace survey_status_`date' = 10 if Q1l_consent == 1 & Q10cbsg89 != . & (Q1r3 == 1 | Q1r1 == 1) & missing(Q10m6_mkp)
	
	* Both surveys complete
	replace survey_status_`date' = 11 if Q1l_consent == 1 & Q10cbsg89 != . & ((Q1p==1 & Q10m6_cbsg != .) | (Q1p!=1 & (Q1r3 == 1 | Q1r1 == 1) & !missing(Q10m6_mkp)))
	*replace survey_status_`date' = 11 if Q1l_consent == 1 & Q10cbsg89 == . & Q1p!=1 & (Q1r3 == 1 | Q1r1 == 1) & Q2a_mkp!=. & Q5m7_mkp!=. & Q10m6_mkp!=.
	
	lab val survey_status_`date' survey_status
	tab survey_status_`date', miss
	
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
	gen err_red_qui_intw_cbsg = (interview_length_cbsg <= 30) if survey_status_`date' == 11
	gen err_red_qui_intw_mkp = (interview_length_mkp <= 20) if survey_status_`date' == 11
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
	
	* (red) error 2: Number of household members differs between MKP and CBSG surveys by more than 1
	gen Q2a = Q2a_cbsg if Q2a_cbsg == Q2a_mkp & !missing(Q2a_cbsg) & Q1p != 1
	replace Q2a = Q2a_cbsg if missing(Q2a_mkp) & !missing(Q2a_cbsg)
	replace Q2a = Q2a_mkp if missing(Q2a_cbsg) & !missing(Q2a_mkp)
	replace Q2a = Q2a_cbsg if Q2a_cbsg == Q2a_mkp & Q1p==1
	gen err_red_numhhmem = ((Q1n+1)<Q2a | (Q1n-1)>Q2a) if !missing(Q2a) & !missing(Q1n) & Q1p!=1
	note err_red_numhhmem: Number of household members differs between MKP and CBSG surveys by more than 1
	note err_red_numhhmem: Questions used: Q1n Q2a_cbsg Q2a_mkp
	lab var err_red_numhhmem "Number of household members differs between MKP and CBSG surveys by more than 1"
	
	* (red) error 2: check if number of household (Q2a) = names provided in the roster (Q2b)
	foreach i of varlist Q2b* {
		replace `i' = "" if inlist(`i', "0", "00", "No", "no")
	}
	egen length_names_hh_members = rownonmiss(Q2b*), s
	replace length_names_hh_members = length_names_hh_members/2 if Q2a_cbsg == Q2a_mkp & Q1p == 1
	gen err_red2_hh_members = (length_names_hh_members != Q2a) if !missing(length_names_hh_members) & !missing(Q2a)
	note err_red2_hh_members: Number of hh members and number of name entries are unequal
	note err_red2_hh_members: Questions used: Q2b-questions Q2a_cbsg Q2a_mkp
	lab var err_red2_hh_members "Number of hh members and number of name entries are unequal"

	* (red) error 3: Verify total hh income from past 30 days (Q2_estimate): reported value was >0 & <1000
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

*>>>> this is redundant because if Q1p!=1 then Q5a_cbsg==. and Q5a_mkp!=., if Q1p==1 then Q5a_cbsg!=. and Q5a_mkp!=.
	* (red) error 6: inconsistent response about type of dwelling
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
	qui ds Q*, has(type numeric)
	percentmatch `r(varlist)', gen(pmatch) idvar(hhid) matchedid(matched_hhid)
		preserve
		keep hhid supervisor_id
		rename (hhid supervisor_id) (matched_hhid match_supervisor_id)
		save "near_dup_matchedid.dta", replace
		restore
	merge m:1 matched_hhid using "near_dup_matchedid.dta", gen(xxx) keep(master match)
	gen err_red2_close_match = (pmatch > .9 & supervisor_id == match_supervisor_id)
	note err_red2_close_match: More than 90% similarity in response to questions within the same supervisor, which is considered very high
	note err_red2_close_match: Questions used: All variables
	lab var err_red2_close_match "More than 90% similarity in response to questions within the same supervisor, which is considered very high"
	
	* (red) error 9: CBSG report self (Q1p==1) and MKP questionnaire is filled
	gen err_red_mkp_nt_missing = (Q1p == 1 & match_bw_cbsg_mkp == 3) if Q5m9_mkp != .
	note err_red_mkp_nt_missing: CBSG report self (Q1p==1) and MKP questionnaire is filled
	note err_red_mkp_nt_missing: Questions used: Q1p and MKP Questionnaire
	lab var err_red_mkp_nt_missing "CBSG report self (Q1p==1) and MKP questionnaire is filled"
	
	* (red) error 10: CBSG doesn't report self (Q1p != 1) and MKP q're is missing
	gen err_red_mkp_missing = (Q1p != 1 & match_bw_cbsg_mkp != 3)
	note err_red_mkp_missing: CBSG doesn't report self (Q1p != 1) and MKP q're is missing
	note err_red_mkp_missing: Questions used: Q1p and MKP Questionnaire
	lab var err_red_mkp_missing "CBSG doesn't report self (Q1p != 1) and MKP q're is missing"
	
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
	save "baseline/post checks data/sweep_hh_level_data__`date'.dta", replace
	
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
	local date = subinstr("`c(current_date)'", " " , "", .)
	cd "$baseline/Data/"
	use "baseline/post checks data/sweep_hh_level_data__`date'.dta", clear
	cd "$baseline/"
	cap mkdir "Reports"
	cap mkdir "Reports/Overview"
	cap log close
	
	* Generate variables for number of target interviews and number of completed interviews (status==11)
	preserve
	use "data/sampling frame.dta"
	egen target_num_of_intvw = count(order_priority) if order_priority==1, by(district)
	collapse target_num_of_intvw, by(district)
	tempfile sampleframe
	save "`sampleframe'"
	restore
	merge m:1 district using "`sampleframe'", gen(aggregate_sf_merge)
	egen compl_num_of_intvw = count(district) if aggregate_sf_merge==3 & survey_status_19Sep2018 == 11, by(district)
	
	
	*gen gender = 
	
	
	log using "Reports/Overview/Overview__`date'.smcl", replace

	***********************STATUS OF SURVEYS***************************
	*OVERALL
	
	*Survey Status
	tab survey_status_`date' if aggregate_sf_merge==3, miss
	
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
	table survey_status_`date' order_priority
	
	*Duplicate hhid in CBSG data
	list hhid dup_hhid_cbsg if dup_hhid_cbsg > 1 & !missing(dup_hhid_cbsg)
	
	*Duplicate hhid in MKP data
	list hhid dup_hhid_mkp if dup_hhid_mkp > 1 & !missing(dup_hhid_mkp)
	
	*Consent
	tab Q1l_consent
	
	*List all errors
	foreach err of varlist err_red* {
		qui sum `err' if !missing(`err') & survey_status_`date' == 11, detail
		local `v'_round = 100*round(`r(mean)', .01)
		local `v'_lab = "``err'[note1]'"
		*local `v'_lab: var lab `err'
		di "(RED) ``v'_round'% errors: ``v'_lab' -- ``err'[note2]'"
	}
	foreach err of varlist err_yellow_* {
		qui sum `err' if !missing(`err') & survey_status_`date' == 11, detail
		local `v'_round = 100*round(`r(mean)', .01)
		local `v'_lab = "``err'[note1]'"
		*local `v'_lab: var lab `err'
		di "(YELLOW) ``v'_round'% errors: ``v'_lab' -- ``err'[note2]'"
	}
	
	*Relationship between mkp and cbsg member
	tab Q1p if survey_status_`date' == 11, miss
	
	*Number of Household Members
	sum Q2a if survey_status_`date' == 11, detai
	
	*During the last 12 MONTHS did you always have enough food for your household?
	tab Q4c if survey_status_`date' == 11, miss
	
	*In the last 7 days, did you work for a wage, salary, commission or any payment in kind; including doing paid domestic work or paid farm work even if for one hour?
	tab Q6a if survey_status_`date' == 11, miss
	
	*In the last 7 days, did you run a business of any size for yourself or the household or with partners, even if for one hour?
	tab Q6b if survey_status_`date' == 11, miss
	
	*In the last 7 days, did you help in any kind of business run by this household, even if for one hour?
	tab Q6c if survey_status_`date' == 11, miss
	
	*In the last 7 days, did you work as a paid or unpaid apprentice even if just for one hour?
	tab Q6d if survey_status_`date' == 11, miss
	
	*In the last 7 days, did you work on your household's farm or work with livestock or poultry, even if for one hour?
	tab Q6e if survey_status_`date' == 11, miss
	
	*Although you did not work last week, do have work (any of activities above) from which you were temporarily absent?
	tab Q6f if survey_status_`date' == 11, miss
	
	*Were you involved in any of the following economic activities to contribute to earning money for yourself OR YOUR FAMILY in the past 12 months?
	mrtab Q6g1_* if survey_status_`date' == 11, poly sort des includemissing
	
	log close
	translate "Reports/Overview/Overview__`date'.smcl" "Reports/Overview/Overview__`date'.pdf", replace

	*=============================================================
	*R2. Generate one report per supervisor
	*=============================================================
	cap mkdir "Reports/By Supervisor"
	cap mkdir "Reports/By Supervisor/`date'"
	
levelsof supervisor_id, local(uniq_supervisor)

foreach i of local uniq_supervisor {
	
	preserve
	keep if supervisor_id == "`i'"
	log using "Reports/By Supervisor/`date'/Report_`i'_`date'.smcl", replace
	
	di ""
	di "*****************************************************************"
	di "**************** STATUS OF SURVEYS BY SUPERVISOR ****************"
	di "*****************************************************************"
	
	fre survey_status_`date'
	list hhid survey_status_`date' if survey_status_`date' != 11
	
	di ""
	di "*****************************************************************"
	di "**************** RED ERRORS : CALL BACK REQUIRED ****************"
	di "*****************************************************************"
	
	foreach err of varlist err_red_* {
		local `v'_lab = "``err'[note1]'"
		*local `v'_lab: var lab `err'
		qui sum `err' if survey_status_19Sep2018 == 11 & aggregate_sf_merge==3
		if (`r(mean)' > 0) {
			di "(RED): ``v'_lab': List of all hhid"
			list hhid if `err'==1 & survey_status_`date' == 11
		}
	}
	
	di "(RED): `err_red2_close_match[note1]': List of all hhid"
	list hhid matched_hhid pmatch if err_red2_close_match & survey_status_`date' == 11
	
	di "(RED): `err_red2_hh_members[note1]': List of all hhid"
	list hhid length_names_hh_members Q2a if err_red2_hh_members & survey_status_`date' == 11
	
	di ""
	di "*****************************************************************"
	di "************* YELLOW ERRORS : CALL BACK NOT REQUIRED ************"
	di "*****************************************************************"
	
	foreach err of varlist err_yellow_* {
		local `v'_lab = "``err'[note1]'"
		*local `v'_lab: var lab `err'
		qui sum `err' if survey_status_19Sep2018 == 11 & aggregate_sf_merge==3
		if (`r(mean)' > 0) {
			di "(YELLOW): ``v'_lab': List of all hhid"
			list hhid if `err'==1 & survey_status_`date' == 11
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
		qui sum error_red_dummy if !missing(error_red_dummy) & survey_status_`date' == 11 & enum_name1 == "`enum'"
		if (`r(mean)' > 0) {
			
			di "ENUMERATOR: `enum'"
			foreach err of varlist err_red_* {
				
				qui sum `err' if !missing(`err') & survey_status_`date' == 11 & enum_name1 == "`enum'"
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
	translate "Reports/By Supervisor/`date'/Report_`i'_`date'.smcl" "Reports/By Supervisor/`date'/Report_`i'_`date'.pdf", replace
	
	restore
	}

	

	
