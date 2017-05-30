#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(ggplot2)
library(plotly)

surveyDF <- read.csv("Startsurvey.csv")
questions <- colnames(surveyDF)[4:dim(surveyDF)[2]]
bijdrage <- as.character(surveyDF[,7])
bijdrage <- unlist(strsplit(bijdrage, "\\n"))
bijdrageDF <- data.frame(Bijdrage = bijdrage)

# Define UI for application that draws a histogram
ui <- fluidPage(
   
   # Application title
   titlePanel("Startsurvey Data"),
   
   # Sidebar with a slider input for number of bins 
   sidebarLayout(
      sidebarPanel(
        uiOutput("ui")
      ),
      
      # Show a plot of the generated distribution
      mainPanel(
         plotOutput("distPlot")
      )
   )
)

# Define server logic required to draw a histogram
server <- function(input, output, session) {
   
  output$ui <- renderUI({
  
    "radioButtons" = radioButtons("vragen", "Vragen",
                                  choices = c(questions),
                                  selected = questions[1]
    )
  })
  
   output$distPlot <- renderPlot({
     
     if(input$vragen != "Wat.heb.je.al.gedaan.ter.voorbereiding.op.deze.minor.") {
     ggplot(surveyDF, aes(x = surveyDF[,input$vragen], fill=surveyDF[,input$vragen])) +
       geom_bar() +
       theme(legend.title=element_blank(), axis.title.x=element_blank(), axis.text.x=element_blank())
     } else {
       ggplot(bijdrageDF, aes(x = Bijdrage, fill=Bijdrage)) +
         geom_bar() +
         theme(legend.title=element_blank(), axis.title.x=element_blank(), axis.text.x=element_blank())
     }
   })
}

# Run the application 
shinyApp(ui = ui, server = server)

