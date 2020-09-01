library(plotly)
data(mtcars)
mydata <- mtcars
plot_ly(data = mydata,x = ~wt, y = ~mpg, type = "scatter", mode = "markers",
        color = ~disp, size = ~hp)
head(mtcars)
names(mtcars)


plot_ly(data = mydata,x = ~wt, y = ~mpg, z = ~disp, type = "scatter3d", mode = "markers",
        color = ~cyl)

data("airmiles")


plot_ly(x = time(airmiles), y = airmiles, type = "scatter", mode = "lines")


library(tidyr)
library(dplyr)
data("EuStockMarkets")
stocks <- as.data.frame(EuStockMarkets) %>%
        gather(index, price) %>%
        mutate(time = rep(time(EuStockMarkets), 4))
head(stocks)
stocks <- as.data.frame(stocks)
plot_ly(stocks, x = ~time, y = ~price, color = ~index, 
        type = "scatter", mode = "lines")


## GGplot to plotly
library(ggplot2)
diamondsSub <- diamonds[1:10000,]
g <- ggplot(data = diamondsSub, aes(x = carat, y = price)) +
        geom_point(size = 4) +
        geom_smooth(aes(color = cut, fill = cut)) +
        facet_wrap(~cut)
g

gg <- ggplotly(g)
gg
plotly_POST(gg)
warnings()
plotly
api_create(gg, username = "LagunovMike")
