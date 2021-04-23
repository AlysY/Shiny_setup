## How to change the inputs based on the tabset selected ##



if (!require(shiny)) install.packages('shiny')
library(shiny)







## Inclusionary ##
  # If year is chosen on the main panel, only show the year inputs

ui <- fluidPage(
  sidebarLayout(
  sidebarPanel(

    conditionalPanel(
      condition = "input.tabs == 'year'",  #ns = NS(NULL),
      h4("Year inputs"),
      
      sliderInput(inputId = "year",
                  label = "Choose the year",
                  value = 2020, # default value
                  min = 2007,
                  max = 2020,
                  step = 1,
                  sep = "",
                  round = TRUE,
                  ticks = FALSE),

      verbatimTextOutput("year")
      
    ), # End conditionalPanel
    
    conditionalPanel(
      condition = "input.tabs == 'region'",  #ns = NS(NULL),
      h4("Region inputs"),
      selectInput(inputId = "region", 
                  label = "Select region:",
                  choices = c("Region 1", "Region 2", "Region 3", "Region 4"),
                  selected = NULL, # none selected as the default when the app opens
                  multiple = FALSE),
      
      verbatimTextOutput("region")
    ), # End conditionalPanel
    
    conditionalPanel(
      condition = "input.tabs == 'letter' ",
      h4("Letter inputs"),
      radioButtons(inputId = "letter",
                   label = "Choose a letter",
                   selected = character(0),
                   choices = c("A", "B", "C")),

      verbatimTextOutput("letter")
      
    ) # End conditionalPanel
  ),    # End sidebarPanel
  
  
  mainPanel(
    tabsetPanel(
      type = "tabs", id = "tabs",
      tabPanel(id = "year", value = "year",
               "Compare years",

      ),
      tabPanel(id = "region", value = "region",
               "Compare regions",
               
      ),
      tabPanel(id = "letter", value = "letter",
               "compare letters",
               
      )# Close tabpanel Transport results
    ) # Close tabset tabs_a
  ) # End mainPanel  
  )   # End sidebarLayout
  ) # End fluidPage    

  server <- function(input, output) {
    output$year <- renderPrint({ input$year })
    output$region <- renderPrint({ input$region })
    output$letter <- renderPrint({ input$letter })
  } 
  
  shinyApp(ui = ui, server = server)
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
## Exclusionary ##
    # If year is chosen on the main panel, only show the year inputs
  ui <- fluidPage(sidebarLayout(
    sidebarPanel(
      h4("Inputs to explore"),
      
      conditionalPanel(
        condition = "input.tabs == 'year'",  #ns = NS(NULL),
        
        selectInput(inputId = "region", 
                    label = "Select region:",
                    choices = c("Region 1", "Region 2", "Region 3", "Region 4"),
                    selected = c("Region 1"), # none selected as the default when the app opens
                    multiple = FALSE),
        
        radioButtons(inputId = "letter",
                     label = "Choose a letter",
                     selected = c("A"),
                     choices = c("A", "B", "C")),
        
        
        verbatimTextOutput("year")
        
      ), # End conditionalPanel
      
      conditionalPanel(
        condition = "input.tabs == 'region'",  #ns = NS(NULL),


        
        sliderInput(inputId = "year",
                    label = "Choose the year",
                    value = 2020, # default value
                    min = 2007,
                    max = 2020,
                    step = 1,
                    sep = "",
                    round = TRUE,
                    ticks = FALSE),
        
        radioButtons(inputId = "letter",
                     label = "Choose a letter",
                     selected = ,
                     choices = c("A", "B", "C")),
        
        verbatimTextOutput("region")
      ), # End conditionalPanel
      
      conditionalPanel(
        condition = "input.tabs == 'letter' ",

        
        sliderInput(inputId = "year",
                    label = "Choose the year",
                    value = character(0), # default value
                    min = 2007,
                    max = 2020,
                    step = 1,
                    sep = "",
                    round = TRUE,
                    ticks = FALSE),
        
        selectInput(inputId = "region", 
                    label = "Select region:",
                    choices = c("Region 1", "Region 2", "Region 3", "Region 4"),
                    selected = character(0), # none selected as the default when the app opens
                    multiple = FALSE),
        
        
        verbatimTextOutput("letter")
        
      ) # End conditionalPanel
    ),    # End sidebarPanel
    
    
    mainPanel(
      tabsetPanel(
        type = "tabs", id = "tabs",
        tabPanel(id = "year", value = "year",
                 "Compare years",
                 
        ),
        tabPanel(id = "region", value = "region",
                 "Compare regions",
                 
        ),
        tabPanel(id = "letter", value = "letter",
                 "compare letters",
                 
        )# Close tabpanel Transport results
      ) # Close tabset tabs_a
    ) # End mainPanel  
  )   # End sidebarLayout
  ) # End fluidPage    
  
  server <- function(input, output) {
    output$year <- renderPrint({ input$year })
    output$region <- renderPrint({ input$region })
    output$letter <- renderPrint({ input$letter })
  } 
  
  shinyApp(ui = ui, server = server)
  
  
  
  
  
  
  
  
  
  
  ## OTHER IDEAS THAT   I COULD 
  
  library(shiny)
  library(shinyjs)
  
  if(interactive()){
    shinyApp(
      ui <- fluidPage(
        shinyjs::useShinyjs(),
        actionButton("eval","Evaluate"),
        numericInput("num_input", "If number is changed, cp must show", value = 0),
        shinyjs::hidden(
          div(
            id = "cp1",
            conditionalPanel(condition = "input.eval", 
                             textOutput("text1")))
        )
      ),
      
      server = function(input, output, session){
        output$text1 <- renderText({
          input$num_input
        })
        observeEvent(input$eval,{
          shinyjs::hide("cp1")
        })
        observeEvent(input$num_input,{
          shinyjs::show("cp1")
        })
      }
    )
  }
  
  
  library(shiny)
  
  library(shinyjs)
  
  ui <- fluidPage(
    mainPanel(
      tabsetPanel(id = "tabSwitch",
                  tabPanel("Tab 1", br(), "Tab 1 content"),
                  tabPanel("Tab 2", br(), "Tab 2 content"),
                  tabPanel("Tab 3", br(), "Tab 3 content")
      ), br(),
      actionButton("warningBtn", "Generate Warning"),
      
      shinyjs::useShinyjs(),
      shinyjs::hidden(
        div(
          id = "showhide",
          conditionalPanel(condition = "input.eval", 
                           textOutput("text1")))
      )
      
    )
  )
  
  server <- function(input, output, session) {
    
    observeEvent(input$warningBtn, {
      showNotification(ui = paste(Sys.time(), " - Warning!"), duration = NULL, closeButton = FALSE, id = "previousWarningMessage", type = "warning")
    })
    
    observeEvent(input$tabSwitch, {
      print(paste("You clicked tab:", input$tabSwitch))
      removeNotification("previousWarningMessage")
    })
    
    observeEvent(input$tabSwitch,{
      shinyjs::hide("cp1")
    })
    observeEvent(input$num_input,{
      shinyjs::show("cp1")
    })
  }
  
  shinyApp(ui, server)
  
  
  
  
  
  
  

  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  ui <- fluidPage(
    sidebarLayout(
      sidebarPanel(
        shinyjs::useShinyjs(),
        
        shinyjs::hidden(
          div(
            id = "showhide",
            conditionalPanel(condition = "input.eval", 
                             textOutput("text1")))
        ),
        
        shinyjs::hidden(
          div(
            id = "showhide",
            conditionalPanel(condition = "input.eval", 
                             textOutput("text1")))
        ),
        

          div(
            id = "year_tog",

                             
                             sliderInput(inputId = "year",
                                         label = "Choose the year",
                                         value = character(0), # default value
                                         min = 2007,
                                         max = 2020,
                                         step = 1,
                                         sep = "",
                                         round = TRUE,
                                         ticks = FALSE)
                             ),
        
        div(
          id = "region_tog",

                           selectInput(inputId = "region", 
                                       label = "Select region:",
                                       choices = c("Region 1", "Region 2", "Region 3", "Region 4"),
                                       selected = character(0), # none selected as the default when the app opens
                                       multiple = FALSE)
                           ),
        
        div(
          id = "letter_tog",

                           radioButtons(inputId = "letter",
                                        label = "Choose a letter",
                                        selected = c("A"),
                                        choices = c("A", "B", "C"))
                           
                           )
        
      ),
      
      
      mainPanel(
        tabsetPanel( type = "tabs", id = "tabs",
                     tabPanel(id = "year", value = "year", 
                              "Compare years"),
                     
                     tabPanel(id = "region", value = "region",
                              "Compare regions"), 
                     
                     tabPanel(id = "letter", value = "letter",
                              "compare letters")
                     ) # close tabset
      ) # close main panel
    ) # close side bar layout
  ) # close fluidpage
  
  
  
  
  
  server <- function(input, output, session) {

    output$year <- renderPrint({ input$year })
    output$region <- renderPrint({ input$region })
    output$letter <- renderPrint({ input$letter })

    observe({
      req(input$tabs == "year") # Only display if tab is "year"

      shinyjs::show("letter")
      shinyjs::show("region")
      shinyjs::hide("year")
      
    })
    
    observe({
      req(input$tabs == "region") # Only display if tab is "region"
   
      shinyjs::show("letter")
      shinyjs::show("year")
      shinyjs::hide("region")
      
    })
    
    observe({
      req(input$tabs == "letter") # Only display if tab is "letter"

      shinyjs::show("region")
      shinyjs::show("year")
      shinyjs::hide("letter")
      
    })
    
    
  }
  shinyApp(ui, server)
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  ## working using action button to toggle which dataframe
  
  library(shinyjs)
  library(shiny)
  library(DT)
  
  ui <- pageWithSidebar(
    
    headerPanel("Test"),
    
    sidebarPanel(
      
      actionButton("actForFrame1", "Frame1"),
      actionButton("actForFrame2", "Frame2")
    ),
    
    mainPanel(
      useShinyjs(),
      wellPanel("Test",
                conditionalPanel(condition = "input.actForFrame1",
                                 DT::dataTableOutput("dataFrame1")
                ),
                conditionalPanel(condition= "input.actForFrame2",
                                 DT::dataTableOutput("dataFrame2"))
      )
    )
  )
  
  
  
  server <- function(input, output, session) {
    
    data_for_use <- reactiveValues(d=NULL)
    
    observeEvent(input$actForFrame1,{
      data_for_use$dataFrame1 <- data.frame(firstColumn= c(1,3,5),secondColumn=c(2,4,6))})
    
    observeEvent(input$actForFrame2,{
      data_for_use$dataFrame2 <- data.frame(firstColumn= c(10,30,50),secondColumn=c(20,40,60))})
    
    output$dataFrame1 <- DT::renderDataTable({
      DT::datatable(data_for_use$dataFrame1)
    })
    
    output$dataFrame2 <- DT::renderDataTable({
      DT::datatable(data_for_use$dataFrame2)
    })
    
    observeEvent(input$actForFrame1,{
      show("dataFrame1")
      hide("dataFrame2")
      
    })
    
    observeEvent(input$actForFrame2,{
      show("dataFrame2")
      hide("dataFrame1")
      
    }) 
  }
  
  shinyApp(ui, server)
  
  
  
  ## playing with it
  
  library(shinyjs)
  library(shiny)
  library(DT)
  
  ui <- pageWithSidebar(
    
    headerPanel("Test"),
    
    sidebarPanel(
      
      actionButton("actForFrame1", "Frame1"),
      actionButton("actForFrame2", "Frame2")
    ),
    
    mainPanel(
      useShinyjs(),
      
      wellPanel("Test",
                conditionalPanel(condition = "input.actForFrame1",
                                 sliderInput(inputId = "year",
                                             label = "Choose the year",
                                             value = character(0), # default value
                                             min = 2007,
                                             max = 2020,
                                             step = 1,
                                             sep = "",
                                             round = TRUE,
                                             ticks = FALSE)
                ),
                
                conditionalPanel(condition= "input.actForFrame2",
                                 DT::dataTableOutput("dataFrame2"))
      )
    )
  )
  
  
  
  ui <- fluidPage(
    sidebarLayout(
      sidebarPanel(),
      mainPanel()
    )
  )
  
  
  
  server <- function(input, output, session) {
    
    data_for_use <- reactiveValues(d=NULL)
    
    observeEvent(input$actForFrame1,{
      data_for_use$dataFrame1 <- data.frame(firstColumn= c(1,3,5),secondColumn=c(2,4,6))})
    
    observeEvent(input$actForFrame2,{
      data_for_use$dataFrame2 <- data.frame(firstColumn= c(10,30,50),secondColumn=c(20,40,60))})
    
    output$dataFrame1 <- DT::renderDataTable({
      DT::datatable(data_for_use$dataFrame1)
    })
    
    output$dataFrame2 <- DT::renderDataTable({
      DT::datatable(data_for_use$dataFrame2)
    })
    
    observeEvent(input$actForFrame1,{
      show("dataFrame1")
      hide("dataFrame2")
      
    })
    
    observeEvent(input$actForFrame2,{
      show("dataFrame2")
      hide("dataFrame1")
      
    }) 
  }
  
  shinyApp(ui, server)
  
  
  
  ## Exclusionary ##
  # If year is chosen on the main panel, only show the year inputs
  ui <- fluidPage(sidebarLayout(
    sidebarPanel(
      h4("Inputs to explore"),
      
      conditionalPanel(
        condition = "input.tabs == 'year'",  #ns = NS(NULL),
        
        selectInput(inputId = "region", 
                    label = "Select region:",
                    choices = c("Region 1", "Region 2", "Region 3", "Region 4"),
                    selected = c("Region 1"), # none selected as the default when the app opens
                    multiple = FALSE),
        
        radioButtons(inputId = "letter",
                     label = "Choose a letter",
                     selected = c("A"),
                     choices = c("A", "B", "C")),
        
        
        verbatimTextOutput("year")
        
      ), # End conditionalPanel
      
      conditionalPanel(
        condition = "input.tabs == 'region'",  #ns = NS(NULL),
        
        
        
        sliderInput(inputId = "year",
                    label = "Choose the year",
                    value = 2020, # default value
                    min = 2007,
                    max = 2020,
                    step = 1,
                    sep = "",
                    round = TRUE,
                    ticks = FALSE),
        
        radioButtons(inputId = "letter",
                     label = "Choose a letter",
                     selected = ,
                     choices = c("A", "B", "C")),
        
        verbatimTextOutput("region")
      ), # End conditionalPanel
      
      conditionalPanel(
        condition = "input.tabs == 'letter' ",
        
        
        sliderInput(inputId = "year",
                    label = "Choose the year",
                    value = character(0), # default value
                    min = 2007,
                    max = 2020,
                    step = 1,
                    sep = "",
                    round = TRUE,
                    ticks = FALSE),
        
        selectInput(inputId = "region", 
                    label = "Select region:",
                    choices = c("Region 1", "Region 2", "Region 3", "Region 4"),
                    selected = character(0), # none selected as the default when the app opens
                    multiple = FALSE),
        
        
        verbatimTextOutput("letter")
        
      ) # End conditionalPanel
    ),    # End sidebarPanel
    
    
    mainPanel(
      tabsetPanel(
        type = "tabs", id = "tabs",
        tabPanel(id = "year", value = "year",
                 "Compare years",
                 
        ),
        tabPanel(id = "region", value = "region",
                 "Compare regions",
                 
        ),
        tabPanel(id = "letter", value = "letter",
                 "compare letters",
                 
        )# Close tabpanel Transport results
      ) # Close tabset tabs_a
    ) # End mainPanel  
  )   # End sidebarLayout
  ) # End fluidPage    
  
  server <- function(input, output) {
    output$year <- renderPrint({ input$year })
    output$region <- renderPrint({ input$region })
    output$letter <- renderPrint({ input$letter })
    
    observeEvent("input.tabs == 'year' ",{
      show("region")
      show("letter")
      hide("year")
      
    }) 
    observeEvent("input.tabs == 'region' ",{
      show("year")
      show("letter")
      hide("reigon")
      
    }) 
    observeEvent("input.tabs == 'letter' ",{
      show("year")
      show("region")
      hide("letter")
      
    }) 
  } 
  
  shinyApp(ui = ui, server = server)
  
  
  
  
  
  
  
  
  library(shiny)
  library(shinyjs)
  
  ui <- fluidPage(
    useShinyjs(),
    sidebarLayout(
      sidebarPanel(

        
        shinyjs::hidden(
          div(
            id = "text_year_hide",
             
                             textInput("text_year", "Text year"))
        ),
        shinyjs::hidden(
          div(
            id = "text_region_hide",

                             textInput("text_region", "Text region"))
        ),
        shinyjs::hidden(
          div(
            id = "text_letter_hide",
         
                             textInput("text_letter", "Text letter"))
        ),
        
        
      ),
      mainPanel(
    tabsetPanel(
      type = "tabs", id = "tabs",
      tabPanel(id = "year", value = "year",
               "Compare years",
               
      ),
      tabPanel(id = "region", value = "region",
               "Compare regions",

      ),
      tabPanel(id = "letter", value = "letter",
               "compare letters",
      )# Close tabpanel Transport results
    ), # close main bar
    )
)
  )
  
  server <- function(input, output) {

    observe({
      if (req(input$tabs) == "year")
        shinyjs::hide("text_year_hide")
        shinyjs::show("text_region_hide")
        shinyjs::show("text_letter_hide")

      

      
      if (req(input$tabs) == "region")
        shinyjs::hide("text_region_hide")
        shinyjs::show("text_letter_hide")
        shinyjs::show("text_year_hide")


      
      if (req(input$tabs) == "letter")
        shinyjs::hide("text_letter_hide")
        shinyjs::show("text_year_hide")
        shinyjs::show("text_region_hide")


    })
    

  }
  
  shinyApp(ui = ui, server = server)
  
  
  
  library(shiny)
  
  shinyApp(
    ui = navbarPage(
      "App Title",
      id = "navbar",
      tabPanel("Plot"),
      navbarMenu(
        "More",
        tabPanel("Summary"),
        "----",
        "Section header",
        tabPanel("Table")
      )
    ),
    server = function(input, output){
      observe({
        if (req(input$navbar) == "Table")
          message("Table has been selected")
        if (req(input$navbar) == "Plot")
          message("Plot has been selected")
      })
    }
  )
  