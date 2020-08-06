## Making your own shiny app ##

# Examples of widgets #
  # items on the user interface that the user interacts with
  # these widgets will need an inputId that is save to the input list and can be called in the server using input$

## 1. Load the required packages ##
install.packages("shiny")
library(shiny)


## 2. The user interface ##
# What the user sees on the website

ui <- fluidPage(
  
  h1("Examples of Widgets"), # Main title
  h2("Practice using different widgets in Shiny apps"), # sub title
  p("Here is some example code of different widgets so you can see how they look and how to code them"), # paragraph text
  
  tags$br(), # breaks in the text
  tags$br(),
  tags$br(),
  
  strong("Reactive text"),
  textOutput(outputId = "sp"),
  em("To input a piece of text that reacts to the inputs from the user, you must put the expression in the server and then render the text using renderText to be able to call it in the user interface with textOutput "),
  
  tags$br(), # breaks in the text
  tags$br(),
  tags$br(),
  
  selectInput(inputId = "species", # to call this input in the server, use input$species
              label = "Select a threatened species to investigate:", # the title of the box that the user will see
              choices = c( # "what the user sees" = "what R sees",
                          "Black-flanked Rock-wallaby" = "P.lateralis",
                          "Pink Pimelea" = "P.ferruginea",
                          "Eastern Curlew" = "N.madagascariensis",
                          "Gouldian Finch" = "E.gouldiae",
                          "Northern Quoll" = "D.hallucatus"),
              multiple =FALSE), # dont allow multiple option
  
  # Multiple check boxes 
  checkboxGroupInput(inputId = "process", # to call this input in the server, use input$process
                     label = "Which threatening process do you want to look at?",
                     choices = c("Inappropriate fire regimes" = "fire",
                                 "Over-grazing" = "grazer",
                                 "Invasive predators" = "invasive_pred",
                                 "Invasive species" = "invasive_all",
                                 "Hunting or overharvesting yikes" = "hunt")),
  
  radioButtons(inputId = "state",
               label = "What area would you like to cover?",
               choices = c("Whole of Australia" = "Aus",
                           "New South Wales" = "NSW",
                           "Victoria The isolation state)" = "Vic",
                           "Tasmania (are they part of Aus???)" = "Tas")),
  # Slider from one end
    # also option of from two ends to allow a date range for example
  sliderInput(inputId = "year", # to call this input in the server, use input$year
              label = "which year do you want to look at?",
              min = 2001, # minimum value
              max = 2020, # maximum value
              value = 2019, # the default value
              step = 1, # go up by increments of 1
              sep = "", # seperate the thousands this no marker
              round = TRUE), # round to the nearest whole number
  
  # Text input
    # user will enter a section of tex
 textInput(inputId = "question", # to call this input in the server, use input$question
           label = "Why do you can about threatened species?",
           value = "e.g. just love nature"),
 
 # print the output called question_answer
 textOutput(outputId = "question_answer"),
 
 # Numeric input
  # allow your user to enter their own number
 numericInput(inputId = "question",
              label = "how many animals have you hugged today?",
              value = 15,
              min = 0),
 
 # An action button
  # you can use this to trigger reactive events
  # e.g. dont update the plots or maps until this button is presse
 actionButton(inputId = "update",
              label = "Updat the map")

)


## 3. The server ##
# What R is doing in the background
server <- function(input, output){
  output$question_answer <- renderText(input$question )
  
  output$sp <- renderText(paste0("Investigating ",input$species, " in ", input$year ))
}


## 4. Combine the user interface and server
shinyApp(server=server, ui=ui)









