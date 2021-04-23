ui =  tagList(
  tags$head(tags$style(HTML("
                           .navbar-nav {
                           float: none !important;
                           }
                           .navbar-nav > li:nth-child(4) {
                           float: right;
                           }
                           
                           .navbar-nav > li:nth-child(5) {
                           float: right;
                           ## need something else here
                           }
                           "))),
  navbarPage(
    title = "My app",
    navbarMenu("Left1",
               tabPanel("Subleft11"),
               tabPanel("Subleft12")),
    tabPanel("Left2"),
    tabPanel("Left3"),
    
    #tabPanel("Right2"),
    tabPanel("Right1")
  )
)

server <- function(input, output, session) {}

shinyApp(ui, server)
