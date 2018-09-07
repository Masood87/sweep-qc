cap note start: start of interview date and time
cap note end: end of interview date and time
cap note hhid: Enter hhid of the household you plan to survey
cap note sfprovince: Pre-filled: Province
cap note sfdistrict: Pre-filled: District
cap note sfcdc: Pre-filled: CDC
cap note sfvillage: Pre-filled: Village
cap note sfcbsg_resp: Pre-filled: Name of CBSG member/respondent
cap note sfcbsg: Pre-filled: Name of CBSG
cap note sfnumber1: Pre-filled: Mobile Number
cap note sfnumber2: Pre-filled: Alt Mobile
cap note sfnumber3: Pre-filled: Alt Mobile 2
cap note note_hhid: HHID: ${hhid}
cap note note_sfcbsg_resp: CBSG participant: ${sfcbsg_resp}
cap note note_sfprovince: Province: ${sfprovince}
cap note note_sfdistrict: District: ${sfdistrict}
cap note note_sfcdc: CDC: ${sfcdc}
cap note note_sfvillage: Village: ${sfvillage}
cap note note_sfcbsg_name: Name of CBSG: ${sfcbsg}
cap note note_sfnumber1: Mobile number: ${sfnumber1}
cap note note_sfnumber2: Alt mobile number: ${sfnumber2}
cap note note_sfnumber3: 2nd Alt mobile number: ${sfnumber3}
cap note enum_name1: Name of Enumerator for CBSG respondent survey
cap note enum_name2: Name of Enumerator for MKP survey
cap note Q1ee: Location type
cap note Q1f1: Field Officer do not read: have you located the household?
cap note Q1f2: Why not?
cap note Q1f2_other: Other Specify other reason
cap note Q1l_consent: To CBSG respondent: We are a team working with the Aga Khan Foundation and the World Bank. We are working on a project concerned with developing local economies. The results of the survey will be important for helping design programs on local economic development for the People of Afghanistan. I would like to talk to you about this. The interview will take about 90 minutes. All the information we obtain will remain strictly confidential and your answers will never be identified. During the survey, you may refuse to answer any question or discontinue the survey at any time.  Do we have permission to proceed with the interview?
cap note Q1l_whynot: Why not?
cap note Q1l_date: When should we come back?
cap note Q1l_time: What time of day is best?
cap note mod1: 1. Introduction
cap note cdc_ver: Is ${sfcdc} the correct name of this cdc?
cap note cdc_corr: Please write name of CDC, and be careful about spelling
cap note village_ver: Is ${sfvillage} the correct name of this village?
cap note village_corr: Please write name of village, and be careful about spelling
cap note cbsg_ver: Is ${sfcbsg} the correct name of this CBSG?
cap note cbsg_corr: Please write name of CBSG, and be careful about spelling
cap note resp_ver: Is ${sfcbsg_resp} the correct name of this CBSG member?
cap note resp_corr: Please write name of CBSG member/respondent, and be careful about spelling
cap note cbsg_resp: Name of CBSG respondent
cap note cbsg: Name of CBSG that respondent belongs to
cap note Q1m1: The name of a well known member of your household
cap note Q1m2: Father's name
cap note Q1m3_0: Do you have a contact number?
cap note Q1m3: Mobile number
cap note Q1m4_0: Does anyone else in your household have a contact number?
cap note Q1m4: Q1i2 Family member mobile number
cap note Q1m5_0: Do you have an alternative contact number?
cap note Q1m5: Q1i3 Alternative mobile number
cap note Q1m_note: You must list at least one phone number for household
cap note Q1n: How many persons currently live in your household?
cap note Q1o: Who is the most knowledgable person (MKP) in your household?
cap note Q1p: What is the relationship of ${Q1o} to you?
cap note Q1p_other: Other (please Specify)?
cap note Q1r1: Q1r1 Could my colleague, ${enum_name2}, speak to ${Q1o}, while I interview you?
cap note Q1r2: Q1r2 Why not?
cap note Q1r2_other: Other (please Specify)?
cap note Q1r3: Is there ANOTHER person in the household who will know about the assets of the household, and the age, education, employment, of every household member, with whom we can speak, and who is CURRENTLY PRESENT?
cap note Q1r4: What is the name of this individual?
cap note Q1r5: What is the relationship of ${Q1r4} to you, ${cbsg_resp}?
cap note Q1r5_other: Other (please Specify)?
cap note Q1s01: Does ${Q1o} have a contact number?
cap note Q1s1: What is ${Q1o} 's telephone number?
cap note Q1s02: Does ${Q1r4} have a contact number?
cap note Q1s2: What is ${Q1r4} 's telephone number?
cap note Q1t_date: When will ${Q1o} be back?
cap note Q1t_time: What time of day is best?
cap note mod2: 2. HH Roster
cap note note1: We would like to start with some information about the people who usually live and sleep in this household, starting with the head of the household. Please mention all people who usually stay here, including babies and infants, and people who are not immediate kin.
cap note note2: A household is defined as a group of people who normally live together and eat meals together, and have been doing so for at least 6 of the 12 months preceding the interview. Therefore, a member of your household is defined on the basis of the usual place of residence, and short term guests are not included. PLEASE NOTE that in this list, The following categories of people are considered as household members even though they have lived for less than 6 months in the past 12 months: (i) Infants who are less than 6 months old (ii) Newly married who have been living together for less than 6 months (iii) Students and seasonal workers who have not been living in or as part of another household, and (iv) Other persons living together for less than 6 months but who are expected to live in the household permanently (or for a longer duration). Servants, farm workers and other such individuals who live and take meals with the household are to be identified as household members, even though they may not have blood relationship with the respondent.
cap note Q2a: According to this definition of a household, how many individuals live in the household?
cap note members: Roster 1: List of members
cap note Q2_memberid: ID for household member

forv i = 1/27 {
	cap note Q2b_`i': Name of household member `i'
}

cap note Q2c: Is this member usually present in the household (and not part of another household)?
cap note Q2c_other: Other (please Specify)?
cap note Q2d: What is ${Q2b}'s age in completed years?
cap note Q2c_month: What is ${Q2b}'s age in completed Months?
cap note members: Roster 1 hh members
cap note det: Roster 2
cap note roster2_res: Roster residents
cap note rost2: Roster 2: Details
cap note roster2_name: Roster2 name
cap note roster2_age: Roster2 age
cap note roster2note: I will now ask you a questions about ${roster2_name}, age ${roster2_age}
cap note Q2g: What is the relationship of ${roster2_name} to you?
cap note Q2g_other: Other (please Specify)?
cap note Q2h: Is ${roster2_name} male or female?
cap note Q2i: What is the marital status of ${roster2_name}?
cap note Q2j: Does ${roster2_name} have a tazkira?
cap note Q2k1: Did ${roster2_name} reside outside of the home for more than 3 months of the past 12 months?
cap note Q2k2: Where does ${roster2_name} go?
cap note Q2k2_other: Other (please Specify)?

forv i = 1/27 {
	cap note Q2l_`i': Can ${roster2_name_`i'} read and write?
}

cap note Q2m: Did ${roster2_name} ever attend formal school? (including formal Islamic school)

forv i = 1/27 {
	cap note Q2n1_`i': What is the highest grade in which ${roster2_name_`i'} was enrolled?
}

cap note Q2n1_error: You stated that ${roster2_name} never attended school, but then indicated that ${roster2_name} attended some schooling in the next question. Please clarify

