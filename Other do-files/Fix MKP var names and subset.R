library(tidyverse) 
filename <- "SWEEP_MPK_Final_2018_11_02_11_19_12_027878.csv" 
mkp <- read_csv(paste0("/Users/macbookair/Dropbox/SWEEP shared/Baseline QC Reports/Data/", filename)) 

# parsing variable names and constract new variable names 
fullnames <- colnames(mkp) 
last1 <- word(fullnames, -1, sep = "/") 
last2 <- word(fullnames, -2, sep = "/") 
vnames <- last1 
numerics = !is.na(as.numeric(vnames)) 
vnames[numerics] <- paste(last2[numerics], last1[numerics], sep = "_") 
inside_pranth_1 <- gsub(".*?\\[(.*?)\\].*", "\\1", fullnames, perl=TRUE) %>% as.numeric() %>% as.character() 
inside_pranth_2 <- gsub(".*\\[(.*)\\].*", "\\1", fullnames, perl=TRUE) %>% as.numeric() %>% as.character() 
dup <- duplicated(vnames) | duplicated(vnames, fromLast = TRUE) 
vnames[dup] <- paste(vnames[dup], inside_pranth_1[dup], sep = "_") 
dup2 <- duplicated(vnames) | duplicated(vnames, fromLast = TRUE) 
vnames[dup2] <- paste(vnames[dup2], inside_pranth_2[dup2], sep = "_") 

# Assemble all the data in a dataframe 
newvarnames <- data.frame(oldnames=fullnames, newnames=vnames, numerics=numerics, dup=dup, dup2=dup2, inside_pranth_1=inside_pranth_1, inside_pranth_2=inside_pranth_2) 

# rename mkp file with new var names 
colnames(mkp) <- newvarnames$newnames 

# fix format issue of certain columns
mkp$Q10m6[mkp$Q10m6=="Strongly disagree"] <- "1" 
mkp$Q10m6[mkp$Q10m6=="Disagree"] <- "2" 
mkp$Q10m6[mkp$Q10m6=="Neither agree nor disagree"] <- "3" 
mkp$Q10m6[mkp$Q10m6=="Agree"] <- "4" 
mkp$Q10m6[mkp$Q10m6=="Strongly agree"] <- "5" 
mkp$Q10m6[mkp$Q10m6=="Do not know"] <- "98" 
mkp$Q10m6[mkp$Q10m6=="Refuse to answer"] <- "99" 
mkp$Q10m6 <- as.numeric(mkp$Q10m6) 

mkp$Q5a[mkp$Q5a=="Single family house"] <- "1" 
mkp$Q5a[mkp$Q5a=="Part of a shared house/Compound"] <- "2" 
mkp$Q5a[mkp$Q5a=="Separate apartment"] <- "3" 
mkp$Q5a[mkp$Q5a=="Shared apartment"] <- "4" 
mkp$Q5a[mkp$Q5a=="Tent"] <- "5" 
mkp$Q5a[mkp$Q5a=="Temporary shelter/shack/hut"] <- "6" 
mkp$Q5a[mkp$Q5a=="Other"] <- "96" 

mkp$Q5m9[mkp$Q5m9=="Yes"] <- "1" 
mkp$Q5m9[mkp$Q5m9=="No"] <- "0" 
mkp$Q5m9[mkp$Q5m9=="Do not know"] <- "98" 
mkp$Q5m9[mkp$Q5m9=="Refuse to answer"] <- "99" 

# remove alpha characters from simserial variable 
mkp$simserial <- gsub("n/a", "", mkp$simserial) 
mkp$simserial <- gsub("[a-zA-Z]", "", mkp$simserial) 

# remove objects 
# rm(list = c("fullnames", "last1", "last2", "vnames", "numerics", "inside_pranth_1", "inside_pranth_2", "dup", "dup2", "filename", "newvarnames")) 

# subset 
remove_cols <- grep("_NA", names(mkp)) 
mkp <- mkp[, -remove_cols] 
mkp <- select(mkp, start:Q2b_1, starts_with("Q2b"), contains("Q2l"), contains("Q2n1"), contains("Q2n2"), starts_with("Q2g"), Q2_estimate, contains("Q2x"), starts_with("Q3a"), starts_with("Q3c"), starts_with("Q3f"), Q4b1, Q4b2, Q5a, Q5m2, Q5m3, Q5m4, Q5m5, Q5m6, Q5m7, Q5m8, Q5m9, Q5m10, Q5m1, starts_with("Q10"), start_time, end_time, "_submission_time") %>% rename(submission_time = "_submission_time") 
write_csv(mkp, paste0("~/Dropbox/SWEEP shared/Baseline QC Reports/Data/mkp_subset__", format(Sys.time(), "%d%b%Y"), ".csv"), na = "") 