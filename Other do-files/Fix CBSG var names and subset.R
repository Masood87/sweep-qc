library(tidyverse) 
filename <- "SWEEP_CBSG_Final_2018_10_01_00_06_06_946310.csv" 
cbsg <- read_csv(paste0("/Users/macbookair/Dropbox/SWEEP shared/Baseline QC Reports/Data/", filename)) 

# parsing variable names and constract new variable names 
fullnames <- colnames(cbsg) 
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

# rename cbsg file with new var names 
colnames(cbsg) <- newvarnames$newnames 

# remove alpha characters from simserial variable 
cbsg$simserial <- gsub("n/a", "", cbsg$simserial) 
cbsg$simserial <- gsub("[a-zA-Z]", "", cbsg$simserial) 

# remove objects 
# rm(list = c("fullnames", "last1", "last2", "vnames", "numerics", "inside_pranth_1", "inside_pranth_2", "dup", "dup2", "filename", "newvarnames")) 

# subset 
cbsg <- select(cbsg, start:Q2b_1, starts_with("Q2b"), contains("Q2l"), contains("Q2n1"), contains("Q2n2"), starts_with("Q2g"), starts_with("Q3a"), starts_with("Q3c"), starts_with("Q3f"), Q4b1, Q4b2, Q4c, Q5a, contains("Q6g1"), Q7g1, Q7f1, Q7f2, Q2_estimate, starts_with("Q2x"), starts_with("Q5m"), Q6a, Q6b, Q6c, Q6d, Q6e, Q6f, Q7k1, Q7n, starts_with("Q10"), Start_time, end_time) %>% rename(start_time = Start_time) 
write_csv(cbsg, paste0("/Users/macbookair/Dropbox/SWEEP shared/Baseline QC Reports/Data/cbsg_subset__", format(Sys.time(), "%u%b%Y"), ".csv"), na = "") 