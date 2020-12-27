library(shiny)
library(datasets)
library(ggplot2)


mpgData <- mtcars
mpgData$am <- factor(mpgData$am, labels = c("Automatic", "Manual"))



ui <- fluidPage(
  
  titlePanel("Miles Per Gallon04"),
  
  sidebarLayout(
    
    sidebarPanel(
      
      
      selectInput("variable", "Variable:",
                  c("Cylinders" = "cyl",
                    "Transmission" = "am",
                    "Gears" = "gear")),
      
     
       ),
    
    
    mainPanel(
      
      h3(textOutput("caption")),
     
      
   
      plotOutput("mpgPlot")
      
    )
  )
)


server <- function(input, output) {
  
  formulaText <- reactive({
    paste("mpg ~", input$variable)

  })
  
  output$caption <- renderText({
    formulaText()
  })
  
 output$mpgPlot <- renderPlot({
   ggplot(data=mpgData,mapping = aes(mpg)) +
     geom_histogram(fill="#75AADB",col="white",binwidth = 5,position = "dodge",) + 
     facet_wrap(~mpgData[[input$variable]],nrow =   3)
     
}
 ) 
}  
  

# Create Shiny app ----
shinyApp(ui, server)

