## Making your own shiny app ##

## Tutorial on leaflet and integrating with shiny
# http://rstudio.github.io/leaflet/


## 1. Load the required packages ##
install.packages("shiny")
install.packages("leaflet")


library(shiny)
library(leaflet)

## Data
dat_map <- data.frame(place = c("Melb Uni", "Fishes"),
                      longitude = c(144.9610, 144.9652),
                      latitude = c(-37.7983, -37.88098))


## 2. The user interface ##
# What the user sees on the website

ui <- fluidPage(
  
 h1("A map of victoria"), # the main title
 p("Heres a neat way to display some spatial outputs or maps"), # a piece of paragraph text
 
  leafletOutput("map_victoria") # the leaflet output, called using its output$Id
 
)


## 3. The server ##
# What R is doing in the background
server <- function(input, output){
  
  output$map_victoria <- renderLeaflet({
    leaflet( data = dat_map) %>%
      setView(lng = 145.0, lat = -37.5, zoom = 7) %>%
      addTiles() %>%
      addMarkers(~longitude, ~latitude,  label = dat_map$place)
  })
  
  
}


## 4. Combine the user interface and server
shinyApp(server=server, ui=ui)
