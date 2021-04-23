# Shiny alerts
# Created by Dean Attali
# https://daattali.com/shiny/shinyalert-demo/


library(shiny)
library(shinyalert)

ui <- fluidPage(
  useShinyalert()
)

server <- function(input, output) {
  shinyalert(
    title = "Welcome",
    text = "This website is to ~. Here is some information ",
    size = "s", 
    closeOnEsc = TRUE,
    closeOnClickOutside = TRUE,
    html = FALSE,
    type = "info",
    showConfirmButton = TRUE,
    showCancelButton = FALSE,
    confirmButtonText = "OK",
    confirmButtonCol = "#AEDEF4",
    timer = 0,
    imageUrl = "",
    animation = TRUE
  )
}

shinyApp(ui, server)