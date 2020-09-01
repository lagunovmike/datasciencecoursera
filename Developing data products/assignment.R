library(rvest)
library(tidyr)
library(plotly)
library(ggplot2)
library(leaflet)
Sys.setlocale("LC_ALL", "russian")
link <- "https://ru.wikipedia.org/wiki/%D0%A1%D0%BF%D0%B8%D1%81%D0%BE%D0%BA_%D0%B3%D0%BE%D1%80%D0%BE%D0%B4%D0%BE%D0%B2_%D0%A0%D0%BE%D1%81%D1%81%D0%B8%D0%B8_%D1%81_%D0%BD%D0%B0%D1%81%D0%B5%D0%BB%D0%B5%D0%BD%D0%B8%D0%B5%D0%BC_%D0%B1%D0%BE%D0%BB%D0%B5%D0%B5_100_%D1%82%D1%8B%D1%81%D1%8F%D1%87_%D0%B6%D0%B8%D1%82%D0%B5%D0%BB%D0%B5%D0%B9"
temp <- link %>%
        read_html() %>%
        html_nodes(xpath = '//*[@id="mw-content-text"]/div[1]/table[1]') %>%
        html_table(fill = TRUE)
popCities <- as.data.frame(temp[[1]])
popClean <- popCities
names(popClean) <- popClean[1,]
names(popClean)[1:3] <- c("rank", "rank1897", "city")
popClean <- popClean[-1,]
pop10 <- popClean[1:10,-c(1,2)]
pop10[1,1] <- "Москва"
pop10[,2:20] <- sapply(pop10[,2:20], as.numeric)
pop10 <- pop10 %>%
        pivot_longer(-city, names_to = "year", values_to = "population")
pop10$year <- as.numeric(pop10$year)
pop10$population <- pop10$population * 1000


ggplot(pop10, aes(year, population, color = city)) +
        geom_point()
plot_ly(pop10, x = ~year, y = ~population, color = ~city, 
        type = "scatter", mode= "lines+markers")



cityCoord <- data.frame(lat = c(55.755826, 59.931058, 54.983269, 56.843099, 55.787894, 56.326868, 55.164442, 53.203772, 54.991355, 47.235714),
                        lng = c(37.6173, 30.36091, 82.896383, 60.645409, 49.123329, 44.005879, 61.436843, 50.160638, 73.36452, 39.701505))
cities <- cbind(popClean$city[1:10], popClean[1:10,"2020"], cityCoord)
names(cities) <- c("city", "population", "lat", "lng")
cities[1,1] <- "Москва"

cities %>%
        leaflet() %>%
        addTiles() %>%
        addCircles(weight = 2,radius = ~sqrt(population) * 1000, popup = ~city)
