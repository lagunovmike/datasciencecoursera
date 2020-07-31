rd0 <- read.table("Exploratory Data Analysis/RD_501_88101_1999-0.txt", 
                  comment.char = "#", header = F, sep = "|", na.strings = "")
dim(rd0)
head(rd0)
cnames <- readLines("Exploratory Data Analysis/RD_501_88101_1999-0.txt", 1)
cnames
cnames <- strsplit(cnames, "|", fixed = T)
names(rd0) <- make.names(cnames[[1]])
