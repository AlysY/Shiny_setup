## Hierarchical select input tree ##

# Code sourced from:
# https://stackoverflow.com/questions/30592873/shiny-hierarchical-nested-checkboxgroupinput


library(shiny)
library(shinyTree)


server <- shinyServer(function(input, output, session) {  
  # output$tree <- renderTree({ 
  #   list(  'I lorem impsum'= list( 
  #     'I.1 lorem impsum'   =  structure(list('I.1.1 lorem impsum'='1', 'I.1.2 lorem impsum'='2'),stselected=TRUE),  
  #     'I.2 lorem impsum'   =  structure(list('I.2.1 lorem impsum'='3'), stselected=TRUE))) 
  # })
  
  output$tree <- renderTree({
    list(
      NT = structure(list(Darwin=structure("Darwin", stinfo = "Darwin"), AliceSprings = structure("AliceSprings",stinfo="AliceSprings")), stselected=TRUE),
      QLD = structure(list(Townsville = "Townville", Gove = "Gove", OtherQLD = "OtherQLD"), stselected=FALSE),
      WA = structure(list(Kimberley = "Kimberley", Perth = "Perth"), stselected=FALSE)
      )
  })
  
  
  output$selTxt <- renderText({
    tree <- input$tree
    if (is.null(tree)){
      "None"
    } else{
      unlist(lapply(get_selected(tree),function(node){
        attr(node, "stinfo")
      }))
    }
  })
})




ui <- shinyUI(
  shiny::fluidPage(
    h4('Shiny hierarchical checkbox'),
    shinyTree("tree", checkbox = TRUE, theme="proton"),
    "Currently Selected:",
    verbatimTextOutput("selTxt")
  )
)
shinyApp(ui, server)



runApp(system.file("examples/02-attributes", package = "shinyTree"))
runApp(system.file("examples/03-checkbox", package = "shinyTree"))
runApp(system.file("examples/09-themes", package = "shinyTree"))
runApp(system.file("examples/12-types", package = "shinyTree"))
runApp(system.file("examples/13-icons", package = "shinyTree"))
runApp(system.file("examples/15-data", package = "shinyTree"))
