* NOTE: to run this file, you should have R and tidyverse package in R


** set directory
cd "/Users/macbookair/Dropbox/SWEEP shared/Baseline QC Reports/Do-files/Other do-files/"

* fix cbsg varnames
quietly: file open rcode using  "Fix CBSG var names and subset.R", write replace
quietly: file write rcode ///
	`"library(tidyverse) "' _newline ///
	`"filename <- "$cbsgfile.csv" "' _newline ///
	`"cbsg <- read_csv(paste0("/Users/macbookair/Dropbox/SWEEP shared/Baseline QC Reports/Data/", filename)) "' _newline ///
	`""' _newline ///
	`"# parsing variable names and constract new variable names "' _newline ///
	`"fullnames <- colnames(cbsg) "' _newline ///
	`"last1 <- word(fullnames, -1, sep = "/") "' _newline ///
	`"last2 <- word(fullnames, -2, sep = "/") "' _newline ///
	`"vnames <- last1 "' _newline ///
	`"numerics = !is.na(as.numeric(vnames)) "' _newline ///
	`"vnames[numerics] <- paste(last2[numerics], last1[numerics], sep = "_") "' _newline ///
	`"inside_pranth_1 <- gsub(".*?\\[(.*?)\\].*", "\\1", fullnames, perl=TRUE) %>% as.numeric() %>% as.character() "' _newline ///
	`"inside_pranth_2 <- gsub(".*\\[(.*)\\].*", "\\1", fullnames, perl=TRUE) %>% as.numeric() %>% as.character() "' _newline ///
	`"dup <- duplicated(vnames) | duplicated(vnames, fromLast = TRUE) "' _newline ///
	`"vnames[dup] <- paste(vnames[dup], inside_pranth_1[dup], sep = "_") "' _newline ///
	`"dup2 <- duplicated(vnames) | duplicated(vnames, fromLast = TRUE) "' _newline ///
	`"vnames[dup2] <- paste(vnames[dup2], inside_pranth_2[dup2], sep = "_") "' _newline ///
	`""' _newline ///
	`"# Assemble all the data in a dataframe "' _newline ///
	`"newvarnames <- data.frame(oldnames=fullnames, newnames=vnames, numerics=numerics, dup=dup, dup2=dup2, inside_pranth_1=inside_pranth_1, inside_pranth_2=inside_pranth_2) "' _newline ///
	`""' _newline ///
	`"# rename cbsg file with new var names "' _newline ///
	`"colnames(cbsg) <- newvarnames\$newnames "' _newline ///
	`""' _newline ///
	`"# remove alpha characters from simserial variable "' _newline ///
	`"cbsg\$simserial <- gsub("n/a", "", cbsg\$simserial) "' _newline ///
	`"cbsg\$simserial <- gsub("[a-zA-Z]", "", cbsg\$simserial) "' _newline ///
	`""' _newline ///
	`"# remove objects "' _newline ///
	`"# rm(list = c("fullnames", "last1", "last2", "vnames", "numerics", "inside_pranth_1", "inside_pranth_2", "dup", "dup2", "filename", "newvarnames")) "' _newline ///
	`""' _newline ///
	`"# subset "' _newline ///
	`"# cbsg <- select(cbsg, start:Q2b_1, starts_with("Q2b"), contains("Q2l"), contains("Q2n1"), contains("Q2n2"), starts_with("Q2g"), starts_with("Q3a"), starts_with("Q3c"), starts_with("Q3f"), Q4b1, Q4b2, Q4c, Q5a, contains("Q6g1"), Q7g1, Q7f1, Q7f2, Q2_estimate, starts_with("Q2x"), starts_with("Q5m"), Q6a, Q6b, Q6c, Q6d, Q6e, Q6f, Q7k1, Q7n, starts_with("Q10"), Start_time, end_time) %>% rename(start_time = Start_time) "' _newline ///
	`"cbsg <- select(cbsg, start:Q2b_1, starts_with("Q2b"), contains("Q2l"), contains("Q2n1"), contains("Q2n2"), starts_with("Q2g"), starts_with("Q3a"), starts_with("Q3c"), starts_with("Q3f"), Q4b1, Q4b2, Q4c, Q5a, contains("Q6g1"), Q7g1, Q7f1, Q7f2, Q2_estimate, starts_with("Q2x"), starts_with("Q5m"), Q6a, Q6b, Q6c, Q6d, Q6e, Q6f, Q7k1, Q7n, Q10cbsg89, Q10m6, Start_time, end_time, "_submission_time") %>% rename(start_time = Start_time, submission_time = "_submission_time") "' _newline ///
	`"write_csv(cbsg, paste0("/Users/macbookair/Dropbox/SWEEP shared/Baseline QC Reports/Data/cbsg_subset__", format(Sys.time(), "%d%b%Y"), ".csv"), na = "") "'
quietly: file close rcode

shell /Library/Frameworks/R.framework/Resources/bin/R --vanilla <"Fix CBSG var names and subset.R"


* fix mkp varnames

quietly: file open rcode using  "Fix MKP var names and subset.R", write replace
quietly: file write rcode ///
	`"library(tidyverse) "' _newline ///
	`"filename <- "$mkpfile.csv" "' _newline ///
	`"mkp <- read_csv(paste0("/Users/macbookair/Dropbox/SWEEP shared/Baseline QC Reports/Data/", filename)) "' _newline ///
	`""' _newline ///
	`"# parsing variable names and constract new variable names "' _newline ///
	`"fullnames <- colnames(mkp) "' _newline ///
	`"last1 <- word(fullnames, -1, sep = "/") "' _newline ///
	`"last2 <- word(fullnames, -2, sep = "/") "' _newline ///
	`"vnames <- last1 "' _newline ///
	`"numerics = !is.na(as.numeric(vnames)) "' _newline ///
	`"vnames[numerics] <- paste(last2[numerics], last1[numerics], sep = "_") "' _newline ///
	`"inside_pranth_1 <- gsub(".*?\\[(.*?)\\].*", "\\1", fullnames, perl=TRUE) %>% as.numeric() %>% as.character() "' _newline ///
	`"inside_pranth_2 <- gsub(".*\\[(.*)\\].*", "\\1", fullnames, perl=TRUE) %>% as.numeric() %>% as.character() "' _newline ///
	`"dup <- duplicated(vnames) | duplicated(vnames, fromLast = TRUE) "' _newline ///
	`"vnames[dup] <- paste(vnames[dup], inside_pranth_1[dup], sep = "_") "' _newline ///
	`"dup2 <- duplicated(vnames) | duplicated(vnames, fromLast = TRUE) "' _newline ///
	`"vnames[dup2] <- paste(vnames[dup2], inside_pranth_2[dup2], sep = "_") "' _newline ///
	`""' _newline ///
	`"# Assemble all the data in a dataframe "' _newline ///
	`"newvarnames <- data.frame(oldnames=fullnames, newnames=vnames, numerics=numerics, dup=dup, dup2=dup2, inside_pranth_1=inside_pranth_1, inside_pranth_2=inside_pranth_2) "' _newline ///
	`""' _newline ///
	`"# rename mkp file with new var names "' _newline ///
	`"colnames(mkp) <- newvarnames\$newnames "' _newline ///
	`""' _newline ///
	`"# fix format issue of certain columns"' _newline ///
	`"mkp\$Q10m6[mkp\$Q10m6=="Strongly disagree"] <- "1" "' _newline ///
	`"mkp\$Q10m6[mkp\$Q10m6=="Disagree"] <- "2" "' _newline ///
	`"mkp\$Q10m6[mkp\$Q10m6=="Neither agree nor disagree"] <- "3" "' _newline ///
	`"mkp\$Q10m6[mkp\$Q10m6=="Agree"] <- "4" "' _newline ///
	`"mkp\$Q10m6[mkp\$Q10m6=="Strongly agree"] <- "5" "' _newline ///
	`"mkp\$Q10m6[mkp\$Q10m6=="Do not know"] <- "98" "' _newline ///
	`"mkp\$Q10m6[mkp\$Q10m6=="Refuse to answer"] <- "99" "' _newline ///
	`"mkp\$Q10m6 <- as.numeric(mkp\$Q10m6) "' _newline ///
	`""' _newline ///
	`"mkp\$Q5a[mkp\$Q5a=="Single family house"] <- "1" "' _newline ///
	`"mkp\$Q5a[mkp\$Q5a=="Part of a shared house/Compound"] <- "2" "' _newline ///
	`"mkp\$Q5a[mkp\$Q5a=="Separate apartment"] <- "3" "' _newline ///
	`"mkp\$Q5a[mkp\$Q5a=="Shared apartment"] <- "4" "' _newline ///
	`"mkp\$Q5a[mkp\$Q5a=="Tent"] <- "5" "' _newline ///
	`"mkp\$Q5a[mkp\$Q5a=="Temporary shelter/shack/hut"] <- "6" "' _newline ///
	`"mkp\$Q5a[mkp\$Q5a=="Other"] <- "96" "' _newline ///
	`""' _newline ///
	`"mkp\$Q5m9[mkp\$Q5m9=="Yes"] <- "1" "' _newline ///
	`"mkp\$Q5m9[mkp\$Q5m9=="No"] <- "0" "' _newline ///
	`"mkp\$Q5m9[mkp\$Q5m9=="Do not know"] <- "98" "' _newline ///
	`"mkp\$Q5m9[mkp\$Q5m9=="Refuse to answer"] <- "99" "' _newline ///
	`""' _newline ///
	`"# remove alpha characters from simserial variable "' _newline ///
	`"mkp\$simserial <- gsub("n/a", "", mkp\$simserial) "' _newline ///
	`"mkp\$simserial <- gsub("[a-zA-Z]", "", mkp\$simserial) "' _newline ///
	`""' _newline ///
	`"# remove objects "' _newline ///
	`"# rm(list = c("fullnames", "last1", "last2", "vnames", "numerics", "inside_pranth_1", "inside_pranth_2", "dup", "dup2", "filename", "newvarnames")) "' _newline ///
	`""' _newline ///
	`"# subset "' _newline ///
	`"remove_cols <- grep("_NA", names(mkp)) "' _newline ///
	`"mkp <- mkp[, -remove_cols] "' _newline ///
	`"mkp <- select(mkp, start:Q2b_1, starts_with("Q2b"), contains("Q2l"), contains("Q2n1"), contains("Q2n2"), starts_with("Q2g"), Q2_estimate, contains("Q2x"), starts_with("Q3a"), starts_with("Q3c"), starts_with("Q3f"), Q4b1, Q4b2, Q5a, Q5m2, Q5m3, Q5m4, Q5m5, Q5m6, Q5m7, Q5m8, Q5m9, Q5m10, Q5m1, starts_with("Q10"), start_time, end_time, "_submission_time") %>% rename(submission_time = "_submission_time") "' _newline ///
	`"write_csv(mkp, paste0("~/Dropbox/SWEEP shared/Baseline QC Reports/Data/mkp_subset__", format(Sys.time(), "%d%b%Y"), ".csv"), na = "") "'
quietly: file close rcode

shell /Library/Frameworks/R.framework/Resources/bin/R --vanilla <"Fix MKP var names and subset.R"
