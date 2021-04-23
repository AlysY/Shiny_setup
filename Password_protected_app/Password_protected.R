## A password protected app
  # Which display is based on which user is logged in 

# 1. Load libraries
library(shiny)
library(shinymanager)
library(dplyr)

# 2. Set the log in information
credentials <- data.frame(
  user = c("setosa", "versicolor", "virginica", "admin"), # mandatory
  password = c("p_setosa", "p_versicolor", "p_virginica", "p_admin"), # mandatory
  admin = c(FALSE, FALSE, FALSE, TRUE),
  stringsAsFactors = FALSE
)

# 3. User Interface
ui <- fluidPage(
  
  # Application title
  titlePanel("Iris Data subsetted by user"),
  h4("Password protected to only show the species that was used to log in"),
  
  # Sidebar with a slider input for number of bins 
  sidebarLayout(
    sidebarPanel(
      textOutput("text")
    ),
    
    # Show a plot of the generated distribution
    mainPanel(
      plotOutput("distPlot")
    )
  )
)

# Wrap your UI with secure_app
ui <- secure_app(ui)




# 4. Server
server <- function(input, output, session) {
  
  # call the server part
  # check_credentials returns a function to authenticate users
  res_auth <- secure_server(
    check_credentials = check_credentials(credentials)
  )
  
  output$auth_output <- renderPrint({
    reactiveValuesToList(res_auth)
  })
  
  
  # The usual server
  iris_df <- reactive({
    if(res_auth$admin == TRUE) {
      iris_df <- iris
    } else if(res_auth$admin != TRUE) {
      iris_df <- iris %>% filter(Species == res_auth$user)
    }
  })
  
  # The species being shown
  output$text <- renderText({
    res_auth$user
  })
  
  # your classic server logic
  output$distPlot <- renderPlot({
    iris_df <- iris_df()
    plot(iris_df$Petal.Length, iris_df$Sepal.Length)
  })
}



# 5. Run app
# Run the application 
shinyApp(ui = ui, server = server)
