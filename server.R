
library(shiny)
library(googlesheets)
library(DT)
library(tidyverse)


shinyServer(function(input, output, session) {
  
  goosh <- reactive({
    input$gs_path
  })
  
  val <- reactive(
    gs_url(goosh())
  )
  
  output$gs_info <- renderPrint(print(val()))
  
  output$plot1 <- reactive <- renderPlot({
    members <- val() %>% gs_read(ws="team members")
    roles <- val() %>% gs_read(ws="contribution types and weights")
    planned <- val() %>% gs_read("planned contributions")
    realised <- val() %>% gs_read("realised contributions")
    decisions <- val() %>% gs_read("project information")
    threshold_contribution_for_authorship <- decisions %>%
      filter(parameter=="threshold contribution for authorship") %>%
      type.convert() %>%
      pull(value)
    project_name <- decisions %>%
      filter(parameter=="project name") %>%
      pull(value)
    
    # Calculate planned contributions
    planned_contributions <- full_join(planned, roles) %>%
      mutate(score=Value*Weighting) %>%
      group_by(Person) %>%
      summarise(total=sum(score)) %>%
      right_join(members) %>%
      mutate(total=ifelse(is.na(total),
                          0,
                          total)) %>%
      mutate(type="planned")
    
    realised_contributions <- full_join(realised, roles) %>%
      mutate(score=Value*Weighting) %>%
      group_by(Person) %>%
      summarise(total=sum(score)) %>%
      right_join(members) %>%
      mutate(total=ifelse(is.na(total),
                          0,
                          total)) %>%
      mutate(type="realised")
    
    contributions <- bind_rows(planned_contributions,
                               realised_contributions)
    plot(1,1)
    #ggplot(contributions,
    #       aes(x=Person, y=total, fill=type)) +
    #  geom_col(position = "dodge2") +
     # geom_hline(yintercept = threshold_contribution_for_authorship,
     #            col="red", size=2, linetype="dashed") +
     # ggtitle(paste0("Project name: ", project_name)) +
     #ylab("Total contribution") +
      #theme(legend.title = element_blank())
  })
  
  
})




