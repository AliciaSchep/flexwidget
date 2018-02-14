#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(flexwidget)

js_snippet <-
  '
function(data){// Make the visualization
var svg = dimple.newSvg("#vis", "100%", "100%");
widget = new dimple.chart(svg, HTMLWidgets.dataframeToD3(data));
widget.setMargins("60px", "30px", "110px", "70px");
widget.addMeasureAxis("x", "Sepal.Length");
widget.addMeasureAxis("y", "Petal.Width");
widget.addSeries(["Sepal.Length","Sepal.Width","Species"], dimple.plot.bubble);
widget.draw();
}
'

resize_snippet <-
  '
function(width, height) {
  widget.draw(0,true);
}
'


# Define UI for application that draws a histogram
ui <- fluidPage(

   # Application title
   titlePanel("flexwidget example"),

   # Sidebar with a slider input for number of bins
   sidebarLayout(
      sidebarPanel(
        tags$p("Demonstrating that you can add widget to shiny app.")
      ),

      # Show a plot of the generated distribution
      mainPanel(
        flexwidget_src(
          "https://d3js.org/d3.v4.min.js",
          "http://dimplejs.org/dist/dimple.v2.3.0.min.js"),
         flexwidgetOutput("flex")
      )
   )
)

# Define server logic required to draw a histogram
server <- function(input, output) {

   output$flex <- renderflexwidget({

     flexwidget(data = iris,
                js_code = js_snippet,
                inner_html =  htmltools::tags$div(id = "vis"),
                resize = resize_snippet)

   })
}

# Run the application
shinyApp(ui = ui, server = server)

