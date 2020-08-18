#######################
## Shiny with Plotly ##
#######################
# Tutorials:
# https://plotly.com/r/#controls



library(shiny)
library(plotly)
# need to load mtcars?



## UI ##
ui <- fluidPage(
  headerPanel('Example'),
  sidebarPanel(
    selectInput('xcol','X Variable', names(mtcars)),
    selectInput('ycol','Y Variable', names(mtcars)),
    selected = names(mtcars)[[2]]),
  mainPanel(
    plotlyOutput('plot')
  )
)



## Server ##
server <- function(input, output) {
  
  x <- reactive({
    mtcars[,input$xcol]
  })
  
  y <- reactive({
    mtcars[,input$ycol]
  })
  
  
  output$plot <- renderPlotly(
    plot1 <- plot_ly(
      x = x(),
      y = y(), 
      type = 'scatter',
      mode = 'markers')
  )
  
}



## App ##
shinyApp(ui,server)












#########################################
### plotly heat map responds to click ###
#########################################

# from:
# https://plotly-r.com/linking-views-with-shiny.html

library(shiny)
##require mt cars ?



# cache computation of the correlation matrix
correlation <- round(cor(mtcars), 3)

## UI ##
ui <- fluidPage(
  plotlyOutput("heat"), #heat map
  plotlyOutput("scatterplot") #
)


server <- function(input, output, session) {
  
  output$heat <- renderPlotly({
    plot_ly(source = "heat_plot") %>%
      add_heatmap(
        x = names(mtcars), 
        y = names(mtcars), 
        z = correlation
      )
  })
  
  output$scatterplot <- renderPlotly({
    # if there is no click data, render nothing!
    clickData <- event_data("plotly_click", source = "heat_plot")
    if (is.null(clickData)) return(NULL)
    
    # Obtain the clicked x/y variables and fit linear model
    vars <- c(clickData[["x"]], clickData[["y"]])
    d <- setNames(mtcars[vars], c("x", "y"))
    yhat <- fitted(lm(y ~ x, data = d))
    
    # scatterplot with fitted line
    plot_ly(d, x = ~x) %>%
      add_markers(y = ~y) %>%
      add_lines(y = ~yhat) %>%
      layout(
        xaxis = list(title = clickData[["x"]]), 
        yaxis = list(title = clickData[["y"]]), 
        showlegend = FALSE
      )
  })
  
}

shinyApp(ui, server)











##################################################
### plotly bar map responds to click and hover ###
##################################################

# from:
# https://plotly-r.com/linking-views-with-shiny.html

library(shiny)
library(dplyr)

ui <- fluidPage(
  plotlyOutput("bars"),
  verbatimTextOutput("click")
)

classes <- sort(unique(mpg$class))

server <- function(input, output, session) {
  
  output$bars <- renderPlotly({
    ggplot(mpg, aes(class, fill = drv, customdata = drv)) +
      geom_bar()
  })
  
  output$click <- renderPrint({
    d <- event_data("plotly_click")
    if (is.null(d)) return("Click a bar")
    mpg %>%
      filter(drv %in% d$customdata) %>%
      filter(class %in% classes[d$x])
  })
  
}

shinyApp(ui, server)





##################################
### Slider to zoom in on graph ###
##################################

# from:
# https://plotly.com/r/range-slider/

install.packages("plotly")
library(plotly)
install.packages("quantmod")
library(quantmod)

# Download some data
getSymbols(Symbols = c("AAPL", "MSFT"), from = '2018-01-01', to = '2019-01-01')


ds <- data.frame(Date = index(AAPL), AAPL[,6], MSFT[,6])

fig <- plot_ly(ds, x = ~Date)
fig <- fig %>% add_lines(y = ~AAPL.Adjusted, name = "Apple")
fig <- fig %>% add_lines(y = ~MSFT.Adjusted, name = "Microsoft")
fig <- fig %>% layout(
  title = "Stock Prices",
  xaxis = list(
    rangeselector = list(
      buttons = list(
        list(
          count = 3,
          label = "3 mo",
          step = "month",
          stepmode = "backward"),
        list(
          count = 6,
          label = "6 mo",
          step = "month",
          stepmode = "backward"),
        list(
          count = 1,
          label = "1 yr",
          step = "year",
          stepmode = "backward"),
        list(
          count = 1,
          label = "YTD",
          step = "year",
          stepmode = "todate"),
        list(step = "all"))),
    
    rangeslider = list(type = "date")),
  
  yaxis = list(title = "Price"))

fig














###############################
### Other plots with Plotly ###
###############################


######################################################
## Line graph with different line types and colours ##
######################################################

library(dplyr)
top5 <- txhousing %>%
  group_by(city) %>%
  summarise(m = mean(sales, na.rm = TRUE)) %>%
  arrange(desc(m)) %>%
  top_n(5)

tx5 <- semi_join(txhousing, top5, by = "city")

plot_ly(tx5, x = ~date, y = ~median) %>%
  add_lines(linetype = ~city)

## Controlling the line type for categories ##
ltys <- c(
  Austin = "dashdot",
  `Collin County` = "longdash",
  Dallas = "dash",
  Houston = "solid",
  `San Antonio` = "dot"
)

plot_ly(tx5, x = ~date, y = ~median) %>%
  add_lines(linetype = ~city, linetypes = ltys)



##########################################################
## Maps, controlled by plotly (e.g. polygon or points)  ##
##########################################################

base <- map_data("world", "canada") %>%
  group_by(group) %>%
  plotly_empty(x = ~long, y = ~lat, alpha = 0.2) %>%
  layout(showlegend = FALSE, xaxis = list(scaleanchor = "y"))

base %>%
  add_polygons(hoverinfo = "none", color = I("black")) %>%
  add_markers(text = ~paste(name, "<br />", pop), hoverinfo = "text", 
              color = I("red"), data = maps::canada.cities)




###################################
### ggplot and plotly - ggplotly ##
###################################
# Use plotly directly with your ggplot to make them interactive

# from:
# https://github.com/lgellis/MiscTutorial/tree/master/ggplotly


library(plotly)
g <- ggplot(txhousing, aes(x = date, y = sales, group = city)) +
  geom_line(alpha = 0.4) 
ggplotly(g, tooltip = c("city"))

