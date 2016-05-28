#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)

# Define UI for application that draws a histogram
shinyUI(fluidPage(
  
  # Application title
  titlePanel("Reponse performance"),
  
  h4("The use case of this app is to track performance of a 
      service desk to the requests it receives. Given the number of days 
      to respond to a request (SLA), it provides the count of 
      requests that are within the SLA days (in green) and the ones 
      outside (in red) in a simple bar plot."),
  
  h5("Use the slider to vary the SLA days expected, the plot re-displays  
      based on the chosen SLA."),
  
  # Sidebar with a slider input for number of days 
  sidebarLayout(
    sidebarPanel(
       sliderInput("responseSLA",
                   "Set SLA days",
                   min = 1,
                   max = 5,
                   value = 2)
       
    ),
    
    # Show a plot of the generated distribution
    mainPanel(
       plotOutput("distPlot")
    )
  )
))
