# Leaflet lectures

library(leaflet)
my_map <- leaflet() %>%
        addTiles()
my_map

my_map <- my_map %>%
        addMarkers(lat = 12.220171, lng = 109.200684, popup = "Current Home")
my_map


myPins <- data.frame(lat = runif(10000, min = 12.2, max = 12.3),
                     lng = runif(10000, min = 109.15, max = 109.25))

vietnamFlag <- makeIcon("https://upload.wikimedia.org/wikipedia/commons/thumb/2/21/Flag_of_Vietnam.svg/2000px-Flag_of_Vietnam.svg.png",
                       iconWidth = 1024/35, iconHeight = 640/35,
                       iconAnchorX = 1024/35/2, iconAnchorY = 640/35/2)

myPins %>% 
        leaflet() %>%
        addTiles() %>%
        addMarkers(icon = vietnamFlag, clusterOptions = markerClusterOptions())
