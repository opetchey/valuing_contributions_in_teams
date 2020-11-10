
library(googlesheets4)
library(dplyr)
library(readxl)
library(rorcid)
library(shiny)
library(DT)



shinyServer(function(input, output, session) {
  
  goosh <- reactive({
    input$gs_path
  })
  
  #val <- reactive(
  #  gs_url(goosh())
  #)
  
  #output$gs_info <- renderPrint(print(val()))
  
  output$text1 <- reactive <- renderText({
    
    project_info <- read_sheet("https://docs.google.com/spreadsheets/d/1jw3rfSDpQbT-IfgGsCbYSy7XIe92UiZqCFw8zMZcLRM",
                               sheet = "project information")
    team_members <- read_sheet("https://docs.google.com/spreadsheets/d/1jw3rfSDpQbT-IfgGsCbYSy7XIe92UiZqCFw8zMZcLRM",
                               sheet = "team members")
    contributions <- read_sheet("https://docs.google.com/spreadsheets/d/1jw3rfSDpQbT-IfgGsCbYSy7XIe92UiZqCFw8zMZcLRM",
                                sheet = "contributions")
    
    contribution_text <- character(length(team_members$ORCID))
    for(i in 1:length(team_members$ORCID)) {
      moi <- team_members$`Full name (locked)`[i]
      moi_contributions <- contributions[contributions$Person == moi,] %>%
        pull(`Contribution type`)
      contribution_text[i] <- paste0(team_members$`First name`[i], " ", team_members$`Last name`[i],
                                     " (ORCID: ", team_members$ORCID[i], "): ",
                                     paste0(moi_contributions, collapse = "; "),
                                     ".")
    }
    
    print(contribution_text)
    
   
  })
  
  
})




