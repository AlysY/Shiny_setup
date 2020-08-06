## Making your own shiny app ##


## 1. Load the required packages ##
install.packages("shiny")
install.packages("titanic")


library(shiny)
library(titanic)


# data 
titanic_train

## 2. The user interface ##
# What the user sees on the website

ui <- fluidPage(
 
  
)


## 3. The server ##
# What R is doing in the background
server <- function(input, output){
  
  
}


## 4. Combine the user interface and server
shinyApp(server=server, ui=ui)
