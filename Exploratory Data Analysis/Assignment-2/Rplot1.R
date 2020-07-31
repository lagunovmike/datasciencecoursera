## Question 1

## Have total emissions from PM2.5 decreased in the United States 
## from 1999 to 2008? Using the base plotting system, 
## make a plot showing the total PM2.5 emission from all sources 
## for each of the years 1999, 2002, 2005, and 2008

library(dplyr)

sumscc <- readRDS("summarySCC_PM25.rds")

png(filename = "rplot1.png")
tot_by_year <- group_by(sumscc, year) %>%
  summarise(sum(Emissions))
plot(tot_by_year, ylab = "Total Emissions", main = "Total emissions by years",
     pch = 19, col = "blue", cex = 2)
lines(tot_by_year, col = "blue", lwd = 2)
dev.off()