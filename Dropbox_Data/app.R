## Data entry shiny app

# For Dave Duncan 
# From Alys Young
# April, 2021

# Aim: Have concurrent users that are saving to the dataframe
# method: save the data in dropbox. when the user clicks to submit their data
# the data file will be downloaded, add their rows, then upload.
# Therefore the only issue with concurrent users is if people submit within ~3 sec of eachother.

library(rdrop2)
library(shiny)

# Define UI for application that draws a histogram
ui <- fluidPage(
    
    # Application title
    titlePanel("Data entry with R and dropbox"),
    
    # Sidebar with a slider input for number of bins 
    sidebarLayout(
        sidebarPanel(
            textInput("name",
                      label = "What is your name?",
                      placeholder = "Enter name here"),
            br(),
            selectInput("month",
                        label = "What is the month?",
                        choices = c("January", "Feburary", "March", "April",
                                    "May", "June", "July", "August", "September",
                                    "October", "November", "December")),
            br(),
            numericInput("year",
                         "What year is it?",
                         value = 2021,
                         min=2020),
            br(),
            
            textInput("notes", label = "Do you have any other comments?", placeholder = "Enter comments here"),
            br(),
            actionButton("submit", "Submit data")
        ),
        
        # Show a plot of the generated distribution
        mainPanel(
            h3("As the data is entered, new rows should appear"),
            tableOutput("table_new")
        )
    )
)

# Define server logic required to draw a histogram
server <- function(input, output, session) {
    
    # empty reactive vals
    vals <- reactiveValues(data = 0)
    
    
    observeEvent(input$submit, {
        vals$data <- NULL
        drop_download("dropbox_test_r/test1.csv", overwrite = TRUE)
        test2 <- read.csv("test1.csv")
        
        data_entry <- data.frame(name = input$name, month = input$month, year = input$year, notes = input$notes)
        data_added <- rbind(test2,data_entry)
        write.csv(data_added, 'test1.csv', row.names = FALSE)
        drop_upload('test1.csv', path = "dropbox_test_R")
        
        vals$data <- data_added
        
    })
    
    
    test2 <- reactive({
        req(vals$data)
        drop_download("dropbox_test_r/test1.csv", overwrite = TRUE)
        test2 <- read.csv("test1.csv")
        
        test2
    })
    
    output$table_new <- renderTable({
        test2()
    })
    
    
}

# Run the application 
shinyApp(ui = ui, server = server)