forv i = 1/27 {
	cap note Q2n2_`i': Enter highest grade level COMPLETED
}

cap note Q2q: In the past SEVEN DAYS how many TOTAL HOURS did ${roster2_name} work on household chores, or tending to children, cooking, fetching water, or other household chores?
cap note Q2r: In the past SEVEN DAYS, did ${roster2_name} do any work for pay, for profit, or for family gain, INCLUDING farm work or tending livestock, or poultry, or any occasional work, EVEN for one hour?
cap note Q2s: Although ${roster2_name} did not work last week, does he/she have work from which he/she was temporarily absent?
cap note Q2t: What are the main reasons that ${roster2_name} did not work in the last seven days?
cap note Q2u: What kinds of work (paid or unpaid) was ${roster2_name}'s biggest sources of income over the past 12 MONTHS (Select all that apply in the past 12 MONTHS, up to 3)
cap note Q2u_other: Other (please Specify)?
cap note Q2v: What is the total amount in cash, services or goods ${roster2_name} received for ALL OF THESE economic activities in the last 30 DAYS, if any? (in case of cash include any bonuses, commissions, allowances or tips)
cap note rost_act: Roster activities
cap note Q2_roster_act_id: Roster activity ID
cap note Q2_roster_act_name: Roster activity label
cap note Q2w1: I will now ask you 5 questions about (${Q2_roster_act_name}), the activity that you mentioned above. How many DAYS did ${roster2_name} work in this activity during the past SEVEN DAYS?
cap note Q2w2: How many actual HOURS PER DAY, on average, did ${roster2_name} work on average on this activity  (${Q2_roster_act_name}) during the past SEVEN DAYS?
cap note Q2w3: Did ${roster2_name}'s work on this activity  (${Q2_roster_act_name}) take place INSIDE the household or household land?
cap note Q2w4: Did ${roster2_name} receive any payment in cash or in-kind for their work on ${Q2_roster_act_name}
cap note Q2w5: What is ${roster2_name} relationship's with this employer for their work in (${Q2_roster_act_name})?
cap note Q2w5_other: Other (please Specify)?
cap note rost2: Roster 2 questions
cap note Q2_estimate: Please estimate the total income for your entire household combined over the last 30 DAYS
cap note Q2x_note: In the past 12 MONTHS, how much has your household received from the following sources
cap note Q2x1: remittances from those who do not live in the household?
cap note Q2x2: income from lending funds to others?
cap note Q2x3: rental income?
cap note Q2x4: income from pensions?
cap note Q2x5: income from zakat?
cap note Q2x6: other income not yet discussed?
cap note roster2_name1: Roster2 name1
cap note roster2_name2: Roster2 name2
cap note roster2_name3: Roster2 name3
cap note roster2_name4: Roster2 name4
cap note roster2_name5: Roster2 name5
cap note roster2_name6: Roster2 name6
cap note roster2_name7: Roster2 name7
cap note roster2_name8: Roster2 name8
cap note roster2_name9: Roster2 name9
cap note roster2_name10: Roster2 name10
cap note roster2_name11: Roster2 name11
cap note roster2_name12: Roster2 name12
cap note roster2_name13: Roster2 name13
cap note roster2_name14: Roster2 name14
cap note roster2_name15: Roster2 name15
cap note roster2_name16: Roster2 name16
cap note roster2_name17: Roster2 name17
cap note roster2_name18: Roster2 name18
cap note roster2_name19: Roster2 name19
cap note roster2_name20: Roster2 name20
cap note roster2_age1: Roster2 name1
cap note roster2_age2: Roster2 name2
cap note roster2_age3: Roster2 name3
cap note roster2_age4: Roster2 name4
cap note roster2_age5: Roster2 name5
cap note roster2_age6: Roster2 name6
cap note roster2_age7: Roster2 name7
cap note roster2_age8: Roster2 name8
cap note roster2_age9: Roster2 name9
cap note roster2_age10: Roster2 name10
cap note roster2_age11: Roster2 name11
cap note roster2_age12: Roster2 name12
cap note roster2_age13: Roster2 name13
cap note roster2_age14: Roster2 name14
cap note roster2_age15: Roster2 name15
cap note roster2_age16: Roster2 name16
cap note roster2_age17: Roster2 name17
cap note roster2_age18: Roster2 name18
cap note roster2_age19: Roster2 name19
cap note roster2_age20: Roster2 name20
cap note mod3: 3. HH Dynamics
cap note marstatus: What is your marital status?
cap note parstatus: Do you have children?
cap note Q3a0: I will now ask you a few questions about household decision making
cap note Q3a_list: list of members
cap note Q3a: The head of the household is a person among the group of householders who is regarded/assigned as the head of the household and generally makes decisions in the household. Which individual listed is the head of household?
cap note Q3a_name1: ${roster2_name1}, age ${roster2_age1}
cap note Q3a_name2: ${roster2_name2}, age ${roster2_age2}
cap note Q3a_name3: ${roster2_name3}, age ${roster2_age3}
cap note Q3a_name4: ${roster2_name4}, age ${roster2_age4}
cap note Q3a_name5: ${roster2_name5}, age ${roster2_age5}
cap note Q3a_name6: ${roster2_name6}, age ${roster2_age6}
cap note Q3a_name7: ${roster2_name7}, age ${roster2_age7}
cap note Q3a_name8: ${roster2_name8}, age ${roster2_age8}
cap note Q3a_name9: ${roster2_name9}, age ${roster2_age9}
cap note Q3a_name10: ${roster2_name10}, age ${roster2_age10}
cap note Q3a_name11: ${roster2_name11}, age ${roster2_age11}
cap note Q3a_name12: ${roster2_name12}, age ${roster2_age12}
cap note Q3a_name13: ${roster2_name13}, age ${roster2_age13}
cap note Q3a_name14: ${roster2_name14}, age ${roster2_age14}
cap note Q3a_name15: ${roster2_name15}, age ${roster2_age15}
cap note Q3a_name16: ${roster2_name16}, age ${roster2_age16}
cap note Q3a_name17: ${roster2_name17}, age ${roster2_age17}
cap note Q3a_name18: ${roster2_name18}, age ${roster2_age18}
cap note Q3a_name19: ${roster2_name19}, age ${roster2_age19}
cap note Q3a_name20: ${roster2_name20}, age ${roster2_age20}
cap note Q3b: Does the head of household do any of the following (select all that apply)?
cap note Q3b_other: Other (please Specify)?
cap note Q3c_list: list of members
cap note Q3c: Which individual listed is you?
cap note Q3c_name1: ${roster2_name1}, age ${roster2_age1}
cap note Q3c_name2: ${roster2_name2}, age ${roster2_age2}
cap note Q3c_name3: ${roster2_name3}, age ${roster2_age3}
cap note Q3c_name4: ${roster2_name4}, age ${roster2_age4}
cap note Q3c_name5: ${roster2_name5}, age ${roster2_age5}
cap note Q3c_name6: ${roster2_name6}, age ${roster2_age6}
cap note Q3c_name7: ${roster2_name7}, age ${roster2_age7}
cap note Q3c_name8: ${roster2_name8}, age ${roster2_age8}
cap note Q3c_name9: ${roster2_name9}, age ${roster2_age9}
cap note Q3c_name10: ${roster2_name10}, age ${roster2_age10}
cap note Q3c_name11: ${roster2_name11}, age ${roster2_age11}
cap note Q3c_name12: ${roster2_name12}, age ${roster2_age12}
cap note Q3c_name13: ${roster2_name13}, age ${roster2_age13}
cap note Q3c_name14: ${roster2_name14}, age ${roster2_age14}
cap note Q3c_name15: ${roster2_name15}, age ${roster2_age15}
cap note Q3c_name16: ${roster2_name16}, age ${roster2_age16}
cap note Q3c_name17: ${roster2_name17}, age ${roster2_age17}
cap note Q3c_name18: ${roster2_name18}, age ${roster2_age18}
cap note Q3c_name19: ${roster2_name19}, age ${roster2_age19}
cap note Q3c_name20: ${roster2_name20}, age ${roster2_age20}
cap note Q3d_list: list of members
cap note Q3d: Which individual(s) listed is your spouse?
cap note Q3d_na: Do not have a spouse
cap note Q3d_name1: ${roster2_name1}, age ${roster2_age1}
cap note Q3d_name2: ${roster2_name2}, age ${roster2_age2}
cap note Q3d_name3: ${roster2_name3}, age ${roster2_age3}
cap note Q3d_name4: ${roster2_name4}, age ${roster2_age4}
cap note Q3d_name5: ${roster2_name5}, age ${roster2_age5}
cap note Q3d_name6: ${roster2_name6}, age ${roster2_age6}
cap note Q3d_name7: ${roster2_name7}, age ${roster2_age7}
cap note Q3d_name8: ${roster2_name8}, age ${roster2_age8}
cap note Q3d_name9: ${roster2_name9}, age ${roster2_age9}
cap note Q3d_name10: ${roster2_name10}, age ${roster2_age10}
cap note Q3d_name11: ${roster2_name11}, age ${roster2_age11}
cap note Q3d_name12: ${roster2_name12}, age ${roster2_age12}
cap note Q3d_name13: ${roster2_name13}, age ${roster2_age13}
cap note Q3d_name14: ${roster2_name14}, age ${roster2_age14}
cap note Q3d_name15: ${roster2_name15}, age ${roster2_age15}
cap note Q3d_name16: ${roster2_name16}, age ${roster2_age16}
cap note Q3d_name17: ${roster2_name17}, age ${roster2_age17}
cap note Q3d_name18: ${roster2_name18}, age ${roster2_age18}
cap note Q3d_name19: ${roster2_name19}, age ${roster2_age19}
cap note Q3d_name20: ${roster2_name20}, age ${roster2_age20}
cap note Q3e_list: list of members
cap note Q3e: Which individual(s) listed are your biological children?
cap note Q3e_na: Do not have any children
cap note Q3e_name1: ${roster2_name1}, age ${roster2_age1}
cap note Q3e_name2: ${roster2_name2}, age ${roster2_age2}
cap note Q3e_name3: ${roster2_name3}, age ${roster2_age3}
cap note Q3e_name4: ${roster2_name4}, age ${roster2_age4}
cap note Q3e_name5: ${roster2_name5}, age ${roster2_age5}
cap note Q3e_name6: ${roster2_name6}, age ${roster2_age6}
cap note Q3e_name7: ${roster2_name7}, age ${roster2_age7}
cap note Q3e_name8: ${roster2_name8}, age ${roster2_age8}
cap note Q3e_name9: ${roster2_name9}, age ${roster2_age9}
cap note Q3e_name10: ${roster2_name10}, age ${roster2_age10}
cap note Q3e_name11: ${roster2_name11}, age ${roster2_age11}
cap note Q3e_name12: ${roster2_name12}, age ${roster2_age12}
cap note Q3e_name13: ${roster2_name13}, age ${roster2_age13}
cap note Q3e_name14: ${roster2_name14}, age ${roster2_age14}
cap note Q3e_name15: ${roster2_name15}, age ${roster2_age15}
cap note Q3e_name16: ${roster2_name16}, age ${roster2_age16}
cap note Q3e_name17: ${roster2_name17}, age ${roster2_age17}
cap note Q3e_name18: ${roster2_name18}, age ${roster2_age18}
cap note Q3e_name19: ${roster2_name19}, age ${roster2_age19}
cap note Q3e_name20: ${roster2_name20}, age ${roster2_age20}
cap note Q3f_list: list of members
cap note Q3f: Which individual(s) listed are currently members of any CBSGs?
cap note Q3f_na: No others are members of any CBSG
cap note Q3f_name1: ${roster2_name1}, age ${roster2_age1}
cap note Q3f_name2: ${roster2_name2}, age ${roster2_age2}
cap note Q3f_name3: ${roster2_name3}, age ${roster2_age3}
cap note Q3f_name4: ${roster2_name4}, age ${roster2_age4}
cap note Q3f_name5: ${roster2_name5}, age ${roster2_age5}
cap note Q3f_name6: ${roster2_name6}, age ${roster2_age6}
cap note Q3f_name7: ${roster2_name7}, age ${roster2_age7}
cap note Q3f_name8: ${roster2_name8}, age ${roster2_age8}
cap note Q3f_name9: ${roster2_name9}, age ${roster2_age9}
cap note Q3f_name10: ${roster2_name10}, age ${roster2_age10}
cap note Q3f_name11: ${roster2_name11}, age ${roster2_age11}
cap note Q3f_name12: ${roster2_name12}, age ${roster2_age12}
cap note Q3f_name13: ${roster2_name13}, age ${roster2_age13}
cap note Q3f_name14: ${roster2_name14}, age ${roster2_age14}
cap note Q3f_name15: ${roster2_name15}, age ${roster2_age15}
cap note Q3f_name16: ${roster2_name16}, age ${roster2_age16}
cap note Q3f_name17: ${roster2_name17}, age ${roster2_age17}
cap note Q3f_name18: ${roster2_name18}, age ${roster2_age18}
cap note Q3f_name19: ${roster2_name19}, age ${roster2_age19}
cap note Q3f_name20: ${roster2_name20}, age ${roster2_age20}
cap note Q3g: Who has the final say on Purchasing food for the family of ${cbsg_resp}
cap note Q3h: Who has the final say on Whether the family of ${cbsg_resp} may borrow funds
cap note Q3i: Who has the final say on Purchase of assets that ${cbsg_resp}'s family uses
cap note mod4: 4. Consumption
cap note Q4a: Now, imagine that you have an emergency and you need to pay AFG 2060. How possible is it that you could come up with AFG 2060 within the NEXT MONTH? Is it very possible, somewhat possible, not very possible, or not at all possible?
cap note exp3: Expenditure past 3 months
cap note Q4b0: I will now ask you about your family's expenditure. In the past 3 months, how much did your household spend on...
cap note Q4b1: Health services and medicines
cap note Q4b2: Tuition for education
cap note Q4b3: Other education expenses (uniforms, textbooks, school supplies)
cap note exp1: Expenditure past 1 month
cap note Q4b_1mo_note: In the past month, how much did your household spend on the following categories of items:
cap note Q4b4: Food at home
cap note Q4b5: Food away from home
cap note Q4b6: Grooming, cosmetics, laundry, soap, shampoo (hygiene)
cap note Q4b7: Housing rent
cap note Q4b8: Communication (phone & internet)
cap note Q4b9: Transportation
cap note Q4c: During the last 12 MONTHS did you always have enough food for your household?
cap note Q4d: Q4d For how many months in the last 12 months did you not have enough food for your household?
cap note Q4d1: In the past seven days, has there been any time when your household did not have enough food or money to buy food?
cap note food: Food
cap note Q4d_note: In the past seven days, when you did not have enough food or money…
cap note Q4d2: HOW OFTEN did anyone in your household have to: rely on less-preferred and less-expensive foods because of lack of resources?
cap note Q4d3: HOW OFTEN did anyone in your household have to:  limit portion sizes at meal times?
cap note Q4d4: HOW OFTEN did anyone in your household have to:  restrict consumption by adults in order for small children to eat?
cap note Q4d5: HOW OFTEN did anyone in your household have to:  skip meals or reduce number of meals eaten by anyone in household?
cap note diet: Diet
cap note Q4e0: I will now ask you about your family's consumption of the following food groups. How many days in the past 7 days did your entire household eat:
cap note Q4e1: Cereals (e.g. bread, wheat, rice, maize, pasta, etc.)
cap note Q4e2: Tubers (e.g. potatoes, sweet potatoes, etc.)
cap note Q4e3: Pulses and nuts (e.g. beans, lentils, peas, peanuts, etc.)
cap note Q4e4: Vegetables (e.g. onion, tomato, eggplant, cabbage, etc.)
cap note Q4e5: Fruits (e.g. water melon, apricots, grapes, raisins, etc.)
cap note Q4e6: Meat and fish of all types, eggs
cap note Q4e7: Dairy and dairy products (e.g. milk, yoghurt, krut, dogh, cheese, other milk products)
cap note Q4e8: Sugar, honey
cap note Q4e9: Oils, fats
cap note mod5: 5.Assets
cap note Q5a: What type of dwelling best describes your current dwelling?
cap note Q5a_other: Other (please Specify)?
cap note Q5b: How many years ago was this dwelling constructed?
cap note Q5c: What is the arrangement on the basis of which your household occupies this dwelling
cap note Q5other: Other (please Specify)?
cap note Q5d: If you were to purchase this dwelling today, how much would it cost?
cap note Q5e: What is the distance to this dwelling from the nearest paved road? (in meters)
cap note Q5f1: Has your household had electricity at any time in the past 30 DAYS from any of these sources: Electric grid or Government generator
cap note Q5f2: Has your household had electricity at any time in the past 30 DAYS from any of these sources: Private generator
cap note Q5f3: Has your household had electricity at any time in the past 30 DAYS from any of these sources: Community generator
cap note Q5f4: Has your household had electricity at any time in the past 30 DAYS from any of these sources: Other sources
cap note Q5g: What is the main source of heating for his house in the winter?
cap note Q5g_other: Other (please Specify)?
cap note Q5h: Which main toilet facility does your household use?
cap note Q5h_other: Other (please Specify)?
cap note Q5i: Is the toilet facility shared with other households?
cap note Q5j: What has been the main source of drinking water for your household in the past 30 days?
cap note Q5j_other: Other (please Specify)?
cap note Q5k: How many minutes does it take to walk, one way, to this main source of water in warm season?
cap note Q5l: What is the main phone service that you use?
cap note Q5l_other: Other (please Specify)?
cap note Q5m1: Do any of your household members own agricultural land or a garden plot?
cap note Q5m2: How many Jeribs of agricultural land in total does your household own?
cap note Q5m3: How many jeribs of irrigated land without garden plot did you or a member of your household own in the most recent spring cultivation season?
cap note Q5m4: If you were to sell this plot of land today, how much could you sell it for?
cap note Q5m5: How many jeribs of rain-fed land without garden plot did you or a member of your household own in the most recent spring cultivation season?
cap note Q5m6: If you were to sell this land today, how much could you sell it for?
cap note Q5m7: How many jeribs of garden plot did you or a member of your household own in the most recent spring cultivation season?
cap note Q5m8: If you were to sell this plot of land today, how much could you sell it for?
cap note Q5m9: Does your household currently own any land or buildings (do not include residential property which your household occupies or agricultural land or property used by your household which was reported above)?
cap note Q5m10: How much money would your household receive if you sold all this property today?
cap note Q5asset_intro: We will now ask about your household assets and their value
cap note Q5assets: Do you have any of the following assets?
cap note Q5assets_other: Other (please Specify)?
cap note asset: asset repeat
cap note asset_id: asset id
cap note asset_name: asset name
cap note Q5asset1_1: How many ${asset_name} does your household own today?
cap note mod6: 6. Participant Economic Activities
cap note Q6a: In the last 7 days, did you work for a wage, salary, commission or any payment in kind; including doing paid domestic work or paid farm work even if for one hour?
cap note Q6b: In the last 7 days, did you run a business of any size for yourself or the household or with partners, even if for one hour?
cap note Q6c: In the last 7 days, did you help in any kind of business run by this household, even if for one hour?
cap note Q6d: In the last 7 days, did you work as a paid or unpaid apprentice even if just for one hour?
cap note Q6e: In the last 7 days, did you work on your household's farm or work with livestock or poultry, even if for one hour?
cap note Q6f: Although you did not work last week, do have work (any of activities above) from which you were temporarily absent?

*>
cap note Q6g1_1: Were you involved in any of the following economic activities to contribute to earning money for yourself OR YOUR FAMILY in the past 12 months? Agriculture/Farm work/Vegetables/Horticulture
cap note Q6g1_2: Were you involved in any of the following economic activities to contribute to earning money for yourself OR YOUR FAMILY in the past 12 months? Raising livestock/Poultry/Bees
cap note Q6g1_3: Were you involved in any of the following economic activities to contribute to earning money for yourself OR YOUR FAMILY in the past 12 months? Wholesale trade/sales
cap note Q6g1_4: Were you involved in any of the following economic activities to contribute to earning money for yourself OR YOUR FAMILY in the past 12 months? Retail trade/sales (shopkeeping, street sales, market sales)
cap note Q6g1_5: Were you involved in any of the following economic activities to contribute to earning money for yourself OR YOUR FAMILY in the past 12 months? Food production/processing
cap note Q6g1_6: Were you involved in any of the following economic activities to contribute to earning money for yourself OR YOUR FAMILY in the past 12 months? Manufacturing (handicrafts, carpets, bricks etc)
cap note Q6g1_7: Were you involved in any of the following economic activities to contribute to earning money for yourself OR YOUR FAMILY in the past 12 months? Non-agriculture business (sewing, hairdressing,security, repairs, domestic work/child care for others)
cap note Q6g1_8: Were you involved in any of the following economic activities to contribute to earning money for yourself OR YOUR FAMILY in the past 12 months? Transportation, communication
cap note Q6g1_9: Were you involved in any of the following economic activities to contribute to earning money for yourself OR YOUR FAMILY in the past 12 months? Household Chores
cap note Q6g1_10: Were you involved in any of the following economic activities to contribute to earning money for yourself OR YOUR FAMILY in the past 12 months? Mining & Quarrying
cap note Q6g1_11: Were you involved in any of the following economic activities to contribute to earning money for yourself OR YOUR FAMILY in the past 12 months? Road construction
cap note Q6g1_12: Were you involved in any of the following economic activities to contribute to earning money for yourself OR YOUR FAMILY in the past 12 months? Construction (e.g. buildings, carpentry)
cap note Q6g1_13: Were you involved in any of the following economic activities to contribute to earning money for yourself OR YOUR FAMILY in the past 12 months? Health sector
cap note Q6g1_14: Were you involved in any of the following economic activities to contribute to earning money for yourself OR YOUR FAMILY in the past 12 months? Education sector
cap note Q6g1_15: Were you involved in any of the following economic activities to contribute to earning money for yourself OR YOUR FAMILY in the past 12 months? Finance sector (Banks, MFIs)
cap note Q6g1_16: Were you involved in any of the following economic activities to contribute to earning money for yourself OR YOUR FAMILY in the past 12 months? Public administration / Government
cap note Q6g1_17: Were you involved in any of the following economic activities to contribute to earning money for yourself OR YOUR FAMILY in the past 12 months? NGO program
cap note Q6g1_96: Were you involved in any of the following economic activities to contribute to earning money for yourself OR YOUR FAMILY in the past 12 months? Other
*<

cap note Q6g2: Please specify
cap note act: Economic Activities
cap note activity_id: activity id
cap note activity_name: activity name
cap note act_note: I will now ask you several questions about ${activity_name}
cap note Q6h1: Q6h1 What is your relationship with this employer (for ${activity_name})?
cap note Q6h1_other: Q6h1_other Other Specify
cap note Q6i: Q6i Did this activity (${activity_name}) take place inside the household or household land?
cap note Q6j: Q6j
cap note Q6j_note: Q6j1 For how long have you been engaged in this activity (${activity_name})?
cap note Q6j1: Years
cap note Q6j2: Months
cap note Q6k1: Q6k1 How many days did you work in this activity during the past 30 days?
cap note Q6k2: Q6k2 How many hours per day, on average, did <name> work on this activity during the past 30 days?
cap note Q6k2_calc: hours in last week
cap note Q6k2_check: We estimate that you worked ${Q6k2_calc} hours in the past 30 days. Does this sound correct?
cap note Q6k2_error: Enumerator, please go back and check
cap note Q6k3: Q6k3 In which seasons do you undertake this activity ${activity_name} generally?
cap note Q6k4: How frequently do you receive income for your work (on ${activity_name} )? Daily, weekly, biweekly, monthly, or upon sale of product?
cap note Q6k5: Q6k5 On average, how much do you receive in one installment
cap note Q6k6: Q6k6 How much did you receive  for your work in ${activity_name} over the past 30 DAYS (revenue-expenses)?
cap note Q6k7: Q6k7 For enumerator (Do Not Read): How confident was respondent in estimating earnings?
cap note Q6k8: Q6k8 In addition to any monetary earnings, did you receive any other types of gains from working in the past 30 DAYS (in-kind, bartering, exchange-work) for (${activity_name} )?
cap note Q6k9: Q6k9 Please estimate the monetary value of these in-kind/barter/exchange labor gains from working over the PAST 30 DAYS
cap note Q6k10: Q6k10 Who usually decides how the earnings from ${activity_name}  will be used?
cap note Q6m: Have you received any training in the past 12 months related to this activity (${activity_name})?
cap note bus_only: bus_only
cap note Q6n1: Q6n1 Do you employ others in this activity (${activity_name})?
cap note Q6n2: How many people do you employ (including household members), whether paid or unpaid, on (${activity_name})?
cap note Q6n3: Q6n3 How many of these people are paid?
cap note Q6n4: Q6n4 How many hours does the average PAID person work per week
cap note Q6n5: Q6n5 How much are they paid per hour on average?
cap note Q6n6: Q6n6 Do any other household member work in this activity (both paid and unpaid)?
cap note Q6n7: How many male household members work in this activity (both paid and unpaid)?
cap note Q6n8: How many female household members work in this activity (both paid and unpaid)?
cap note Q6n9: Total paid in labor costs
cap note Q6o0: We estimate that you paid around Af ${Q6n9} for labor costs over the past 30 days. Does this sound correct?
cap note Q6o0_note: Enumerator, go back and confirm responses on labor costs
cap note input: Cost of non-labor inputs
cap note Q6o1: Q6o1 Over the past 30 days, how much did you and your household spend on the MATERIAL INPUTS required for this activity (${activity_name})
cap note Q6o2: Q6o2 Over the past 30 days, how much did you and your household spend on the EQUIPMENT required for this activity (${activity_name})
cap note Q6o3: Q6o3 Over the past 30 days, how much did you and your household spend on the STORAGE, STORE RENTAL, UTILITIES required for this activity (${activity_name})
cap note Q6o4_calc: Q6o4 Total cost of inputs over past month
cap note Q6o5: Q6o5 We estimate that you paid Af ${Q6o4_calc} for your business (on (${activity_name}) over the past month. Does this sound correct?
cap note Q6o5_note: Enumerator, go back and confirm responses on non-labor costs
cap note Q6p: Q6p Who must approve major decisions for this particular activity, such as purchases of materials and equipment?
cap note Q6q: Q6q Which assets do you currently use for this activity (${activity_name})
cap note Q6q_other: Do you have other assets that you currently use for this activity? Please list
cap note Q6s: Q6s What durable assets (that you do not have) would allow you to expand your productivity in this activity?
cap note Q6s_other: Are there OTHER durable assets that you do not have that would allow you to EXPAND your productivity in this activity? Please list
cap note Q6t1: Q6t1: What were the 3 products you developed with the highest earnings for the household (in Agriculture/Farm work/Vegetables/Horticulture)?
cap note Q6t2: Q6t2: What were the 3 products you developed with the highest earnings for the household (in Raising livestock/Poultry/Bees)?
cap note Q6t3: Q6t3: What were the 3 products you developed with the highest earnings for the household (in Wholesale trade/sales)?
cap note Q6t4: Q6t4: What were the 3 products you developed with the highest earnings for the household (in Retail trade/sales) (shopkeeping, street sales, market sales))?
cap note Q6t5: Q6t5: What were the 3 products you developed with the highest earnings for the household (in Food production/processing)?
cap note Q6t6: Q6t6: What were the 3 products you developed with the highest earnings for the household (in Manufacturing (handicrafts, carpets, bricks etc))?
cap note Q6t7: Q6t7 What were the 3 most products you developed with the highest earnings for the household (in Non-agriculture business (sewing, hairdressing,security, repairs, domestic work/child care for others))?
cap note Q6t8: What were the 3 products you developed with the highest earnings for the household (in Transportation, communication)?
cap note Q6t_other: What other products did you develop?
cap note prod1: Product details
cap note prodid1: product id
cap note prodname1_oth: You selected: Other product from your agricultural activities. Please specify.
cap note prodname1_reg: product label if selected from list
cap note prodname1: product label
cap note inv1: inventory
cap note inventorynote1: Q6u1: How many do you currently have in inventory (${prodname1})
cap note Q6u1_t1: Number
cap note Q6u2_t1: Unit
cap note Q6u2_calc_t1a: unit label
cap note Q6u2_t1_oth: Please specify unit
cap note Q6u3_t1: How would you compare your 12 months (Sept-Aug 2017) productivity with the year before (Sept-Aug 2016) for (${prodname1})?
cap note Q6u4_t1: Do you sell ANY for cash (${prodname1})?
cap note Q6u5_t1: How many ${Q6u2_calc_t1a} did you sell in the past 30 DAYS (${prodname1})?
cap note Q6u8_t1: For what price did you sell each product (${prodname1})?
cap note Q6u9_t1: What is the value of the goods you receive in exchange for this product (${prodname1})?
cap note Q6u10_t1: Q6u10 Where are these products (${prodname1}) sold first by your business/household?
cap note Q6u10_t1_other: Other (Please Spicify)
cap note Q6u11_t1: Q6u11 Who transports these products (${prodname1}) to the point of sale?
cap note Q6u12_t1: Q6u12 Do you pay a fee for this transport of (${prodname1})?
cap note prod2: Product details
cap note prodid2: product id
cap note prodname2_oth: You selected: Other product from your (Raising livestock/Poultry/Bees) activities. Please specify.
cap note prodname2_reg: product label if selected from list
cap note prodname2: product label
cap note inv2: inventory
cap note inventorynote2: Q6u1: How many do you currently have in inventory (${prodname2})
cap note Q6u1_t2: Number
cap note Q6u2_t2: Unit
cap note Q6u2_calc_t2: unit label
cap note Q6u3_t2: Q6u3 How would you compare your 12 months (Sept-Aug 2017) productivity with the year before (Sept-Aug 2016) for (${prodname2})?
cap note Q6u4_t2: Q6u4 Do you sell ANY for cash (${prodname2})?
cap note Q6u5_t2: Q6u5 How many ${Q6u2_calc_t2} did you sell in the past 30 DAYS (${prodname2})?
cap note Q6u8_t2: Q6u8 For what price did you sell each product (${prodname2})?
cap note Q6u9_t2: Q6u9 What is the value of the goods you receive in exchange for this product (${prodname2})?
cap note Q6u10_t2: Q6u10 Where are these products (${prodname2}) sold first by your business/household?
cap note Q6u10_t2_other: Other (Please Spicify)
cap note Q6u11_t2: Q6u11 Who transports these products (${prodname2}) to the point of sale?
cap note Q6u12_t2: Q6u12 Do you pay a fee for this transport of (${prodname2})?
cap note prod3: Product details
cap note prodid3: product id
cap note prodname3_oth: You selected: Other product from your (Wholesale trade/sales) activities. Please specify.
cap note prodname3_reg: product label if selected from list
cap note prodname3: product label
cap note inv3: inventory
cap note inventorynote3: Q6u1: How many do you currently have in inventory (${prodname3})
cap note Q6u1_t3: Number
cap note Q6u2_t3: Unit
cap note Q6u2_t3_other: Other (Please Spicify)
cap note Q6u2_calc_t3: unit label
cap note Q6u3_t3: Q6u3 How would you compare your 12 months (Sept-Aug 2017) productivity with the year before (Sept-Aug 2016) for (${prodname3})?
cap note Q6u4_t3: Q6u4 Do you sell ANY for cash (${prodname3})?
cap note Q6u5_t3: Q6u5 How many ${Q6u2_calc_t3} did you sell in the past 30 DAYS (${prodname3})?
cap note Q6u8_t3: Q6u8 For what price did you sell each product (${prodname3})?
cap note Q6u9_t3: Q6u9 What is the value of the goods you receive in exchange for this product (${prodname3})?
cap note Q6u10_t3: Q6u10 Where are these products (${prodname3}) sold first by your business/household?
cap note Q6u2_t4_other: Other (Please Spicify)
cap note Q6u11_t3: Q6u11 Who transports these products (${prodname3}) to the point of sale?
cap note Q6u12_t3: Q6u12 Do you pay a fee for this transport of (${prodname3})?
cap note prod4: Product details
cap note prodid4: product id
cap note prodname4_oth: You selected: Other product from your (Retail trade/sales) activities. Please specify.
cap note prodname4_reg: product label if selected from list
cap note prodname4: product label
cap note inv4: inventory
cap note inventorynote4: Q6u1: How many do you currently have in inventory (${prodname4})
cap note Q6u1_t4: Number
cap note Q6u1_t4_other: Other (Please Spicify)
cap note Q6u2_t4: Unit
cap note Q6u2_calc_t4: unit label
cap note Q6u3_t4: Q6u3 How would you compare your 12 months (Sept-Aug 2017) productivity with the year before (Sept-Aug 2016) for (${prodname4})?
cap note Q6u4_t4: Q6u4 Do you sell ANY for cash (${prodname4})?
cap note Q6u5_t4: Q6u5 How many ${Q6u2_calc_t4} did you sell in the past 30 DAYS (${prodname4})?
cap note Q6u8_t4: Q6u8 For what price did you sell each product (${prodname4})?
cap note Q6u9_t4: Q6u9 What is the value of the goods you receive in exchange for this product (${prodname4})?
cap note Q6u10_t4: Q6u10 Where are these products (${prodname4}) sold first by your business/household?
cap note Q6u11_t4: Q6u11 Who transports these products (${prodname4}) to the point of sale?
cap note Q6u12_t4: Q6u12 Do you pay a fee for this transport of (${prodname4})?
cap note prod5: Product details
cap note prodid5: product id
cap note prodname5_oth: You selected: Other product from your (Food production/processing) activities. Please specify.
cap note prodname5_reg: product label if selected from list
cap note prodname5: product label
cap note inv5: inventory
cap note inventorynote5: Q6u1: How many do you currently have in inventory (${prodname5})
cap note Q6u1_t5: Number
cap note Q6u2_t5: Unit
cap note Q6u2_t5_other: Other (Please Spicify)
cap note Q6u2_calc_t5: unit label
cap note Q6u3_t5: Q6u3 How would you compare your 12 months (Sept-Aug 2017) productivity with the year before (Sept-Aug 2016) for (${prodname5})?
cap note Q6u4_t5: Q6u4 Do you sell ANY for cash (${prodname5})?
cap note Q6u5_t5: Q6u5 How many ${Q6u2_calc_t5} did you sell in the past 30 DAYS (${prodname5})?
cap note Q6u8_t5: Q6u8 For what price did you sell each product (${prodname5})?
cap note Q6u9_t5: Q6u9 What is the value of the goods you receive in exchange for this product (${prodname5})?
cap note Q6u10_t5: Q6u10 Where are these products (${prodname5}) sold first by your business/household?
cap note Q6u10_t5_other: Other (Please Spicify)
cap note Q6u11_t5: Q6u11 Who transports these products (${prodname5}) to the point of sale?
cap note Q6u12_t5: Q6u12 Do you pay a fee for this transport of (${prodname5})?
cap note prod6: Product details
cap note prodid6: product id
cap note prodname6_oth: You selected: Other product from your (Manufacturing) activities. Please specify.
cap note prodname6_reg: product label if selected from list
cap note prodname6: product label
cap note inv6: inventory
cap note inventorynote6: Q6u1: How many do you currently have in inventory (${prodname6})
cap note Q6u1_t6: Number
cap note Q6u2_t6: Unit
cap note Q6u2_t6_other: Other (Please Spicify)
cap note Q6u2_calc_t6: unit label
cap note Q6u3_t6: Q6u3 How would you compare your 12 months (Sept-Aug 2017) productivity with the year before (Sept-Aug 2016) for (${prodname6})?
cap note Q6u4_t6: Q6u4 Do you sell ANY for cash (${prodname6})?
cap note Q6u5_t6: Q6u5 How many ${Q6u2_calc_t6} did you sell in the past 30 DAYS (${prodname6})?
cap note Q6u8_t6: Q6u8 For what price did you sell each product (${prodname6})?
cap note Q6u9_t6: Q6u9 What is the value of the goods you receive in exchange for this product (${prodname6})?
cap note Q6u10_t6: Q6u10 Where are these products (${prodname6}) sold first by your business/household?
cap note Q6u10_t6_other: Other (Please Spicify)
cap note Q6u11_t6: Q6u11 Who transports these products (${prodname6}) to the point of sale?
cap note Q6u12_t6: Q6u12 Do you pay a fee for this transport of (${prodname6})?
cap note prod7: Product details
cap note prodid7: product id
cap note prodname7_oth: You selected: Other product from your (Non-agriculture business) activities. Please specify.
cap note prodname7_reg: product label if selected from list
cap note prodname7: product label
cap note inv7: inventory
cap note inventorynote7: Q6u1: How many do you currently have in inventory (${prodname7})
cap note Q6u1_t7: Number
cap note Q6u2_t7: Unit
cap note Q6u2_t7_other: Other (Please Spicify)
cap note Q6u2_calc_t7: unit label
cap note Q6u3_t7: Q6u3 How would you compare your 12 months (Sept-Aug 2017) productivity with the year before (Sept-Aug 2016) for (${prodname7})?
cap note Q6u4_t7: Q6u4 Do you sell ANY for cash (${prodname7})?
cap note Q6u5_t7: Q6u5 How many ${Q6u2_calc_t7} did you sell in the past 30 DAYS (${prodname7})?
cap note Q6u8_t7: Q6u8 For what price did you sell each product (${prodname7})?
cap note Q6u9_t7: Q6u9 What is the value of the goods you receive in exchange for this product (${prodname7})?
cap note Q6u10_t7: Q6u10 Where are these products (${prodname7}) sold first by your business/household?
cap note Q6u10_t7_other: Other (Please Spicify)
cap note Q6u11_t7: Q6u11 Who transports these products (${prodname7}) to the point of sale?
cap note Q6u12_t7: Q6u12 Do you pay a fee for this transport of (${prodname7})?
cap note prod8: Product details
cap note prodid8: product id
cap note prodname8_oth: You selected: Other product from your (Transportation and Communication) activities. Please specify.
cap note prodname8_reg: product label if selected from list
cap note prodname8: product label
cap note inv8: inventory
cap note inventorynote8: Q6u1: How many do you currently have in inventory (${prodname8})
cap note Q6u1_t8: Number
cap note Q6u2_t8: Unit
cap note Q6u2_t8_other: Other (Please Spicify)
cap note Q6u2_calc_t8: unit label
cap note Q6u3_t8: Q6u3 How would you compare your 12 months (Sept-Aug 2017) productivity with the year before (Sept-Aug 2016) for (${prodname8})?
cap note Q6u4_t8: Q6u4 Do you sell ANY for cash (${prodname8})?
cap note Q6u5_t8: Q6u5 How many ${Q6u2_calc_t8} did you sell in the past 30 DAYS (${prodname8})?
cap note Q6u8_t8: Q6u8 For what price did you sell each product (${prodname8})?
cap note Q6u9_t8: Q6u9 What is the value of the goods you receive in exchange for this product (${prodname8})?
cap note Q6u10_t8: Q6u10 Where are these products (${prodname8}) sold first by your business/household?
cap note Q6u10_t8_other: Other (Please Spicify)
cap note Q6u11_t8: Q6u11 Who transports these products (${prodname8}) to the point of sale?
cap note Q6u12_t8: Q6u12 Do you pay a fee for this transport of (${prodname8})?
cap note mod7: 7. Program Participation
cap note Q7a1: Q7a1 Do you have a tazkira?
cap note Q7a2: Q7a2 We would like to confirm if you have it and are using it directly. Can I see your tazkira?
cap note Q7b1: Q7b1 Has any member of your household participated in any food-for-work or food aid programmes during the past 12 months?
cap note Q7b2: Q7b2 Please estimate the value of the total amount received from this program over the past 12 months
cap note Q7c1: Q7c1 Has any member of your household participated in any cash-for-work or income generating programmes by a governmental or non-governmental organization during the past 12 months?
cap note Q7c2: Q7c2 Please estimate the value of the total amount received from this program over the past 12 months
cap note Q7d1: Q7d1 Has any member of your household participated in any cash transfer programmes by a governmental or non-governmental organization during the past 12 months?
cap note Q7d2: Q7d2 Please estimate the value of the total amount received from this program over the past 12 months
cap note Q7e: Q7e Has any member of your household received agriculture extension services in the past 12 months?
cap note Q7f1: Q7f1 Have you received any training in the past 12 months?
cap note Q7f2: Q7f2 What kind of training was it?
cap note Q7g1: Q7g1 Are you part of a community based savings group (CBSG)?
cap note Q7g_error: Please verify last response
cap note Q7g2: Q7g2 When did you join your CBSG?
cap note Q7h1: Q7h1 What is your position or role in your CBSG?
cap note Q7h2: Q7h2 Have you ever had an officer position?
cap note Q7i: Q7i How often are meetings held?
cap note Q7j1: Q7j1 How many meetings have been held by your CBSG in the past 3 months?
cap note Q7j2: Q7j2 How many CBSG meetings have you attended in the past 3 months?
cap note Q7j3: Q7j3 Calcuation
cap note Q7j4: Q7j4 What makes it difficult to attend CBSG meetings on a regular basis?
cap note Q7j4_other: Q7j4_other If other, please specify
cap note Q7j5: Q7j5 How long does it take you to travel to CBSG meetings from your home by walking (in minutes)?
cap note Q7k1: Q7k1 How much money do you have saved with your CBSG?
cap note Q7k2: Q7k2 Enumerator do not read: how confident is individual in response
cap note Q7l: Q7l How much money do you usually save per month with your CBSG, in general
cap note Q7m1: Q7m1 Have you taken any loans from your CBSG since formation?
cap note Q7m2: Q7m2 What have you used this money for?
cap note Q7m3: Q7m3 If selected 15, What type of product did you invest in?
cap note Q7m3_other: Q7m3_other Other Specify
cap note Q7m4: Q7m4 How much do you currently owe to your CBSG?
cap note Q7m_error: You stated that you have never taken a CBSG loan, but you still owe funds. Please go back and correct one response.
cap note Q7n: Q7n How much money does your CBSG have saved as a whole?
cap note Q7o: Q7o What interest rate do members have to pay if they take a loan from the CBSG?
cap note mod8: 8. Finance
cap note note_intro_mod8: Script: Now I would like to ask you about financial activities, such as savings and credit. In the following questions, we are asking about your HOUSEHOLD.
cap note Q8a: Do you have any cash funds that you have saved or set aside?
cap note Q8b: Do you, either by yourself or together with any other member of your household, currently have an account at any of the following places: a bank, a microfinance organization, or any other type of formal financial institution?
cap note Q8c1: Q8c1 Where is the money saved?
cap note Q8c1_other: Q8c1_other If Other, Please specify
cap note Q8c2: Q8c2 In total how much are your cash savings now, including funds you have saved at home, at a bank, with a savings group, or with another individual or group?
cap note Q8c3: Q8c3 In the past 12 months, has money been DEPOSITED into this/these personal account(s)? This includes cash or electronic deposits, or any time money is put into your account(s) by yourself, an employer, or another person or institution.
cap note Q8c4: Q8c4 What are you saving for? Please list every reason
cap note Q8c4_other: Q8c4_other Other Specify
cap note Q8c5: Q8c5 Do individuals outside of your family, but within your household, have access to your savings at any time?
cap note Q8d: Q8d Why don't you have a formal account?
cap note Q8e: Q8e Do you have any outstanding financial loans/ debts at present individually or with someone else?
cap note Q8e1: Q8e1 What interest rate do you pay on your largest loan?
cap note Q8e2: Q8e2 What is the value of the total outstanding financial debt for this household at present? (amount owed by the household to others)?
cap note Q8e3: Q8e3 To whom do you owe money?
cap note Q8e3_other: Q8e3_other Other Specify
cap note Q8e4: Q8e4 What has the money been used for?
cap note Q8e4_other: Q8e4_other Other Specify
cap note Q8e5: Q8e5 Why do you and other members of your household not have any outstanding loans?
cap note Q8f: Q8f Are you responsible for the debt of other household members outside of your family?
cap note Q8g: Q8g Imagine you have an emergency and you need to pay AFG 2060. From where do you think you would be able to successfully obtain a loan for this amount?
cap note Q8g_other: Q8g_other Other Specify
cap note mod9: 9. Hard Skills
cap note note_financial: I will now ask you several questions related to your financial practices
cap note Q9a1: Q9a1 Do you keep track of the money you spend and the money you get for your personal finances (household savings, personal expenditures, etc.)?
cap note Q9a2: Q9a2 How do you keep track of your personal finances?
cap note Q9b1: Q9b1 Do you keep track of the money you spend and the money you get for your business activities?
cap note Q9b2: Q9b2 How do you keep track of your business budget?
cap note Q9b3: Q9b3 Do you track your personal finances (household savings, personal expenditures, etc.) and your business finances separately?
cap note bus: Business-related hard skills
cap note note_business: I will now ask you several questions related to your business practices
cap note Q9c1: Q9c1 Over the past 3 months, have you kept track of Purchases of inputs/materials for production
cap note Q9c2: Q9c2 Over the past 3 months, have you kept track of  Purchases of business assets
cap note Q9c3: Q9c3 Over the past 3 months, have you kept track of  Payments made to employees
cap note Q9c4: Q9c4 Over the past 3 months, have you kept track of  Other administrative costs to the business (rent, fees, taxes, electricity,etc.)
cap note Q9c5: Q9c5 Over the past 3 months, have you kept track of  Sales of products
cap note Q9c6: Q9c6 Over the past 3 months, have you kept track of  Total products you have in stock
cap note Q9c7: Q9c7 Over the past 3 months, have you kept track of  Prices of equivalent products from different sources
cap note Q9c8: Q9c8 Over the past 3 months, have you kept track of  Loan payments due or debts accrued to suppliers
cap note Q9d: Q9d Do know the cost to the business of each main product you sell? This includes any costs that are required for creating the product.
cap note Q9e: Q9e Do you ever calculate profits made by your business?
cap note Q9f1: Q9f1 In the past 12 months, have you cut costs or expenditure
cap note Q9f2: Q9f2 In the past 12 months, have you worked with with at least one new supplier
cap note Q9f3: Q9f3 In the past 12 months, have you purchased higher quality inputs
cap note Q9f4: Q9f4 In the past 12 months, have you tried to negotiate with any of your suppliers for a lower price of particular product
cap note Q9f5: Q9f5 In the past 12 months, have you  compared the prices or quality offered by alternate suppliers to the prices offered by current suppliers
cap note Q9f6: Q9f6 In the past 12 months, have you got a loan from a formal financial institution for your business
cap note Q9f7: Q9f7 In the past 12 months, have you cooperated with current competitors
cap note Q9f8: Q9f8 In the past 12 months, have you tried to learn the selling price of competitors
cap note Q9f9: Q9f9 In the past 12 months, have you taken steps to attract more/higher paying customers
cap note Q9f10: Q9f10 In the past 12 months, have you had a change in the number of buyers/customers for your products? In which direction?
cap note Q9g1: Q9g1 In the past 12 months, how often do you discuss where to sell your product?
cap note Q9g2: Q9g2 In the past 12 months, with whom do you discuss where to sell your product the most often?
cap note Q9g2_other: Q9g2_other Other Specify
cap note Q9h1: Q9h1 In the past 12 months, How often do you discuss improving the quality of your product?
cap note Q9h2: Q9h2 In the past 12 months, With whom do you discuss improving the quality of your product the most often?
cap note Q9h2_other: Q9h2_other Other Specify
cap note Q9i1: Q9i1 In the past 12 months, How often do you discuss what products to sell?
cap note Q9i2: Q9i2 In the past 12 months, With whom do you discuss what products to sell the most often?
cap note Q9i2_other: Q9i2_other Other Specify
cap note Q9j1: Q9j1 In the past 12 months, How often do you discuss finding suppliers/inputs?
cap note Q9j2: Q9j2 In the past 12 months, With whom do you discuss finding suppliers/inputs most often?
cap note Q9k: Q9k If you wanted to improve profits, what would be the best ways to do it
cap note Q9k_other: Q9k_other Please specify
cap note note_puzzles: I will now ask you a few questions and puzzles, to learn more about the way you think
cap note Q9l: Q9l How should one calculate profits
cap note Q9l_other: Q9l_other Other Specify
cap note Q9m: Q9m Suppose you have deposited 5000 Afs in the bank for an interest of 10 percent per year. If you withdraw all the money after 1 year, how much will you get?
cap note Q9n: Q9n Please tell me 3 things that you think are important when taking out a loan from any source.
cap note Q9n_other: Q9n_other Other Specify
cap note Q9o: Q9o Please name some services you can get at a bank.
cap note Q9o_other: Q9o_other Other Specify
cap note Q9p: Q9p I will now read different sequences of digits. Every time I finish a sequence I would like you to repeat as many digits as you can in the order that I read them.  That means Beginning from the first and ending with the last.  For instance, when I read 1, 5, 2, after I am done reading, you respond 1, 5, 2. Every time you correctly recall a sequence, the next sequence will be one digit longer. Please listen carefully. 637,4539,16582,649735,3145782,74529638,794831265,8491285637,
cap note Q9q: Q9q Now, I will read sequences of numbers and every time I finish a sequence I would like you to repeat as many digits or numbers as you can recall in the reverse order. That means Beginning from the last and ending with the first. So, when I read 1, 5, 2, after I am done reading, you respond 2, 5, 1. Once again, every time you correctly recall a sequence, the next sequence will be one digit longer. Please listen carefully  637,4539,16582,649735,3145782,74529638,794831265,8491285637
cap note mod10: 10. Attitudes and Behavior
cap note Q10a: In the last 30 days, that is, the last one month, how many days did you attend any kind of group meeting with members of your community?
cap note Q10a1: During those meetings, how often did you speak such that everyone at the meeting could hear you?
cap note Q10b: Did you attend any CDC/village meetings in the last 12 MONTHS?
cap note Q10c: Are you a leader in your community, school, mosque, or in any groups?
cap note Q10cbsg2: How frequently do you leave your village?
cap note Q10cbsg3: How frequently do you travel to your local market?
cap note Q10cbsg4: How far away was this market (in km)?
cap note Q10cbsg5: Are you usually accompanied by any other adults?
cap note Q10cbsg6: Who usually accompanies you?
cap note Q10cbsg9: In a typical week, how many days did you meet friends who reside outside of your neighborhood?
cap note social: social
cap note social_heading: How often do you feel the following: Never, Rarely, Sometimes, Usually/Always
cap note Q10cbsg10: I have someone who understands my problems
cap note Q10cbsg11: I have someone who will listen to me when I need to talk
cap note Q10cbsg12: I feel there are people I can talk to if I am upset
cap note Q10cbsg14: I have someone I trust to talk with about my problems
cap note Q10cbsg15: I have someone I trust to talk with about my feelings
cap note Q10cbsg16: I can get helpful advice from others when dealing with a problem
cap note Q10cbsg18: I feel alone and apart from others
cap note howtrue: how true
cap note Q10d_note: Is each statement Never True, Not very true, Somewhat true, or Always true:
cap note Q10d: My actions on what types of work I do are determined by the situation. I don’t really have an option.
cap note Q10e: My actions in what types of work I do are partly because I will get in trouble with someone if I act differently.
cap note Q10f: Regarding the types of work I do, I do what I do so others don’t think poorly of me.
cap note Q10g: Regarding the types of work I do, I do what I do because I personally think it is the right thing to do.
cap note Q10h1: How much would YOUR opinion be considered in the final decision if your household needs to decide on the following things:
cap note Q10h2: Buying groceries
cap note Q10h3: Buying expensive items (i.e. mobile phone, farm equipment)
cap note Q10h4: Buying or selling land or property
cap note Q10h5: Whether your daughter should attend school
cap note Q10h6: Whether your son should attend school
cap note Q10h7: Marriage of children
cap note Q10h8: How many children to have
cap note Q10h9: You wanted to pursue a job outside the home
cap note Q10i1: How much input do you have in making decisions about INCOME HE/SHE EARNS?
cap note Q10i3: To what extent do you feel you can make your own personal decisions regarding  INCOME HE/SHE EARNS if you want(ed) to?
cap note Q10j1: How much input do you have in making decisions about HOW HOUSEHOLD INCOME IS SPENT?
cap note Q10j3: To what extent do you feel you can make your own personal decisions regarding  HOW HOUSEHOLD INCOME IS SPENT if you want(ed) to?
cap note Q10k1: How much input do you have in making decisions about WHICH BUSINESS OPPORTUNITIES TO PURSUE?
cap note Q10k3: To what extent do you feel you can make your own personal decisions on WHICH BUSINESS OPPORTUNITIES TO PURSUE if you want(ed) to?
cap note Q10l1: How much input do you have in making decisions about PURCHASING MATERIALS FOR YOUR BUSINESS?
cap note Q10l3: To what extent do you feel you can make your own personal decisions on PURCHASING MATERIALS FOR YOUR BUSINESS if you want(ed) to?
cap note howconf: how confident
cap note Q10cbsg0: Business ability
cap note Q10cbsg33: Estimate accurately the costs of producing products and services
cap note Q10cbsg34: Manage an employee who is not a member of your family
cap note Q10cbsg35: Resolve a difficult dispute with a customer or supplier
cap note note_agree1: I will now ask you series of questions. Please let me know your level of agreement, where the options are: Strongly Disagree, Disagree, Agree, or Strongly Agree
cap note Q10cbsg36: I feel that I have a number of good qualities
cap note Q10cbsg37: At times I think I am no good at all
cap note Q10cbsg38: I am able to do things as well as most other people
cap note Q10cbsg39: I feel I do not have much to be proud of
cap note Q10cbsg40: I certainly feel useless at times
cap note Q10cbsg41: I feel that I'm a person of worth, at least on an equal plane with others
cap note Q10cbsg42: I wish I could have more respect for myself
cap note note_agree2: I will now ask you series of questions. Please let me know your level of agreement, where the options are: Strongly Disagree, Disagree, Agree, or Strongly Agree
cap note Q10cbsg43: In uncertain times I usually expect the best
cap note Q10cbsg44: If something can go wrong for me, it will
cap note Q10cbsg45: I'm always optimistic about my future
cap note Q10cbsg46: I hardly ever expect things to go my way
cap note Q10cbsg47: I rarely count on good things happening to me
cap note Q10cbsg48: Overall I expect more good things to happen to me than bad
cap note Q10cbsg49: I believe that my success depends more on ability than luck
cap note Q10cbsg50: Our intelligence is a characteristic we cannot change much
cap note Q10cbsg51: We are intelligent up to a certain point and we cannot do much to change that
cap note Q10cbsg52: We may learn new things but we cannot change our basic intelligence
cap note note_agree3: I will now ask you series of questions. Please let me know your level of agreement, where the options are: Strongly Disagree, Disagree, Agree, or Strongly Agree
cap note Q10cbsg65: To a great extent my life is controlled by accidental happenings
cap note Q10cbsg66: I feel like what happens in my life is mostly determined by powerful people
cap note Q10cbsg67: When I make plans, I am almost certain to make them work
cap note Q10cbsg69: When I get what I want, it’s usually because I am lucky
cap note Q10cbsg70: Although I might have good ability, I will not be given leadership responsibility without appealing to those in positions of power
cap note Q10cbsg71: I have often found that what is going to happen will happen
cap note Q10cbsg73: People like myself have very little chance of protecting our personal interests when they conflict with those of strong pressure groups
cap note Q10cbsg74: It’s not always wise for me to plan too far ahead because many things turn out to be a matter of good or bad fortune
cap note Q10cbsg76: The work you do is important to you
cap note Q10cbsg77: If you disregard the help you receive from other household members, how do you and your spouse/partner divide the following tasks? PREPARING FOOD
cap note Q10cbsg78: If you disregard the help you receive from other household members, how do you and your spouse/partner divide the following tasks? CLEANING THE HOUSE AND WASHING THE CLOTHES
cap note Q10cbsg79: If you disregard the help you receive from other household members, how do you and your spouse/partner divide the following tasks? TAKING CARE OF CHILDREN
cap note Q10cbsg80: Taking all things together, how happy would you say you are?
cap note Q10m1: How much do you agree or disagree with the following statement: The important decisions in the family should be made only by the men of the family.
cap note Q10m2: How much do you agree or disagree with the following statement: If the wife is working outside the home, then the husband should help her with the household chores.
cap note Q10m3: How much do you agree or disagree with the following statement: A married woman should be allowed to work outside the home if she wants to.
cap note Q10m4: How much do you agree or disagree with the following statement: A wife should tolerate being beaten by her husband in order to keep the family together.
cap note Q10m5: How much do you agree or disagree with the following statement: It is better to send a son to school than it is to send a daughter.
cap note Q10m6: How much do you agree or disagree with the following statement: The wife has a right to express her opinion even if she disagrees with what her husband is saying
cap note Q10cbsg88: On a scale from 1 to 10, how often have you felt unsafe walking in your village during the DAY in the last 12 months? Where 1 is very rarely and 10 is very often.
cap note Q10cbsg89: On a scale from 1 to 10, how often have you felt unsafe walking in your village at NIGHT in the last 12 months? Where 1 is very rarely and 10 is very often.
cap note text13: End of the survey for the interviewee. Please thank them for their time.
cap note gps: Record GPS
cap note Q99a: Q99a) Interview language
cap note Q99a_other: Other (Please Spicify)
cap note Q99b: Q99b) Interview status
cap note Q99c: Q99c) On a scale of 1 (poorest) to 10 (wealthiest), how wealthy do you think the respondent's household is in comparison with other households in the village/community?
cap note Q99d: Q99d) How was the degree of co-operation of the respondent?
cap note Q99e: Q99e) During the interview of the respondent, was anyone else in listening?
cap note Q99e1: Q99e1) Do you think the presence of another person influenced the answers of the respondent?
cap note Q99f: Q99f) If no GPS Coordinates can be collected, mark down the address of the household, or a description and landmarks for relocating.
cap note Q99g: Q99g) Please record any general notes about the interview and any special information that will be helpful for supervisors, office editors, and data analysis.
