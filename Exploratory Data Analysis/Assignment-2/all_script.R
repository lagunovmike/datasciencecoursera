library(dplyr)
library(ggplot2)
library(ggpubr)

scc <- readRDS("source_Classification_Code.rds")
sumscc <- readRDS("summarySCC_PM25.rds")

# Plot 1
tot_by_year <- group_by(sumscc, year) %>%
  summarise(sum(Emissions))
plot(tot_by_year, ylab = "Total Emissions", main = "Total emissions by years",
     pch = 19, col = "blue", cex = 2)
lines(tot_by_year, col = "blue", lwd = 2)

# Plot 2

balt <- sumscc %>% 
  filter(fips == "24510") %>%
  group_by(year) %>%
  summarise(sum(Emissions))
plot(balt, ylab = "Total Emissions", 
     main = "Total emissions by years in Baltimore city",
     pch = 19, cex = 2, col = 10)
lines(balt, col = 10, lwd = 2)


# Plot 3


sumscc$type <- tolower(sumscc$type)
bysrc <- sumscc %>% 
  group_by(type, year) %>%
  summarise(sum(Emissions)) %>%
  rename(total = 'sum(Emissions)')

bysrc_balt <- sumscc %>%
  filter(fips == "24510") %>%
  group_by(type, year) %>%
  summarise(sum(Emissions)) %>%
  rename(total = 'sum(Emissions)')

g_all <- ggplot() +
  geom_point(data = bysrc, aes(year, total, col = type)) +
  geom_line(data = bysrc, aes(year, total, col = type)) +
  ylab("Total emissions") +
  ggtitle("Total emissions across all the country")

g_balt <- ggplot () +
  geom_point(data = bysrc_balt, aes(year, total, col = type)) +
  geom_line(data = bysrc_balt, aes(year, total, col = type)) +
  ylab("Total emissions") +
  ggtitle("Total emissions in Baltimore city")

figure <- ggarrange(g_all, g_balt, nrow = 1, ncol = 2, common.legend = T)
figure


# Plot 4

mrg <- merge(sumscc, scc, by = "SCC")
coal <- slice(mrg, grep(pattern = "Coal", scc$Short.Name)) %>%
  group_by(year) %>%
  summarise(sum(year))
plot(coal, col = "brown", ylab = "Total", main = "Emissions from coal combustion by years",
     pch = 19, cex = 2)
lines(coal, col = "brown", lwd = 2)


# Plot 5

mrg <- merge(sumsc, scc, by = "SCC")
vehicles <- filter(mrg, grepl("Vehicles", EI.Sector),
                   fips == "24510") %>%
  group_by(year) %>%
  summarise(sum(Emissions))

plot(vehicles, xlab = "year", ylab = "Total Emissions",
       main = "Total Emisisons from motor vehicle sources by years",
       col = "magenta", pch = 20, cex = 2)
lines(vehicles, col = "magentamagenta", lwd = 2)


# Plot 6
mrg <- merge(sumscc, scc, by = "SCC")
vehiclesBalt <- filter(mrg, grepl("Vehicles", EI.Sector),
                       fips == "24510") %>%
  group_by(year) %>%
  summarise(sum(Emissions))

vehiclesLA <- filter(mrg, grepl("Vehicles", EI.Sector),
                     fips == "06037") %>%
  group_by(year) %>%
  summarise(sum(Emissions))

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


