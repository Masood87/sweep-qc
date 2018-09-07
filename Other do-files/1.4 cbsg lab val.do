cap lab val Q1ee ruralurban
cap lab val Q1f1 yesno
cap lab val Q1f2 whynot_loc
cap lab val Q1l_consent yesno
cap lab val Q1l_whynot whynot_cbsg
cap lab val cdc_ver yes_no
cap lab val village_ver yes_no
cap lab val cbsg_ver yes_no
cap lab val resp_ver yes_no
cap lab val Q1m3_0 yesno
cap lab val Q1m4_0 yesno
cap lab val Q1m5_0 yesno
cap lab val Q1p relationship
cap lab val Q1r1 yesno
cap lab val Q1r2 whynot_mkp
cap lab val Q1r3 yesno
cap lab val Q1r5 relationship
cap lab val Q1s01 yesno
cap lab val Q1s02 yesno
cap lab val Q2c res_status
cap lab val Q2g relationship
cap lab val Q2h female
cap lab val Q2i marital
cap lab val Q2j yes_no
cap lab val Q2k1 yes_no
cap lab val Q2k2 migration

forv i = 1/27 {
	cap lab val Q2l_`i' literacy
}

cap lab val Q2m curr_attend
cap lab val Q2n1 education
cap lab val Q2r yes_no
cap lab val Q2s yes_no
cap lab val Q2t reasonnowork
cap lab val Q2u activities
cap lab val Q2w1 of_seven
cap lab val Q2w3 yes_no
cap lab val Q2w4 payment
cap lab val Q2w5 employer
cap lab val marstatus marital
cap lab val parstatus yesno
cap lab val Q3a yesno
cap lab val Q3a_name1 yesno
cap lab val Q3a_name2 yesno
cap lab val Q3a_name3 yesno
cap lab val Q3a_name4 yesno
cap lab val Q3a_name5 yesno
cap lab val Q3a_name6 yesno
cap lab val Q3a_name7 yesno
cap lab val Q3a_name8 yesno
cap lab val Q3a_name9 yesno
cap lab val Q3a_name10 yesno
cap lab val Q3a_name11 yesno
cap lab val Q3a_name12 yesno
cap lab val Q3a_name13 yesno
cap lab val Q3a_name14 yesno
cap lab val Q3a_name15 yesno
cap lab val Q3a_name16 yesno
cap lab val Q3a_name17 yesno
cap lab val Q3a_name18 yesno
cap lab val Q3a_name19 yesno
cap lab val Q3a_name20 yesno
cap lab val Q3b hoh
cap lab val Q3c yesno
cap lab val Q3c_name1 yesno
cap lab val Q3c_name2 yesno
cap lab val Q3c_name3 yesno
cap lab val Q3c_name4 yesno
cap lab val Q3c_name5 yesno
cap lab val Q3c_name6 yesno
cap lab val Q3c_name7 yesno
cap lab val Q3c_name8 yesno
cap lab val Q3c_name9 yesno
cap lab val Q3c_name10 yesno
cap lab val Q3c_name11 yesno
cap lab val Q3c_name12 yesno
cap lab val Q3c_name13 yesno
cap lab val Q3c_name14 yesno
cap lab val Q3c_name15 yesno
cap lab val Q3c_name16 yesno
cap lab val Q3c_name17 yesno
cap lab val Q3c_name18 yesno
cap lab val Q3c_name19 yesno
cap lab val Q3c_name20 yesno
cap lab val Q3d yesno
cap lab val Q3d_na yesno
cap lab val Q3d_name1 yesno
cap lab val Q3d_name2 yesno
cap lab val Q3d_name3 yesno
cap lab val Q3d_name4 yesno
cap lab val Q3d_name5 yesno
cap lab val Q3d_name6 yesno
cap lab val Q3d_name7 yesno
cap lab val Q3d_name8 yesno
cap lab val Q3d_name9 yesno
cap lab val Q3d_name10 yesno
cap lab val Q3d_name11 yesno
cap lab val Q3d_name12 yesno
cap lab val Q3d_name13 yesno
cap lab val Q3d_name14 yesno
cap lab val Q3d_name15 yesno
cap lab val Q3d_name16 yesno
cap lab val Q3d_name17 yesno
cap lab val Q3d_name18 yesno
cap lab val Q3d_name19 yesno
cap lab val Q3d_name20 yesno
cap lab val Q3e yesno
cap lab val Q3e_na yesno
cap lab val Q3e_name1 yesno
cap lab val Q3e_name2 yesno
cap lab val Q3e_name3 yesno
cap lab val Q3e_name4 yesno
cap lab val Q3e_name5 yesno
cap lab val Q3e_name6 yesno
cap lab val Q3e_name7 yesno
cap lab val Q3e_name8 yesno
cap lab val Q3e_name9 yesno
cap lab val Q3e_name10 yesno
cap lab val Q3e_name11 yesno
cap lab val Q3e_name12 yesno
cap lab val Q3e_name13 yesno
cap lab val Q3e_name14 yesno
cap lab val Q3e_name15 yesno
cap lab val Q3e_name16 yesno
cap lab val Q3e_name17 yesno
cap lab val Q3e_name18 yesno
cap lab val Q3e_name19 yesno
cap lab val Q3e_name20 yesno
cap lab val Q3f yesno
cap lab val Q3f_na yesno
cap lab val Q3f_name1 yesno
cap lab val Q3f_name2 yesno
cap lab val Q3f_name3 yesno
cap lab val Q3f_name4 yesno
cap lab val Q3f_name5 yesno
cap lab val Q3f_name6 yesno
cap lab val Q3f_name7 yesno
cap lab val Q3f_name8 yesno
cap lab val Q3f_name9 yesno
cap lab val Q3f_name10 yesno
cap lab val Q3f_name11 yesno
cap lab val Q3f_name12 yesno
cap lab val Q3f_name13 yesno
cap lab val Q3f_name14 yesno
cap lab val Q3f_name15 yesno
cap lab val Q3f_name16 yesno
cap lab val Q3f_name17 yesno
cap lab val Q3f_name18 yesno
cap lab val Q3f_name19 yesno
cap lab val Q3f_name20 yesno
cap lab val Q3g finalsay
cap lab val Q3h finalsay
cap lab val Q3i finalsay
cap lab val Q4a possible
cap lab val Q4c yes_no
cap lab val Q4d1 yes_no
cap lab val Q4d_note freq
cap lab val Q4d2 freq
cap lab val Q4d3 freq
cap lab val Q4d4 freq
cap lab val Q4d5 freq
cap lab val Q4e0 of_seven
cap lab val Q4e1 of_seven
cap lab val Q4e2 of_seven
cap lab val Q4e3 of_seven
cap lab val Q4e4 of_seven
cap lab val Q4e5 of_seven
cap lab val Q4e6 of_seven
cap lab val Q4e7 of_seven
cap lab val Q4e8 of_seven
cap lab val Q4e9 of_seven
cap lab val Q5a dwelltype
cap lab val Q5c occupancy
cap lab val Q5f1 yes_no
cap lab val Q5f2 yes_no
cap lab val Q5f3 yes_no
cap lab val Q5f4 yes_no
cap lab val Q5g heating
cap lab val Q5h toilet
cap lab val Q5i yes_no
cap lab val Q5j water
cap lab val Q5l phone
cap lab val Q5m1 yes_no
cap lab val Q5m9 yes_no
cap lab val Q5assets asset
cap lab val Q6a yes_no
cap lab val Q6b yes_no
cap lab val Q6c yes_no
cap lab val Q6d yes_no
cap lab val Q6e yes_no
cap lab val Q6f yes_no
cap lab val Q6g1_* activities
cap lab val Q6h1 employer
cap lab val Q6i yes_no
cap lab val Q6k2_check yes_no
cap lab val Q6k3 season
cap lab val Q6k4 payfreq
cap lab val Q6k7 confident
cap lab val Q6k8 yes_no
cap lab val Q6k10 hhlist
cap lab val Q6m yes_no
cap lab val Q6n1 yes_no
cap lab val Q6n6 yes_no
cap lab val Q6o0 yes_no
cap lab val Q6o5 yes_no
cap lab val Q6p finalsay
cap lab val Q6q asset
cap lab val Q6s asset
cap lab val Q6t1 agr_prod
cap lab val Q6t2 livestock_prod
cap lab val Q6t3 wholesale_prod
cap lab val Q6t4 retail_prod
cap lab val Q6t5 food_prod
cap lab val Q6t6 manuf_nonfood
cap lab val Q6t7 bus_nonag
cap lab val Q6t8 transport
cap lab val Q6u2_t1 unit
cap lab val Q6u3_t1 change2
cap lab val Q6u4_t1 sell_any
cap lab val Q6u10_t1 where_sold
cap lab val Q6u11_t1 who_transport
cap lab val Q6u12_t1 yes_no
cap lab val Q6u2_t2 unit
cap lab val Q6u3_t2 change2
cap lab val Q6u4_t2 sell_any
cap lab val Q6u10_t2 where_sold
cap lab val Q6u11_t2 who_transport
cap lab val Q6u12_t2 yes_no
cap lab val Q6u2_t3 unit
cap lab val Q6u3_t3 change2
cap lab val Q6u4_t3 sell_any
cap lab val Q6u10_t3 where_sold
cap lab val Q6u11_t3 who_transport
cap lab val Q6u12_t3 yes_no
cap lab val Q6u2_t4 unit
cap lab val Q6u3_t4 change2
cap lab val Q6u4_t4 sell_any
cap lab val Q6u10_t4 where_sold
cap lab val Q6u11_t4 who_transport
cap lab val Q6u12_t4 yes_no
cap lab val Q6u2_t5 unit
cap lab val Q6u3_t5 change2
cap lab val Q6u4_t5 sell_any
cap lab val Q6u10_t5 where_sold
cap lab val Q6u11_t5 who_transport
cap lab val Q6u12_t5 yes_no
cap lab val Q6u2_t6 unit
cap lab val Q6u3_t6 change2
cap lab val Q6u4_t6 sell_any
cap lab val Q6u10_t6 where_sold
cap lab val Q6u11_t6 who_transport
cap lab val Q6u12_t6 yes_no
cap lab val Q6u2_t7 unit
cap lab val Q6u3_t7 change2
cap lab val Q6u4_t7 sell_any
cap lab val Q6u10_t7 where_sold
cap lab val Q6u11_t7 who_transport
cap lab val Q6u12_t7 yes_no
cap lab val Q6u2_t8 unit
cap lab val Q6u3_t8 change2
cap lab val Q6u4_t8 sell_any
cap lab val Q6u10_t8 where_sold
cap lab val Q6u11_t8 who_transport
cap lab val Q6u12_t8 yes_no
cap lab val Q7a1 yes_no
cap lab val Q7a2 tazkira
cap lab val Q7b1 yes_no
cap lab val Q7c1 yes_no
cap lab val Q7d1 yes_no
cap lab val Q7e yes_no
cap lab val Q7f1 yes_no
cap lab val Q7g1 yes_no
cap lab val Q7h1 role
cap lab val Q7h2 yes_no
cap lab val Q7i discuss_freq
cap lab val Q7j4 meeting_bar
cap lab val Q7k2 confident
cap lab val Q7m1 yes_no
cap lab val Q7m2 loan_use
cap lab val Q7m3 product_type
cap lab val Q8a yes_no
cap lab val Q8b yes_no
cap lab val Q8c1 save_loc
cap lab val Q8c3 yes_no
cap lab val Q8c4 reason_save
cap lab val Q8c5 yes_no
cap lab val Q8d reason_noacc
cap lab val Q8e yes_no
cap lab val Q8e3 where_borrow
cap lab val Q8e4 reason_borrow
cap lab val Q8e5 reason_noborrow
cap lab val Q8f yes_no
cap lab val Q8g pot_loan
cap lab val Q9a1 yes_no
cap lab val Q9a2 budget_mgmt
cap lab val Q9b1 yes_no
cap lab val Q9b2 budget_mgmt
cap lab val Q9b3 yes_no
cap lab val Q9c1 yes_no
cap lab val Q9c2 yes_no
cap lab val Q9c3 yes_no
cap lab val Q9c4 yes_no
cap lab val Q9c5 yes_no
cap lab val Q9c6 yes_no
cap lab val Q9c7 yes_no
cap lab val Q9c8 yes_no
cap lab val Q9d yes_no
cap lab val Q9e yes_no
cap lab val Q9f1 yes_no
cap lab val Q9f2 yes_no
cap lab val Q9f3 yes_no
cap lab val Q9f4 yes_no
cap lab val Q9f5 yes_no
cap lab val Q9f6 yes_no
cap lab val Q9f7 yes_no
cap lab val Q9f8 yes_no
cap lab val Q9f9 yes_no
cap lab val Q9f10 change
cap lab val Q9g1 discuss_freq
cap lab val Q9g2 discuss_whom
cap lab val Q9h1 discuss_freq
cap lab val Q9h2 discuss_whom
cap lab val Q9i1 discuss_freq
cap lab val Q9i2 discuss_whom
cap lab val Q9j1 discuss_freq
cap lab val Q9j2 discuss_whom
cap lab val Q9k prof_ideas
cap lab val Q9l prof_calc
cap lab val Q9n loan_info
cap lab val Q9o bank_services
cap lab val Q10a1 freq_sel_nih2
cap lab val Q10b yes_no
cap lab val Q10c yesno
cap lab val Q10cbsg3 discuss_freq
cap lab val Q10cbsg5 yesno
cap lab val Q10cbsg6 who_transport
cap lab val Q10cbsg9 of_seven
cap lab val social_heading freq_sel_nih2
cap lab val Q10cbsg10 freq_sel_nih2
cap lab val Q10cbsg11 freq_sel_nih2
cap lab val Q10cbsg12 freq_sel_nih2
cap lab val Q10cbsg14 freq_sel_nih2
cap lab val Q10cbsg15 freq_sel_nih2
cap lab val Q10cbsg16 freq_sel_nih2
cap lab val Q10cbsg18 freq_sel_nih2
cap lab val Q10d_note true_dec
cap lab val Q10d true_dec
cap lab val Q10e true_dec
cap lab val Q10f true_dec
cap lab val Q10g true_dec
cap lab val Q10h1 decision
cap lab val Q10h2 decision
cap lab val Q10h3 decision
cap lab val Q10h4 decision
cap lab val Q10h5 decision
cap lab val Q10h6 decision
cap lab val Q10h7 decision
cap lab val Q10h8 decision
cap lab val Q10h9 decision
cap lab val Q10i1 dec_input
cap lab val Q10i3 extent
cap lab val Q10j1 dec_input
cap lab val Q10j3 extent
cap lab val Q10k1 dec_input
cap lab val Q10k3 extent
cap lab val Q10l1 dec_input
cap lab val Q10l3 extent
cap lab val Q10cbsg0 confidence
cap lab val Q10cbsg33 confidence
cap lab val Q10cbsg34 confidence
cap lab val Q10cbsg35 confidence
cap lab val note_agree1 agree4
cap lab val Q10cbsg36 agree4
cap lab val Q10cbsg37 agree4
cap lab val Q10cbsg38 agree4
cap lab val Q10cbsg39 agree4
cap lab val Q10cbsg40 agree4
cap lab val Q10cbsg41 agree4
cap lab val Q10cbsg42 agree4
cap lab val note_agree2 agree4
cap lab val Q10cbsg43 agree4
cap lab val Q10cbsg44 agree4
cap lab val Q10cbsg45 agree4
cap lab val Q10cbsg46 agree4
cap lab val Q10cbsg47 agree4
cap lab val Q10cbsg48 agree4
cap lab val Q10cbsg49 agree4
cap lab val Q10cbsg50 agree4
cap lab val Q10cbsg51 agree4
cap lab val Q10cbsg52 agree4
cap lab val note_agree3 agree4
cap lab val Q10cbsg65 agree4
cap lab val Q10cbsg66 agree4
cap lab val Q10cbsg67 agree4
cap lab val Q10cbsg69 agree4
cap lab val Q10cbsg70 agree4
cap lab val Q10cbsg71 agree4
cap lab val Q10cbsg73 agree4
cap lab val Q10cbsg74 agree4
cap lab val Q10cbsg76 agree4
cap lab val Q10cbsg77 share
cap lab val Q10cbsg78 share
cap lab val Q10cbsg79 share
cap lab val Q10cbsg80 happy
cap lab val Q10m1 agree
cap lab val Q10m2 agree
cap lab val Q10m3 agree
cap lab val Q10m4 agree
cap lab val Q10m5 agree
cap lab val Q10m6 agree
cap lab val Q10cbsg88 of_ten
cap lab val Q10cbsg89 of_ten
cap lab val Q99a language
cap lab val Q99b status
cap lab val Q99d cooperation
cap lab val Q99e yesno
cap lab val Q99e1 yesno
