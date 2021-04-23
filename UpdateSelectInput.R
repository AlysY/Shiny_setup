## Dynamic select input choices based on other inputs

# From:
# https://stackoverflow.com/questions/34080629/dynamic-selectinput-in-r-shiny



library(shiny)
library(shinydashboard)


ui <- dashboardPage(
  dashboardHeader(title = "Dynamic selectInput"),
  dashboardSidebar(
    sidebarMenu(
      menuItemOutput("menuitem")
    )
  ),
  dashboardBody(
    selectInput("heir1","Heirarchy1",c("NONE","A","B","C"),selected="NONE"),
    selectInput("heir2","Heirarchy2",c("NONE","A","B","C"),selected="NONE"),
    selectInput("heir3","Heirarchy3",c("NONE","A","B","C"),selected="NONE")
  )
)

server <- function(input, output, session) {
  output$menuitem <- renderMenu({
    menuItem("Menu item", icon = icon("calendar"))
  })
  
  heirarchy<-c("A","B","C")
  
  observe({
    hei1<-input$heir1
    hei2<-input$heir2
    hei3<-input$heir3
    
    choice1<-c("NONE",setdiff(heirarchy,c(hei2,hei3)))
    choice2<-c("NONE",setdiff(heirarchy,c(hei1,hei3)))
    choice3<-c("NONE",setdiff(heirarchy,c(hei1,hei2)))
    
    updateSelectInput(session,"heir1",choices=choice1,selected=hei1)
    updateSelectInput(session,"heir2",choices=choice2,selected=hei2)
    updateSelectInput(session,"heir3",choices=choice3,selected=hei3)
    
  })
  
}

shinyApp(ui, server)