library(shinydashboard)
library(shiny)

ui <-dashboardPage(
  skin = "red",
  dashboardHeader(title = "Mein Fash Dash"),
  dashboardSidebar(
    
sidebarMenu(
  menuItem("Overview", tabName = "overview", icon = icon("home")),
  menuItem("Mein Kampf", tabName = "mk", icon = icon("skull")),
  hr()
  )
    
  ),
  dashboardBody(fluidRow(column(1,verbatimTextOutput("value"))))
)

server <- function(input, output) {

  }

shinyApp(ui, server)

