###########################
### Interesting widgets ###
###########################



library(shinyWidgets)

if (interactive()) {
  shinyWidgets::shinyWidgetsGallery()
}

#####################
### Dropdown menu ###
#####################
# Select multiple
pickerInput(
  inputId = "Id083",
  label = "Multiple", 
  choices = attr(UScitiesD, "Labels"),
  multiple = TRUE
)

# list in the option
pickerInput(
  inputId = "Id082",
  label = "Options group", 
  choices = list(
    lower = c("a", "b", "c", "d"),
    upper = c("A", 
              "B", "C", "D"))
)

# subtext on the options
pickerInput(
  inputId = "Id093",
  label = "Subtext", 
  choices = rownames(mtcars),
  choicesOpt = list(
    subtext = paste("mpg", 
                    mtcars$mpg,
                    sep = ": "))
)

# select/deselect all
pickerInput(
  inputId = "Id094",
  label = "Select/deselect all options", 
  choices = LETTERS,
  options = list(
    `actions-box` = TRUE), 
  multiple = TRUE
)

# move from panel on left to right
multiInput(
  inputId = "Id010",
  label = "Countries :", 
  choices = NULL,
  choiceNames = lapply(seq_along(countries), 
                       function(i) tagList(tags$img(src = flags[i],
                                                    width = 20, 
                                                    height = 15), countries[i])),
  choiceValues = countries
)





###############
### Sliders ###
###############

## Change colour
if (interactive()) {
  library(shiny)
  library(shinyWidgets)
  ui <- fluidPage(

# only customize the 2 first sliders and the last one
# the color of the third one is empty
setSliderColor(c("DeepPink ", "#FF4500", "", "Teal"), c(1, 2, 4)),
sliderInput("obs", "My pink slider:",
            min = 0, max = 100, value = 50
),
sliderInput("obs2", "My orange slider:",
            min = 0, max = 100, value = 50
),
plotOutput("distPlot")
)
server <- function(input, output) {
  output$distPlot <- renderPlot({
    hist(rnorm(input$obs))
  }) }
shinyApp(ui, server)
}
