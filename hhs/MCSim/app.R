#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)

# Define UI 
ui <- 
  fluidPage(
  fluidRow(
  column(3,
         selectInput("n_sims", label = "Number of sims:",
                     choices = c(10, 100, 1000, 10000), selected = 10)
  ),
  column(4, offset = 1, 
         textInput("varsA", label = "Values of A", value = "80 100 120"),
         textInput("probsA", label = "Probabilities of A", value = "2 2 2")
  ),
  column(4,
         textInput("varsB", label = "Values of B", value = "60 80 90"),
         textInput("probsB", label = "Probabilities of B", value = "1 3 2")
  )
  ),
  
  # Show a plot of the generated distribution
  fluidRow(
    column(12,
    plotOutput("distPlot")
  )
)
)

# Define server
server <- function(input, output) {
   
   output$distPlot <- 
     renderPlot({
       n <- as.numeric(unlist(strsplit(input$n_sims, " ")))
       varsA <- as.numeric(unlist(strsplit(input$varsA, " ")))
       probsA <- as.numeric(unlist(strsplit(input$probsA, " ")))
       varsB <- as.numeric(unlist(strsplit(input$varsB, " ")))
       probsB <- as.numeric(unlist(strsplit(input$probsB, " ")))
       
       drawsA = sample(varsA, size = n, replace = TRUE, prob = probsA)
       drawsB = sample(varsB, size = n, replace = TRUE, prob = probsB)
       
       drawsRes <- drawsA - drawsB
       
       bins <- 1+(max(drawsRes) - min(drawsRes)) / 10
       
       h <- hist(drawsRes, probability = FALSE, breaks = bins, col = "Red",
                 xlab = "Result", main = paste("Model: Result = A - B\nMean =",mean(drawsRes)))
       
       xfit<-seq(min(drawsRes),max(drawsRes),length=100) 
       yfit<-dnorm(xfit,mean=mean(drawsRes),sd=sd(drawsRes)) 
       yfit <- yfit*diff(h$mids[1:2])*length(drawsRes) 
       lines(xfit, yfit, col="blue", lwd=2)
       
     })
}

# Run the application 
shinyApp(ui = ui, server = server)

