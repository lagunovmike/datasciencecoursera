# Question 1
fileDest1 <- "Getting and Cleaning Data/getdata_data_ss06hid.csv"
if(!exists(fileDest1)){
  fileUrl1 <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv"
  download.file(fileUrl1, fileDest1)
}
hid <- read.csv(fileDest1)
namespl <- strsplit(names(hid),"wgtp")
namespl[123]

names(hid)
namespl

# Question 2
library(dplyr)
fileDest2 <- "Getting and Cleaning Data/fgdp.csv"
if(!exists("fileDest2")){
  fileUrl2 <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv"
  download.file(fileUrl2, fileDest2)
} 
fgdp <- read.csv(fileDest2)
names(fgdp)[c(1,2,4,5)] <- c("countrycode", "rank", "name", "gdp")
fgdp <- fgdp %>%
  select(names(fgdp)[c(1,2,4,5)]) %>%
  filter(countrycode != "", rank != "")
fgdp$gdp <- gsub(",","",fgdp$gdp)
mean(as.numeric(fgdp$gdp), na.rm=T)

# Question 3
grep("^United", fgdp$name, value = T)

# Question 4
fileDest3 <- "Getting and Cleaning Data/fedstats.csv"
if(!exists(fileDest3)){
  fileUrl3 <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv"
  download.file(fileUrl3,  fileDest3)
}
fedstats <- read.csv(fileDest3)
names(fedstats) <- tolower(names(fedstats))
comb <- merge(fgdp, fedstats, by = "countrycode")
fiscal2 <- grepl("[F,f]iscal year", comb$special.notes)
fiscal <- comb[fiscal2,]
fiscalJune <-fiscal[grepl("[J,j]une", fiscal$special.notes),]
nrow(fiscalJune)

# Question 5

library(quantmod)
library(lubridate)
amzn = getSymbols("AMZN",auto.assign=FALSE)
sampleTimes = index(amzn)
sum(year(sampleTimes) == 2012)
sum(year(sampleTimes) == 2012 & wday(sampleTimes) == 2)
  