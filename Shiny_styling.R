#####################
### Shiny styling ###
#####################


############################
### Theme from bootstrap ###
############################
# Good for setting a whole website to the same page

# Save the .css file into a folder called www in the main folder of your shiny app ( main folder will also contain either the app.r or the ui.r/server.r files)


ui <- fluidPage(theme = "bootstrap.css",
                
                titlePanel("My Application")
                
                # application UI              
)



###############################################
### HTML CSS coding straight into the file  ###
###############################################
# Good for one offs
# Good to tweak the current style
# dont do a whole website like this


library(shiny)

ui <- fluidPage(
  fluidRow(
    column(style='border: 1px solid grey; 
           background-color: lightgrey;
           color: red',
           width=4,
           p('Hello')
    ),
    
    column(
      width=8,
      p('World')
    )
  )
)

server <- function(input,output) {}

shinyApp(ui,server)

