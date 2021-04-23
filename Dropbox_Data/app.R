## Data entry shiny app

# For Dave Duncan 
# From Alys Young
# April, 2021

# Aim: Have concurrent users that are saving to the dataframe
# method: save the data in dropbox. when the user clicks to submit their data
# the data file will be downloaded, add their rows, then upload.
# Therefore the only issue with concurrent users is if people submit within ~3 sec of eachother.






## Set up  ---------------------------------------------------------------------------------------------------------------------------------

# Run script 1 and 2 first

## Load packages
if (!require(rdrop2)) install.packages('rdrop2')
if (!require(shiny)) install.packages('shiny')

library(rdrop2)
library(shiny)







## User interface ------------------------------------------------------------------------------------------------------
ui <- fluidPage(
    
    # Application title
    titlePanel("Data entry with R and dropbox"),
    
    # Sidebar with a slider input for number of bins 
    sidebarLayout(
        
        # on the left
        sidebarPanel(
            
            # enter text
            textInput("name",
                      label = "What is your name?",
                      placeholder = "Enter name here"),
            br(),
            
            # select a month
            selectInput("month",
                        label = "What is the month?",
                        choices = c("January", "Feburary", "March", "April",
                                    "May", "June", "July", "August", "September",
                                    "October", "November", "December")),
            br(),
            
            # select a number
            numericInput("year",
                         "What year is it?",
                         value = 2021,
                         min=2020),
            br(),
            
            # enter text
            textInput("notes", label = "Do you have any other comments?", placeholder = "Enter comments here"),
            br(),
            
            # submit data
            actionButton("submit", "Submit data")
        ),
        
        # Show table with the added data
        mainPanel(
            
            # title
            h3("As the data is entered, new rows should appear"),
            
            # the table
            tableOutput("table_new")
        )
    )
)














## Server --------------------------------------------------------------------------------------------------------------------------------
server <- function(input, output, session) {
    
    # empty reactive vals
    vals <- reactiveValues(data = 0)
    
    # Observe when the submit button is clicked
    observeEvent(input$submit, {
        
        # make the values null, this means the block of code will run
        vals$data <- NULL
        
        # Download the data from dropbox
        drop_download("dropbox_test_r/test1.csv", overwrite = TRUE)
        
        # read the data
        test2 <- read.csv("test1.csv")
        
        # turn the user inputs into a dataframe
        data_entry <- data.frame(name = input$name, month = input$month, year = input$year, notes = input$notes)
        
        # Add the rows for the new data entry
        data_added <- rbind(test2,data_entry)
        
        # save the file
        write.csv(data_added, 'test1.csv', row.names = FALSE)
        
        # upload to drop box
        drop_upload('test1.csv', path = "dropbox_test_R")
        
        # give vals a value, this allows the table to be made
        vals$data <- data_added
        
    })
    
    # get the new data
    test2 <- reactive({
        
        # requires that vals has a values. only once the data has been uploaded again
        req(vals$data)
        
        # Download the new data
        drop_download("dropbox_test_r/test1.csv", overwrite = TRUE)
        
        # read it
        test2 <- read.csv("test1.csv")
        
        # show it
        test2
    })
    
    # create a table with the new data
    output$table_new <- renderTable({
        test2()
    })
    
    
}










# Run app -----------------------------------------------------------------
shinyApp(ui = ui, server = server)
