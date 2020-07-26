# Question 1
library(dplyr)
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv"
download.file(fileUrl, destfile = "Getting and Cleaning Data/community.csv")
community <- read.csv("Getting and Cleaning Data/community.csv")
agricultureLogical <- ifelse(community$ACR >= 3 & community$AGS == 6, TRUE, FALSE)
which(agricultureLogical)[1:3]
## Answer: 125 238 262

# Question 2
library(jpeg)
picUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fjeff.jpg"
download.file(picUrl, destfile = "Getting and cleaning Data/jeff.jpg", mode = "wb")
jeff <- readJPEG("Getting and cleaning Data/jeff.jpg", native = T)
quantile(jeff, probs = c(0.3,0.8))
## Answer: -15258512 -10575416

# Question 3
fileUrl2 <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv"
fileUrl3 <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv"
destfile2 <- "Getting and Cleaning Data/fgdp.csv"
destfile3 <- "Getting andCleaning Data/fedstats.csv"
download.file(fileUrl2,destfile2)
download.file(fileUrl3, destfile3)
fgdp <- read.csv(destfile2, skip = 4)
fgdp <- select(fgdp,1,2,4,5)
names(fgdp) <- c("CountryCode", "Ranking", "Long.Name", "US.Dollars")
#fgdp <- fgdp[fgdp$Ranking != "",]
fgdp <- filter(fgdp, Ranking != "", CountryCode != "" )
fedstats <- read.csv(destfile3)
comb <- merge(fgdp,fedstats, by="CountryCode")
inter <- length(intersect(fgdp$CountryCode, fedstats$CountryCode))
arr <- arrange(comb, desc(as.numeric(Ranking)))[13,3]
paste(inter, "intersections. The 13th. economy is:", arr, sep = " ")

# Question 4. Following the previous one

group_by(comb, Income.Group) %>%
  summarize(mean = mean(as.numeric(Ranking), na.rm = T))

# Question 5
library(Hmisc)
cutted <- cut2(as.numeric(comb$Ranking), g = 5)
table(cutted,comb$Income.Group)
