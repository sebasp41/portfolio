library(shiny)
library(rsconnect)

#datasort


shinyUI(fluidPage(
  titlePanel("NCAA Men's Basketball Team Efficiency"),
  sidebarLayout(
    sidebarPanel(
      selectInput("dataset", h5("Choose subset"), 
                  choices = c("cars", "longley", "MLB","rock", "pressure")),        
      HTML('</br>'),
      uiOutput('dv'),    
      HTML('</br>'),
      uiOutput('iv'),
      HTML('</br>')),
mainPanel(
      ))))                         

server <- function(input, output) {
   

}
shinyApp(ui = ui, server = server)

