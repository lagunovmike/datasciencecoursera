library(shiny)
library(dplyr)
library(kableExtra)
companies <- read.csv("companies.csv", encoding = "utf-8")


shinyServer(function(input, output, session) {
    
    output$companies <- function() {
        comp <-  companies %>% 
            select(name, country, city, address) %>%
            filter(country == input$Country) %>%
            knitr::kable("html") %>%
            kable_styling("striped", full_width = F)
        
    }
    
    tbl <- reactive({
        companies %>%
            filter(country == input$Country) %>%
            group_by(city) %>%
            summarize(freq = n(), .groups = "drop") %>%
            arrange(desc(freq))
    })
    
    output$plot <- renderPlotly({
        plot_ly(data = tbl(), values = ~freq, labels = ~city, type = "pie")
    })
})