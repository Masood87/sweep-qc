* NOTE: to run this file, you should have R and tidyverse package in R


** set directory
cd "/Users/macbookair/Dropbox/SWEEP shared/Baseline QC Reports/Do-files/Other do-files/"

* fix cbsg varnames
quietly: file open rcode using  "Fix CBSG var names.R", write replace
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
	`"write_csv(cbsg, paste0("/Users/macbookair/Dropbox/SWEEP shared/Baseline QC Reports/Data/cbsg_subset__", format(Sys.time(), "%u%b%Y"), ".csv"), na = "") "'
quietly: file close rcode

shell /Library/Frameworks/R.framework/Resources/bin/R --vanilla <"Fix CBSG var names.R"


* fix mkp varnames

quietly: file open rcode using  "Fix MKP var names.R", write replace
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
	`"# remove alpha characters from simserial variable "' _newline ///
	`"mkp\$simserial <- gsub("n/a", "", mkp\$simserial) "' _newline ///
	`"mkp\$simserial <- gsub("[a-zA-Z]", "", mkp\$simserial) "' _newline ///
	`""' _newline ///
	`"# remove objects "' _newline ///
	`"# rm(list = c("fullnames", "last1", "last2", "vnames", "numerics", "inside_pranth_1", "inside_pranth_2", "dup", "dup2", "filename", "newvarnames")) "' _newline ///
	`""' _newline ///
	`"write_csv(mkp, paste0("~/Dropbox/SWEEP shared/Baseline QC Reports/Data/mkp_subset__", format(Sys.time(), "%u%b%Y"), ".csv"), na = "") "'
quietly: file close rcode

shell /Library/Frameworks/R.framework/Resources/bin/R --vanilla <"Fix MKP var names.R"
