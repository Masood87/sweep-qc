### fixing CBSG variable names

library(tidyverse)
rm(list = ls())

# import the data
filename <- paste0("~/Dropbox/SWEEP shared/Baseline QC Reports/Data/cbsg_updatednames__", format(Sys.time(), "%d%b%Y"), ".csv")
cbsg <- read_csv(filename)

# subset
cbsg <- select(cbsg, hhid, sfdistrict, contains("enum"), Q1f1, contains("Q1l"), Q10cbsg89, Q1p, Q1r1, Q1r3, start, end, deviceid, simserial, contains("sfnumber"), Q2a, contains("Q2b"), contains("Q2l"), Q1n, contains("Q2n1"), contains("Q2n2"), starts_with("Q2g"), Q4b1, Q4b2, Q4c, Q5a, contains("Q6g1"), Q7g1, Q7f1, Q7f2, Q2_estimate, starts_with("Q2x"), starts_with("Q5m"), Q6a, Q6b, Q6c, Q6d, Q6e, Q6f, Q10m6)
write_csv(cbsg, paste0("~/Dropbox/SWEEP shared/Baseline QC Reports/Data/cbsg_subset__", format(Sys.time(), "%d%b%Y"), ".csv"))
