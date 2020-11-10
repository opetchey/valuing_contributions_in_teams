library(shiny)
library(googlesheets)

shinyUI(
  fluidPage(
    
    titlePanel("Valuing contributions in teams"),
    includeMarkdown("intro.md"),
    sidebarLayout(
      sidebarPanel(
        
        textInput("gs_path", "Google sheet URL",
                  value = "https://docs.google.com/spreadsheets/d/1jw3rfSDpQbT-IfgGsCbYSy7XIe92UiZqCFw8zMZcLRM",
                  width = NULL, placeholder = NULL)
        
     
      
        #selectInput("wss", "Worksheet!!!",
        #            choices = c("team members", "Americas", "Asia",
        #                        "Europe", "Oceania"))
        
      ),
      
      mainPanel(
        #verbatimTextOutput("gs_info")
        #DT::dataTableOutput("the_data")
        textOutput("text0"),
        textOutput("text1")
      )
    )
  ))