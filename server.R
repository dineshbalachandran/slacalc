#
# This is the server logic of a Shiny web application. You can run the 
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

requests <- data.frame(
              raised_date=as.Date(c("12/10/2015",
                                    "12/10/2015",
                                    "13/10/2015",
                                    "13/10/2015",
                                    "13/10/2015",
                                    "13/10/2015",
                                    "14/10/2015",
                                    "15/10/2015",
                                    "15/10/2015",
                                    "16/10/2015",
                                    "16/10/2015",
                                    "19/10/2015",
                                    "20/10/2015",
                                    "20/10/2015",
                                    "20/10/2015"), 
                                  "%d/%m/%Y"),
              response_date=as.Date(c("14/10/2015",
                                      "12/10/2015",
                                      "13/10/2015",
                                      "13/10/2015",
                                      "13/10/2015",
                                      "13/10/2015",
                                      "14/10/2015",
                                      "15/10/2015",
                                      "15/10/2015",
                                      "19/10/2015",
                                      "16/10/2015",
                                      "19/10/2015",
                                      "20/10/2015",
                                      "20/10/2015",
                                      "20/10/2015"), 
                                    "%d/%m/%Y"))
requests$age <- requests$response_date - requests$raised_date

library(shiny)

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
  
  output$distPlot <- renderPlot({
   
    # generate reponse SLA performance graph on input$responseSLA from ui.R
    requests$slaMet <- "Within SLA"
    requests$slaMet[requests$age > input$responseSLA] <- "Outside SLA"
    
    slaMet <- requests$slaMet
    
    #add default rows to force the table function to count atleast 
    #one of these groups (need this for the barplot function to display
    #'0' if either are '0')
    slaMet <- c(slaMet, "Within SLA", "Outside SLA") 
    
    # draw a barchart with the specified number of bins
    sla <- table(slaMet)
    
    #remove the defaults that were added from the count
    sla <- sla - 1
    
    b <- barplot(sla, col = c('red', 'green'), border = 'white', xlab="Response performance")
    text(b, 0, sla, cex=1, pos=3)
    
  })
  
})
