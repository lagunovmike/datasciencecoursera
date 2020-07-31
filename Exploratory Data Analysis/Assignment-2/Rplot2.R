## Question 2

## Have total emissions from PM2.5 decreased in the Baltimore City, Maryland 
## (fips == "24510) from 1999 to 2008? Use the base plotting system 
## to make a plot answering this question

library(dplyr)

# Data reading
sumscc <- readRDS("summarySCC_PM25.rds")


# Data wrangling
balt <- sumscc %>% 
  filter(fips == "24510") %>%
  group_by(year) %>%
  summarise(sum(Emissions))

# Data plotting
png(filename = "rplot2.png")
plot(balt, ylab = "Total Emissions", 
     main = "Total emissions by years in Baltimore city",
     pch = 19, cex = 2, col = 10)
lines(balt, col = 10, lwd = 2)
dev.off()