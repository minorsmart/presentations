#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
source("distr.R")

# Define UI for application that draws a histogram
ui <- fluidPage(
   
   # Application title
   titlePanel("Demo normale verdeling"),
   
   # Sidebar with sliders 
   sidebarLayout(
      sidebarPanel(
         sliderInput("mean",
                     "Gemiddelde:",
                     min = -80,
                     max = 80,
                     value = 0),
         sliderInput("sd",
                     "Standaard deviatie:",
                     min = 5,
                     max = 30,
                     value = 15)
      ),
      
      # Show a plot of the generated distribution
      mainPanel(
         plotOutput("distPlot")
      )
   )
)


# Define server logic required to draw a histogram
server <- function(input, output) {
   
   output$distPlot <- renderPlot({
      mean <- input$mean
      sd <- input$sd
      
      # draw the histogram with the specified number of bins
      buildNormDist(mean, sd)
   })
}

# Run the application 
shinyApp(ui = ui, server = server)

