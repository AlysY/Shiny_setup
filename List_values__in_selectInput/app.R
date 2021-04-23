#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)

# Define UI for application that draws a histogram
ui <- fluidPage(

    # Application title
    titlePanel("Variations on the select input"),

    # Sidebar with a slider input for number of bins 
    sidebarLayout(
        sidebarPanel(
          h4("Vector of options"),
            selectInput("choices_vector", "Choices as a vector",
                        choices = c("A", "B", "1", "2", "c", "d")),
            br(),
            
          h4("Vector of options with a switch of values"),
            selectInput("choices_vector_switch", "Choices vector which switches",
                        choices = c("A" = "AA", "B" = "BB", "1" = "11", "2" = "22", "c" = "cc", "d" = "dd")),
            br(),
            
          h4("List of options"),
            selectInput("choices_list", "Choices list",
                        choices = list(
                           "Letters caps" = list("A", "B"), 
                           "Numbers" = list("1", "2"), 
                           "Letters lower" = list("c", "d"))),
            
            br(),    
          h4("List of options with a switch of values"),
            selectInput("choices_list_switch", "Choices list with switches",
                        choices = list(
                          "Letters caps" = list("A" = "AA", "B" = "BB"), 
                          "Numbers" = list("1" = "11", "2" = "22"), 
                          "Letters lower" = list("c" = "cc", "d" = "dd"))),
            
            br(),
          h4("Vector of options with a switch on half of the values"),
            selectInput("choices_list_halfswitch", "Choices list with switches",
                        choices = list(
                          "Letters caps" = list("A" = "AA", "B"), 
                          "Numbers" = list("1" = "11", "2"), 
                          "Letters lower" = list("c", "d" = "dd")))
            
        ),

        # Show a plot of the generated distribution
        mainPanel(
          h4("Vector of options"),
           textOutput("t_choices_vector"),
          br(),
          
          h4("List of options"),
          textOutput("t_choices_list"),
          br(),
          
          h4("List of options with a switch of values"),
          textOutput("t_choices_list_switch"),
          br(),
          
          h4("Vector of options with a switch on half of the values"),
          textOutput("t_choices_list_halfswitch"),
          br()
          
        )
    )
)

# Define server logic required to draw a histogram
server <- function(input, output) {
  
  output$t_choices_vector

}

# Run the application 
shinyApp(ui = ui, server = server)
