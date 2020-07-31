## Question 6

## Compare emissions from motor vehicle sources in Baltimore City 
## with emissions from motor vehicle sources in Los Angeles County, 
## California (fips == "06037"). 
## Which city has seen greater changes over time in motor vehicle emissions?

library(dplyr)

# Data reading
scc <- readRDS("source_Classification_Code.rds")
sumscc <- readRDS("summarySCC_PM25.rds")
mrg <- merge(sumscc, scc, by = "SCC")

# Data wrangling
vehiclesBalt <- filter(mrg, grepl("Vehicles", EI.Sector),
                       fips == "24510") %>%
  group_by(year) %>%
  summarise(sum(Emissions))

vehiclesLA <- filter(mrg, grepl("Vehicles", EI.Sector),
                     fips == "06037") %>%
  group_by(year) %>%
  summarise(sum(Emissions))

# Data plotting

png(filename = "rplot6.png", width = 640, height = 640)
par(mfrow = c(1,2))
plot(vehiclesBalt$year, log10(vehiclesBalt$`sum(Emissions)`), col = "blue",
     ylab = "log10 Total Emissions", xlab = "year",
     pch = 19, cex = 2,
     main = "Total emissions in Baltimore City")
lines(vehiclesBalt$year, log10(vehiclesBalt$`sum(Emissions)`), col = "blue",
      lwd = 2)
plot(vehiclesLA$year,log10(vehiclesLA$`sum(Emissions)`), col = "green", 
     ylab = "log10 Total Emissions", pch = 19, cex = 2, xlab = "year",
     main = "Total emissions in Los Angeles")
lines(vehiclesLA$year,log10(vehiclesLA$`sum(Emissions)`), col = "green", lwd = 2)
dev.off()