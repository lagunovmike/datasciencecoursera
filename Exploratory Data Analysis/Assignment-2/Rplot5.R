## Question 5

## How have emissions from motor vehicle sources changed 
## from 1999–2008 in Baltimore City?

library(dplyr)

# Data reading
scc <- readRDS("source_Classification_Code.rds")
sumscc <- readRDS("summarySCC_PM25.rds")
mrg <- merge(sumsc, scc, by = "SCC")

# Data wrangling
vehicles <- filter(mrg, grepl("Vehicles", EI.Sector),
                   fips == "24510") %>%
  group_by(year) %>%
  summarise(sum(Emissions))

# Data plotting
png(filename = "rplot5.png")
plot(vehicles, xlab = "year", ylab = "Total Emissions",
     main = "Total Emisisons from motor vehicles by years in Baltimore city",
     col = "magenta", pch = 20, cex = 2)
lines(vehicles, col = "magenta", lwd = 2)
dev.off()

