*   ========================================
* SWEEP Baseline
* Do file to check the quality of data
* Author: Masood and Smita
* July 2018
*   ========================================
*
	*   ========================================
	*   Global Directory
	*   ========================================
	clear all
	
	if "$user"=="Masood" {
			global mystart "C:\Users\"
			}
	if "$user"=="Smita" {
			global mystart "C:\Users\"
			}	
	if "$user"=="Virginia" {
			global mystart "C:\Users\"
			}
	if "$user"=="Shubha" {
			global mystart "C:\Users\"
			}		
	
	local date = subinstr("`c(current_date)'", " " , "", .)
	global baseline "$mystart/"
	global raw="$baseline/raw data"
	global report="$baseline/report"
	global clean="$baseline/post checks data"
	*=============================================================
	*0. Merge MKP and CBSG Participant survey data, such that each row corresponds to one hhid
	*=============================================================
	
	* assuming possibility of multiple rows for CBSG and one row for MKP respondents in each hhid


	* import raw CBSG data (csv format)
local cbsg_raw_data "cbsg_subset__`date'"
import delimited "~/Dropbox/SWEEP shared/Baseline QC Reports/Data/`cbsg_raw_data'.csv", varnames(1) case(preserve) encoding(utf8) clear
	* cleans, labels, and prepares Stata file for CBSG data
do "~/Dropbox/SWEEP shared/Baseline QC Reports/Do-files/Other do-files/1 CBSG cleaning and labelling.do"
	* set directory
cd "~/Dropbox/SWEEP shared/Baseline QC Reports/Data/"
local cbsg_file "cbsg cleaned and labelled"
	* list of variable names
describe using "`cbsg_file'.dta", varlist
local var2 `r(varlist)'


	* import raw MKP data (csv format)
local mkp_raw_data "mkp_subset__`date'"
import delimited "~/Dropbox/SWEEP shared/Baseline QC Reports/Data/`mkp_raw_data'.csv", varnames(1) case(preserve) encoding(utf8) clear
	* cleans, labels, and prepares Stata file for CBSG data
do "~/Dropbox/SWEEP shared/Baseline QC Reports/Do-files/Other do-files/2 MKP cleaning and labelling.do"
	* set directory
cd "~/Dropbox/SWEEP shared/Baseline QC Reports/Data/"
local mkp_file "mkp cleaned and labelled"
	* list of variable names
