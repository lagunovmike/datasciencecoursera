## Question 4

## Across the United States, how have emissions from coal combustion-related sources 
## changed from 1999–2008?

library(dplyr)

# Data reading
scc <- readRDS("source_Classification_Code.rds")
sumscc <- readRDS("summarySCC_PM25.rds")


# Data wrangling
mrg <- merge(sumscc, scc, by = "SCC")
coal <- slice(mrg, grep(pattern = "Coal", scc$Short.Name)) %>%
  group_by(year) %>%
  summarise(sum(year))

# Data plotting
png(filename = "rplot4.png")
plot(coal, col = "brown", ylab = "Total", main = "Emissions from coal combustion by years",
     pch = 19, cex = 2)
lines(coal, col = "brown", lwd = 2)
dev.off()
