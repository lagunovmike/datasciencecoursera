library(shiny)

# Define UI for application that draws a histogram
shinyUI(fluidPage(
    titlePanel("Predict Horsepower from MPG"),
    sidebarLayout(
        sidebarPanel(
            sliderInput(inputId = "sliderMPG", label = "What is the MPG of the car?",
                        10, 35, value = 20),
            checkboxInput("showModel1", "Show/Hide Model 1", value = TRUE),
            checkboxInput("showModel2", "Show/Hide Model 2", value = TRUE),
            submitButton("Submit!")
        ),
        mainPanel(
            plotOutput("plot1"),
            h3("Predict Horsepower from Model 1:"),
            textOutput("pred1"),
            h3("Predict Horsepower from Model 2:"),
            textOutput("pred2")
        )
    )
))