describe using "`mkp_file'.dta", varlist
local var1 `r(varlist)'


	* matching variable names in both datasets minus hhid
local same : list var2 & var1
local idlist hhid
local same : list same - idlist


	* add _cbsg and _mkp suffix to matching variables
use "`cbsg_file'.dta", clear
rename (`same') (=_cbsg)
	* In case of duplicate hhid in cbsg data, using the last record
	egen dup_hhid_cbsg = count(hhid), by(hhid)
	sort hhid start_cbsg, stable
	bys hhid: keep if _n == _N
save "`cbsg_file'_cbsg.dta", replace
use "`mkp_file'.dta", clear
rename (`same') (=_mkp)
	* In case of duplicate hhid in mkp data, using the last record
	egen dup_hhid_mkp = count(hhid), by(hhid)
	sort hhid start_mkp, stable
	bys hhid: keep if _n == _N
save "`mkp_file'_mkp.dta", replace

	* merge cbsg and mkp datasets by hhid
use "`cbsg_file'_cbsg.dta", clear
merge m:m hhid using "`mkp_file'_mkp.dta"
local date = subinstr("`c(current_date)'", " " , "", .)
save "clean_merge_data__`date'.dta", replace


	* use cleaned and merged dataset
cd "~/Dropbox/SWEEP shared/Baseline QC Reports/Data/"
use "clean_merge_data__`date'.dta", clear
	
	/*=============================================================
	*1. Code missing values
		96 (Other) => .o
		98 (Don't know) => .d
		99 (Refuse) => .r
		Possible to get ODK to insert .s to differentiate skipped values and missing values?
	*=============================================================*/
	ds, has(type numeric)
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
	1 "Household not attempted"
	2 "Survey unsuccessful, respondent unavailable" 
	3 "Survey not consented" 
	4 "CBSG survey incomplete, MKP survey not started" 
	5 "CBSG survey complete, MKP survey not started" 
	6 "MKP survey complete, CBSG survey not uploaded"
	7 "Both surveys incomplete" 
	8 "CBSG survey complete, MKP survey incomplete" 
	9 "Both survey's complete", modify;
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
	
	* Survey unsuccessful, respondent unavailable
	replace survey_status_`date' = 2 if Q1l_consent == 0 & inlist(Q1l_whynot, 1, 2, 3) // 1) CBSG respondent is not currently present, but will return; 2) Family is busy and we must return another time; 3) CBSG member is not present, and will not return in the following week

	* Survey not consented
	replace survey_status_`date' = 3 if Q1l_consent == 0 & Q1l_whynot == 4 // 4) General refusal
	
	* CBSG survey incomplete, MKP survey not started
	replace survey_status_`date' = 4 if Q1l_consent == 1 & missing(Q10cbsg89) & Q1r1 == 0 & Q1r3 == 0
	
	* CBSG survey complete, MKP survey not started
	replace survey_status_`date' = 5 if Q1l_consent == 1 & !missing(Q10cbsg89) & Q1r1 == 0 & Q1r3 == 0
	
	* MKP survey complete, CBSG survey not uploaded
	replace survey_status_`date' = 6 if missing(Q1f1) & missing(Q10cbsg89) & !missing(Q10m6_mkp)
	
	* Both surveys incomplete
	replace survey_status_`date' = 7 if Q1l_consent == 1 & missing(Q10cbsg89) & (((Q1r3 == 1 | Q1r1 == 1) & missing(Q10m6_mkp)) | Q1p==1)
	
	* CBSG survey complete, MKP survey incomplete
	replace survey_status_`date' = 8 if Q1l_consent == 1 & !missing(Q10cbsg89) & (Q1r3 == 1 | Q1r1 == 1) & missing(Q10m6_mkp)
	
	* Both surveys complete
	replace survey_status_`date' = 9 if Q1l_consent == 1 & !missing(Q10cbsg89) & ((Q1p==1 & !missing(Q10m6_cbsg)) | (Q1p!=1 & (Q1r3 == 1 | Q1r1 == 1) & !missing(Q10m6_mkp)))
	

	lab val survey_status_`date' survey_status
	tab survey_status_`date', miss
	*note that completeness of survey will not depend on all errors discovered, but on key variables
	
	*=============================================================
	*4. Data checks, Save 
	*=============================================================
	
	* (red) error 0: if start or end date-time are missing
	gen err_red_missing_datetime = (missing(start_cbsg) | missing(start_mkp) | missing(end_cbsg) | missing(end_mkp)) if _merge == 3
	replace err_red_missing_datetime = (missing(start_cbsg) | missing(end_cbsg)) if _merge == 1
	replace err_red_missing_datetime = (missing(start_mkp) | missing(end_mkp)) if _merge == 2
	lab var err_red_missing_datetime "Missing start and/or end date-time information for interviews"
	
	* (red) error 1: flag extremely fast and extremely slow surveys
	* extremely fast: <=30min for cbsg and <=20min for mkp
	* extremely slow: >=4hrs for cbsg and >=3hrs for mkp
	gen start_cbsg2 = clock(substr(start_cbsg, 1, 26), "YMD#hms"), a(start_cbsg)
	gen start_mkp2 = clock(substr(start_mkp, 1, 26), "YMD#hms"), a(start_mkp)
	gen end_cbsg2 = clock(substr(end_cbsg, 1, 26), "YMD#hms"), a(end_cbsg)
	gen end_mkp2 = clock(substr(end_mkp, 1, 26), "YMD#hms"), a(end_mkp)
	format start_cbsg2 start_mkp2 end_cbsg2 end_mkp2 %tc
	gen interview_length_cbsg = (end_cbsg2 - start_cbsg2)/60000, a(end_cbsg2) // interview length in minutes
	gen interview_length_mkp = (end_mkp2 - start_mkp2)/60000, a(end_mkp2)
	gen err_red_qui_intw_cbsg = (interview_length_cbsg <= 30)
	gen err_red_qui_intw_mkp = (interview_length_mkp <= 20)
	gen err_red_slow_intw_cbsg = (interview_length_cbsg >= 240)
	gen err_red_slow_intw_mkp = (interview_length_mkp >= 180)
	lab var err_red_qui_intw_cbsg "Length of CBSG interview is 30min or less (too short)"
	lab var err_red_qui_intw_mkp "Length of MKP interview is 20min or less (too short)"
	lab var err_red_slow_intw_cbsg "Length of CBSG interview is 4hrs or more (too long)"
	lab var err_red_slow_intw_mkp "Length of MKP interview is 3hrs or more (too long)"
	
	* (red) error 2: Number of household members differs between MKP and CBSG surveys by more than 2
	gen err_red_numhhmem = ((Q1n+2)<Q2a | (Q1n-2)>Q2a) if !missing(Q2a) & !missing(Q1n) & Q1p!=1
	lab var err_red_numhhmem "Number of household members differs between MKP and CBSG surveys by more than 2"
	
	* (red) error 3: Verify total hh income from past 30 days (Q2_estimate): reported value was >0 & <1000
	gen err_red_income_cbsg = (Q2_estimate_cbsg>0 & Q2_estimate_cbsg<1000)
	gen err_red_income_mkp = (Q2_estimate_mkp>0 & Q2_estimate_mkp<1000)
	lab var err_red_income_cbsg "Verify total hh income from past 30 days in CBSG interview (Q2_estimate): reported value was >0 & <1000"
	lab var err_red_income_mkp "Verify total hh income from past 30 days in MKP interview (Q2_estimate): reported value was >0 & <1000"

	* (yellow) error 3: multiple years of schooling but cannot read or write
	*gen err_educated_cantread_cbsg = (inrange(Q2n1_cbsg, 2, 6) & Q2l == 4 & Q2n2 > 9)
	*lab var err_educated_cantread_cbsg "CBSG member with multiple years of schooling but cannot read or write"
	
	* (yellow) error 4: inconsistent and extreme expenditures on health services and medicine
	gen err_yellow_spd_hlth_incon = ((Q4b1_cbsg + 2000) <= Q4b1_mkp | (Q4b1_cbsg - 2000) >= Q4b1_mkp) if !missing(Q4b1_cbsg) & !missing(Q4b1_mkp)
	gen err_yellow_extspd_hlth = (Q4b1_cbsg >= 500000 | Q4b1_mkp >= 500000) if !missing(Q4b1_cbsg) & !missing(Q4b1_mkp)
	lab var err_yellow_spd_hlth_incon "Inconsistent (>2000) report on healthcare expenditure b/w CBSG and MKP members"
	lab var err_yellow_extspd_hlth "Spent 500k afghani or more on healthcare, that is considered very high"
	
	* (yellow) error 5: extreme expenditures on tuition for education
	gen err_yellow_spd_educ_incons = ((Q4b2_cbsg + 2000) <= Q4b2_mkp | (Q4b2_cbsg - 2000) >= Q4b2_mkp) if !missing(Q4b2_cbsg) & !missing(Q4b2_mkp)
	gen err_yellow_extspd_educ = (Q4b2_cbsg >= 15000 | Q4b2_mkp >= 15000) if !missing(Q4b2_cbsg) & !missing(Q4b2_mkp)
	lab var err_yellow_spd_educ_incons "Inconsistent (>2000) report on education expenditure b/w CBSG and MKP members"
	lab var err_yellow_extspd_educ "Spent 15k afghani or more on education, that is considered very high"
	
	* (yellow) error 6: very old (>5years) tent
	*gen err_old_tent = (Q5a == 5 & Q5b > 5 & Q5b < .)
	*lab var err_old_tent "Dwelling type is tent and it has been constructed more than 5 years ago"
	
	* (yellow) error 6: inconsistent response about type of dwelling
	gen err_yellow_dwlng_incons = (Q5a_cbsg != Q5a_mkp) if !missing(Q5a_cbsg) & !missing(Q5a_mkp)
	lab var err_yellow_dwlng_incons "CBSG and MKP provide inconsistent response about type of dwelling"
	
	* (red) error 7: cbsg respondent saying she/he is not a member of a cbsg
	gen err_red_cbsg_notmmr = (Q7g1 == 0)
	lab var err_red_cbsg_notmmr "CBSG member saying she/he is not a member of a CBSG"
	
	* (yellow) error 8: more than 90% similarity in responses
	qui ds, has(type numeric)
	percentmatch `r(varlist)', gen(pmatch) idvar(hhid) matchedid(m_id)
	gen err_yellow_close_match = (pmatch > .9)
	lab var err_yellow_close_match "More than 90% similarity in response to questions, which is considered very high"
	
	* (yellow) error 9: CBSG report self (Q1p==1) and MKP questionnaire is filled
	gen err_yellow_mkp_nt_missing = (Q1p == 1 & _merge == 3)
	lab var err_yellow_mkp_nt_missing "CBSG report self (Q1p==1) and MKP questionnaire is filled"
	
	* (yellow) error 10: CBSG doesn't report self (Q1p != 1) and MKP q're is missing
	gen err_yellow_mkp_missing = (Q1p != 1 & _merge != 3)
	lab var err_yellow_mkp_missing "CBSG doesn't report self (Q1p != 1) and MKP q're is missing"
	
	* (yellow) Individual savings is higher than estimate group savings, indicates lack of understanding for enumerator/question
	gen err_yellow_save = (Q7k1>Q7n) if Q7k1<. & Q7k1!=99 & Q7k1!=98 & Q7n<. & Q7n!=99 & Q7n!=98
	lab var err_yellow_save "Individual savings is higher than estimate group savings, indicates lack of understanding for enumerator/question"
	
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
	
	cap mkdir "baseline"
	cap mkdir "baseline/post checks data/"
	save "baseline/post checks data/sweep_hh_level_data__`date'.dta", replace
	*save "$clean/sweep_hh_level_data.dta", replace
	
	*=============================================================
	*R1. Generate Overview report for AKF (including regional managers), Sayara, World Bank
	*=============================================================
	use "baseline/post checks data/sweep_hh_level_data__`date'.dta", clear
	cd "~/Dropbox/SWEEP shared/Baseline QC Reports/"
	*cd "~/Downloads/sweep/data/"
	cap mkdir "Reports"
	cap mkdir "Reports/Overview"
	cap log close
	
	*gen gender = 
	
	
	
	log using "Reports/Overview/Overview__`date'.smcl", replace
	*log using "$report/Overview_`date'"
	***********************STATUS OF SURVEYS***************************
	*OVERALL
	
	*Survey Status
	tab survey_status_`date', miss
	
	*Survey Status by District
	tab sfdistrict_cbsg survey_status_`date', miss
	
	*Duplicate hhid in CBSG data
	list hhid dup_hhid_cbsg if dup_hhid_cbsg > 1 & !missing(dup_hhid_cbsg)
	
	*Duplicate hhid in MKP data
	list hhid dup_hhid_mkp if dup_hhid_mkp > 1 & !missing(dup_hhid_mkp)
	
	*Consent
	tab Q1l_consent, miss
	
	*List all errors
	foreach err of varlist err_red_* {
		qui sum `err' if !missing(`err') & survey_status_`date' == 9, detail
		local `v'_round = 100*round(`r(mean)', .01)
		local `v'_lab: var lab `err'
		di "(RED) ``v'_round'% errors: ``v'_lab'"
	}
	foreach err of varlist err_yellow_* {
		qui sum `err' if !missing(`err') & survey_status_`date' == 9, detail
		local `v'_round = 100*round(`r(mean)', .01)
		local `v'_lab: var lab `err'
		di "(YELLOW) ``v'_round'% errors: ``v'_lab'"
	}
	
	*Relationship between mkp and cbsg member
	tab Q1p if survey_status_`date' == 9, miss
	
	*Number of Household Members
	tab Q2a if survey_status_`date' == 9, miss
	
	*During the last 12 MONTHS did you always have enough food for your household?
	tab Q4c if survey_status_`date' == 9, miss
	
	*In the last 7 days, did you work for a wage, salary, commission or any payment in kind; including doing paid domestic work or paid farm work even if for one hour?
	tab Q6a if survey_status_`date' == 9, miss
	
	*In the last 7 days, did you run a business of any size for yourself or the household or with partners, even if for one hour?
	tab Q6b if survey_status_`date' == 9, miss
	
	*In the last 7 days, did you help in any kind of business run by this household, even if for one hour?
	tab Q6c if survey_status_`date' == 9, miss
	
	*In the last 7 days, did you work as a paid or unpaid apprentice even if just for one hour?
	tab Q6d if survey_status_`date' == 9, miss
	
	*In the last 7 days, did you work on your household's farm or work with livestock or poultry, even if for one hour?
	tab Q6e if survey_status_`date' == 9, miss
	
	*Although you did not work last week, do have work (any of activities above) from which you were temporarily absent?
	tab Q6f if survey_status_`date' == 9, miss
	
	*Were you involved in any of the following economic activities to contribute to earning money for yourself OR YOUR FAMILY in the past 12 months?
	mrtab Q6g1_* if survey_status_`date' == 9, poly sort des includemissing
	
	log close
	translate "Reports/Overview/Overview__`date'.smcl" "Reports/Overview/Overview__`date'.pdf", replace

	
	*=============================================================
	*R2. Generate one report per supervisor
	*=============================================================
	cap mkdir "Reports/By Supervisor"
	cap mkdir "Reports/By Supervisor/`date'"
	cap drop _merge
	rename enum_name1_cbsg enum_name1
	merge m:1 enum_name1 using "~/Dropbox/SWEEP shared/Baseline QC Reports/Data/master enumerators list.dta"
	drop if _merge==2
	rename supervisor1_cbsg supervisor_id

levelsof supervisor_id, local(uniq_supervisor)

foreach i of local uniq_supervisor {
	
	preserve
	keep if supervisor_id == "`i'"
	log using "Reports/By Supervisor/`date'/Report_`i'_`date'.smcl", replace
	
	****************STATUS OF SURVEYS***************************
	*OVERALL
	tab survey_status_`date'
	
	*BY SUPERVISOR
	tab supervisor_id survey_status_`date' //district variable missing

	****************COMMON ERRORS (over 10% of households)***************************
	foreach err of varlist err_red_* {
		qui sum `err' if !missing(`err') & survey_status_`date' == 9, detail
		local `v'_round = 100*round(`r(mean)', .01)
		local `v'_lab: var lab `err'
		di "(RED) ``v'_round'% errors: ``v'_lab'"
	}
	foreach err of varlist err_yellow_* {
		qui sum `err' if !missing(`err') & survey_status_`date' == 9, detail
		local `v'_round = 100*round(`r(mean)', .01)
		local `v'_lab: var lab `err'
		di "(YELLOW) ``v'_round'% errors: ``v'_lab'"
	}
	/*
	foreach x of varlist err_* {
		qui sum `x' if !missing(`x'), detail
		if `r(mean)' >= .1 {
			local `v'_round=100*round(`r(mean)',.01)
			local `v'_lab: var lab `x'
			di "``v'_round'% errors: ``v'_lab'"
			}
		}*/
	****************ENUMERATOR TRENDS***************************
	
	****************LIST OF Households requiring callbacks***************************
	
	
	log close
	restore
	}
*/
	

	
