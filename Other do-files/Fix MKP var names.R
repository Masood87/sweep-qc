### fixing MKP variable names + subsetting
library(tidyverse)
rm(list = ls())

# import the data
filename <- "~/Dropbox/SWEEP shared/Baseline QC Reports/Data/SWEEP_MPK_Final_2018_09_07_07_07_49_735287.csv"
mkp <- read_csv(filename)

# parsing variable names and constract new variable names
fullnames <- colnames(mkp)
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

# rename cbsg file with new var names
colnames(mkp) <- newvarnames$newnames

# remove alpha characters from simserial variable
mkp$simserial <- gsub("n/a", "", mkp$simserial)
mkp$simserial <- gsub("[a-zA-Z]", "", mkp$simserial)

# save file with updated names in csv
write_csv(mkp, paste0("~/Dropbox/SWEEP shared/Baseline QC Reports/Data/mkp_updatednames__", format(Sys.time(), "%d%b%Y"), ".csv"))
