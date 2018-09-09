### fixing MKP variable names + subsetting
library(tidyverse)
rm(list = ls())

# import the data
filename <- paste0("~/Dropbox/SWEEP shared/Baseline QC Reports/Data/mkp_updatednames__", format(Sys.time(), "%d%b%Y"), ".csv")
mkp <- read_csv(filename)

# subset
mkp <- select(mkp, hhid, sfdistrict, start, end, deviceid, simserial, contains("sfnumber"), contains("enum"), contains("Q2l"), contains("Q2n1"), contains("Q2n2"), starts_with("Q2g"), Q4b1, Q4b2, Q5a, contains("Q2x"), Q5m2, Q5m3, Q5m4, Q5m5, Q5m6, Q5m7, Q5m8, Q5m9, Q5m10, Q5m1, Q10m6)
write_csv(mkp, paste0("~/Dropbox/SWEEP shared/Baseline QC Reports/Data/mkp_subset__", format(Sys.time(), "%d%b%Y"), ".csv"))


