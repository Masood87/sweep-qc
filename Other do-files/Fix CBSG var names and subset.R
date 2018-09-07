### fixing CBSG variable names

library(tidyverse)
rm(list = ls())

# import the data
filename <- "~/Dropbox/SWEEP shared/Baseline QC Reports/Data/SWEEP_CBSG_Final_2018_09_07_07_05_01_063572.csv"
cbsg <- read_csv(filename)

# parsing variable names and constract new variable names
fullnames <- colnames(cbsg)
last1 <- word(fullnames, -1, sep = "/")
last2 <- word(fullnames, -2, sep = "/")
vnames <- last1
numerics = !is.na(as.numeric(vnames))
vnames[numerics] <- paste(last2[numerics], last1[numerics], sep = "_")
inside_pranth_1 <- gsub(".*?\\[(.*?)\\].*", "\\1", fullnames, perl=TRUE) %>%
  as.numeric() %>% as.character()
inside_pranth_2 <- gsub(".*\\[(.*)\\].*", "\\1", fullnames, perl=TRUE) %>%
  as.numeric() %>% as.character()
dup <- duplicated(vnames) | duplicated(vnames, fromLast = TRUE)
vnames[dup] <- paste(vnames[dup], inside_pranth_1[dup], sep = "_")
dup2 <- duplicated(vnames) | duplicated(vnames, fromLast = TRUE)
vnames[dup2] <- paste(vnames[dup2], inside_pranth_2[dup2], sep = "_")

# Assemble all the data in a dataframe
newvarnames <- data.frame(oldnames = fullnames, 
           newnames = vnames, 
           numerics = numerics,
           dup = dup,
           dup2 = dup2,
           inside_pranth_1 = inside_pranth_1,
           inside_pranth_2 = inside_pranth_2)

# export the old var names and new var names to a csv
# newvarnames_subset <- select(newvarnames, oldnames, newnames)
# newvarnames_subset$statanames <- gsub("[[:punct:]]", "", newvarnames_subset$oldnames)
# mutate(newvarnames_subset, 
#        `*rename` = paste("cap rename", statanames, newnames)) %>%
#   select(`*rename`) %>%
#   write_csv("~/Downloads/sweep/cleaning and labelling/variable names/cbsg_variable_names.do")

# rename cbsg file with new var names
colnames(cbsg) <- newvarnames$newnames

# remove alpha characters from simserial variable
cbsg$simserial <- gsub("n/a", "", cbsg$simserial)
cbsg$simserial <- gsub("[a-zA-Z]", "", cbsg$simserial)

# subset
cbsg <- select(cbsg, hhid, sfdistrict, contains("enum"), Q1f1, contains("Q1l"), Q10cbsg89, Q1p, Q1r1, Q1r3, start, end, deviceid, simserial, contains("sfnumber"), Q2a, contains("Q2b"), contains("Q2l"), Q1n, contains("Q2n1"), contains("Q2n2"), starts_with("Q2g"), Q4b1, Q4b2, Q4c, Q5a, contains("Q6g1"), Q7g1, Q7f1, Q7f2, starts_with("Q2x"), starts_with("Q5m"), Q6a, Q6b, Q6c, Q6d, Q6e, Q6f, Q10m6)
write_csv(cbsg, paste0("~/Dropbox/SWEEP shared/Baseline QC Reports/Data/cbsg_subset__", format(Sys.time(), "%d%b%Y"), ".csv"))

# export updated cbsg file
# df %>% write_csv(paste0(word(filename, 1, sep = "\\."), "_updatevnames.csv"))
