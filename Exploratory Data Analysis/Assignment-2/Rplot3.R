## Question 3

## Of the four types of sources indicated by the type 
## (point, nonpoint, onroad, nonroad) variable, which of these four sources 
## have seen decreases in emissions from 1999–2008 for Baltimore City? 
## Which have seen increases in emissions from 1999–2008? 
## Use the ggplot2 plotting system to make a plot answer this question

library(dplyr)
library(ggplot2)
library(ggpubr)

sumscc <- readRDS("summarySCC_PM25.rds")

# Data wrangling
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

# Plots making

g_all <- ggplot() +
  geom_point(data = bysrc, aes(year, total, col = type)) +
  geom_line(data = bysrc, aes(year, total, col = type)) +
  ylab("Total emissions") +
  ggtitle("Total emissions in the country")

g_balt <- ggplot () +
  geom_point(data = bysrc_balt, aes(year, total, col = type)) +
  geom_line(data = bysrc_balt, aes(year, total, col = type)) +
  ylab("Total emissions") +
  ggtitle("Total emissions in Baltimore city")

# Making them together
figure <- ggarrange(g_all, g_balt, nrow = 1, ncol = 2, common.legend = T)
figure

# Saving (for some reasons this method works better than png function)
ggsave(filename = "rplot3.png", scale = 1.3)

