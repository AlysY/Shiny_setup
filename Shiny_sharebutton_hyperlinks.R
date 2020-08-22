#########################################
## Adding hyperlinks and share buttons ##
#########################################



########################
### Using fluid page ###
########################

# in the navigation bar
shinyApp(
  ui <- shinyUI(
    navbarPage("Test title",
               tabPanel(tags$a(href = 'www.google.com', # the hyperlink
                               "home", # the word to be hyperlinked
                               icon("home", lib = "glyphicon") # the icon to be hyperlinked
                               )),
               tabPanel("Other tabs without hyperlink")
    )),
  server <- shinyServer(function(input, output) {})
)





# in a drop down menu on the navigationbar
 
ui <- fluidPage(
  
  ## The navigation bar at the top of the screen
  navbarPage("Title", id="nav", selected = NULL, collapsible = TRUE, # title for the title bar, could add the logo or symbols
             navbarMenu(("Share"), icon = icon("share-alt"),
                        
                        # Note:
                          # both the word (e.g. Twitter, Facebook, LinkedIn) and the symbol (given by "twitter", "facebook", "linkedin") are both hyperlinked as they are within the tags$a function
                        ## Twitter  ----------------------------------------------------------------
                        tabPanel(tags$a(href = 'https://twitter.com/intent/tweet?url=http%3A%2F%2Fwww.google.com&text=The%20words%20on%20the%20post', icon("twitter"), "Twitter" )),
                        
                        ## LinkedIn  ----------------------------------------------------------------
                        tabPanel(tags$a(href = 'http://www.linkedin.com/shareArticle?mini=true&url=http%3A%2F%2Famrhotspots.com.au%2Faci%2Fadminpanel%2Fmanage%2Flogin &title=Check%20out%20this%20tool%20to%20track%20antimicrobial%20resistance', icon("linkedin"), "LinkedIn" )),
                        
                        ## Facebook  ----------------------------------------------------------------
                        tabPanel(tags$a(href = 'https://www.facebook.com/sharer/sharer.php?u=http%3A%2F%2Famrhotspots.com.au%2Faci%2Fadminpanel%2Fmanage%2Flogin', icon("facebook"), "Facebook" ))
                        
                        
             ), 
             tabPanel("Other tabs without hyperlink")
  )
)
server <- shinyServer(function(input, output) {})
shinyApp(ui, server)











##########################
## Using shinydashboard ##
##########################

library(shinydashboard)

## Helper function
# Function to call in place of dropdownMenu --------------
customSentence <- function(numItems, type) {
  paste("Feedback & suggestions")
}

customSentence_share <- function(numItems, type) {
  paste("Love it? Share it!")
}

# Called dropdownMenuCustom
# helps get rid of the 'you have one message' 
dropdownMenuCustom <-     function (..., type = c("messages", "notifications", "tasks"), 
                                    badgeStatus = "primary", icon = NULL, .list = NULL, customSentence = customSentence) 
{
  type <- match.arg(type)
  if (!is.null(badgeStatus)) shinydashboard:::validateStatus(badgeStatus)
  items <- c(list(...), .list)
  lapply(items, shinydashboard:::tagAssert, type = "li")
  dropdownClass <- paste0("dropdown ", type, "-menu")
  if (is.null(icon)) {
    icon <- switch(type, messages = shiny::icon("envelope"), 
                   notifications = shiny::icon("warning"), tasks = shiny::icon("tasks"))
  }
  numItems <- length(items)
  if (is.null(badgeStatus)) {
    badge <- NULL
  }
  else {
    badge <- tags$span(class = paste0("label label-", badgeStatus), 
                       numItems)
  }
  tags$li(
    class = dropdownClass, 
    a(
      href = "#", 
      class = "dropdown-toggle", 
      `data-toggle` = "dropdown", 
      icon, 
      badge
    ), 
    tags$ul(
      class = "dropdown-menu", 
      tags$li(
        class = "header", 
        customSentence(numItems, type)
      ), 
      tags$li(
        tags$ul(class = "menu", items)
      )
    )
  )
}

ui <- dashboardPage(
  dashboardHeader(dropdownMenuCustom( type = 'message',
                                      customSentence = customSentence_share,
                                      icon = icon("share-alt"),
                                      messageItem(
                                        from = 'Twitter',
                                        message = "",
                                        icon = icon("twitter"),
                                        href = "https://twitter.com/intent/tweet?url=http%3A%2F%2Famrhotspots.com.au%2Faci%2Fadminpanel%2Fmanage%2Flogin &text=Check%20out%20this%20tool%20to%20track%20antimicrobial%20resistance"
                                      ))),
  dashboardSidebar(),
  dashboardBody()
)

server <- function(input, output) { }

shinyApp(ui, server)


