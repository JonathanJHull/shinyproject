#
#  Developing Data Products, Feb. 2015
#  Project Title: Predict Temperature on May 10th, 1973 in New York City
#  Author: Jonathan J. Hull
#
#  This is a shiny application that displays the temperature for the first 9 days
#  of May, 1973 in New York City (from the airquality data set), and asks
#  the user to predict the temperature on May 10th.
#  
#  This is the ui.R module.  It displays a sidebar panel in which the user
#  enters his/her prediction.  As a hint, it also displays the temperature on May 9th.
#  The main panel shows a plot of the temperature on May 1-9 so the user
#  can see the trend.  It also displays the user's prediction and, after the 
#  button is pressed, it displays the actual value of the temperature on May 10th.
#
library(shiny)

shinyUI(pageWithSidebar(
  headerPanel("Given temperature on May 1-9 predict temp. on May 10"),
  sidebarPanel(
    h5(helpText("Documentation: This is a shiny application that displays the temperature for the ",
                "first 9 days of May, 1973 in New York City (from the airquality data ",
                "set), and asks you to predict the temperature on May 10th. \n\n",
                "Observe the trend in the first 9 days on the right, the ",
                "temperature on May 9th (listed below), enter your prediction and ",
                "press the Go! button.  \n\n",
                "The server will calculate the difference between your prediction ",
                "and the actual temp. on May 10th and show you both numbers.")),
    h4('Hint: temp. on May 9th was:'),
    h4(textOutput("prevTemp")),
    # "Some form of widget input" shown below:
    numericInput('predictTemp','Enter your prediction for day 10', "", min=56, max=97,step=1),
    actionButton("goButton","Go!")
  ),
  mainPanel(
    plotOutput('newTemp'),
    h4('Your prediction:'),
    h5('You entered'),
    verbatimTextOutput("predictTemp"),
    h5('The actual temperature on day 10 was: '),
    verbatimTextOutput("actualTemp"),
    h5('The difference between your prediction and the actual temperature on day 10 is: '),
    verbatimTextOutput("diffTemp")
  )
))