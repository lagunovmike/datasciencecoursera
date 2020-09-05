library(shiny)
library(plotly)
library(shinythemes)

companies <- read.csv("companies.csv", encoding = "utf-8")
countries <- unique(companies$country)

# Define UI for application
shinyUI(fluidPage( theme = shinytheme("yeti"),
                   titlePanel("Startups in different countries"),
                   sidebarLayout(
                     sidebarPanel(
                       p("Select a country you would like to check:"),
                       selectInput("Country", "Country:", countries, selected =  "Belarus")
                     ),
                     mainPanel(
                       tabsetPanel(type = "tabs",
                                   tabPanel("Table", tableOutput("companies")),
                                   tabPanel("Plot", h2("Startup distribution by cities"),
                                            p("May take a little time to compute"),
                                            plotlyOutput("plot")),
                                   tabPanel("Documentation", 
                                            h1("Project info"),
                                            p("In this shiny website you can see startups, 
                           located by different countries. Select a country you 
                             would like to see in the left side"),
                                            p("The first tab you will get a table, resulting 
                           all the startups in the country, 
                             containing startups name, address, country and city"),
                                            p("The second tab you will see a pie chart of 
                             startups distribution by cities in the chosen country"),
                                            
                                            h3("Disclaimer"),
                                            p("All the data have been received through open resources"),
                                            h3("Contact"),
                                            p("Write me an email: lagunovmike@yahoo.com"))
                       )
                     )
                   )
))