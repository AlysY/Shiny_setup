## Basic set up of a shiny app ##



## 1. Load the required packages ##
install.packages("shiny")
library(shiny)


## 2. The user interface ##
# What the user sees on the website

ui <- fluidPage(

  # the things that the user will see
  
)


## 3. The server ##
# What R is doing in the background

server <- function(input,output, session){
  
  # The code that R will run
  
}


## 4. Combine the user interface and server
shinyApp(server=server, ui=ui)



## The shiny gallery
# https://shiny.rstudio.com/gallery/

## A great example of a shiny website
# https://shiny.rstudio.com/gallery/covid19-tracker.html 

## Tutorial by R
# https://shiny.rstudio.com/tutorial/
  
## Widgets
# https://shiny.rstudio.com/tutorial/written-tutorial/lesson3/
  