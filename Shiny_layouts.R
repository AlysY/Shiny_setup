############################
### Shiny layout options ###
############################

## By Alys Young
## August 2020

#################
### 1. Set Up ###
#################
library('shiny') # for the shiny app
#library('shinydashboard') # to add boxes and other layouts


###########################################
### 2. User interface - SIDE BAR LAYOUT ###
###########################################


ui <- fluidPage(
   sidebarLayout(
    
    sidebarPanel(
      h3("Left hand side"),
      
      p("Side bar on the left")
      

    ),
    
    mainPanel(
      
      h3("Main panel"),
      
      tabsetPanel( # tabs
        
        tabPanel("Plot", p("page 1")), 
        
        tabPanel("Table", p("page 2 ")), 
        
        tabPanel("Data", p("page 3")
                 )
        
        
      ),
      
      tags$div(
        tags$b("How to cite this page:"),
        p("extra text at the bottom of the main panel"))
    )
  )
)



#################################################
### 2. User interface - Columns with fluidRow ###
#################################################
  # Shiny is set up to be in 12 columns
  # use the width in columns to specify how many parts of the 12 you want to use
ui <- fluidPage(
  fluidRow(
    column( width = 12, # full width of page
           "Fluid 12",
           fluidRow(
             column(6, # half the width of the full width column (equivalent to half the width of the full page)
                    "Fluid 6",
                    fluidRow(
                      column(6, # half the width of the half page column
                             "Fluid 6"),
                      column(6,
                             "Fluid 6")
                    )
             ),
             column(width = 6,
                    "Fluid 6")
           )
    )
  )
)


############################################################
### 2. User interface - Columns offsetting with fluidRow ###
############################################################
ui <- fluidPage(
  fluidRow(
    column(4,
           "4"
    ),
    column(4, offset = 4,
           "4 offset 4"
    )      
  ),
  fluidRow(
    column(3, offset = 3,
           "3 offset 3"
    ),
    column(3, offset = 3,
           "3 offset 3"
    )  
  )
)

