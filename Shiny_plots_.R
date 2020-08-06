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


  ## Select an input from a drop down list
  selectInput(inputId = "class", # The name of the variable in the input list 
              label = "Select the class of passenger:", # the label on the website that the user will see
              choices = c( # "what the user will see" = "What R will see",
                          "First Class" = "1", # the options on the drop down list
                          "Second Class" = "2",
                          "Third Class" = "3"),
              multiple = FALSE), # Allow multiple options to be selected
  
  ## Write an input in a text box
  textInput(inputId = "plot_title", # The name of the variable in the input list 
            label = "enter a title for the plot",# the label on the website that the user will see
            value = "Plot title"),# the default option that it will start on
  

  plotOutput(outputId = "plot1")  # our first plot will be displayed using this
  
)


## 3. The server ##
# What R is doing in the background
server <- function(input, output){
  

            output$plot1 <- renderPlot({ # saved to the output list as "plot1"
              plot(Fare ~ Age, 
                   data = titanic_train[titanic_train$Pclass == input$class,], # subsetting the data using an input from the user
                   main= input$plot_title) # the title the user can add to the plot
          }
          )

}


## 4. Combine the user interface and server
shinyApp(server=server, ui=ui)











#install.package("dplyr")
#install.package("ggplot2")
library(dplyr)
library(ggplot2)
titanic_train  %>%
  filter(Pclass==input$class) %>%
  ggplot(aes(x = Age, y = Fare)) + 
  geom_point(aes(shape = Sex, colour = Survived)) +
  ggtitle(label = input$plot_title) +
  theme_bw() 