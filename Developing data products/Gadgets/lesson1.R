library(shiny)
library(miniUI)

myFirstGadget <- function(){
        ui <- miniPage(
                gadgetTitleBar("My First Gadget")
        )
        server <- function(input, output, session){
                observeEvent(input$done, {
                        print("Done")
                        stopApp()
                })
                observeEvent(input$cancel, {
                        stopApp()
                })
        }
        runGadget(ui, server)
}
myFirstGadget()
