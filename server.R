#
#  Developing Data Products, Feb. 2015
#  Project Title: Predict Temperature on May 10th, 1973 in New York City
#  Author: Jonathan J. Hull
#
#  This is a shiny application that displays the temperature for the first 9 days
#  of May, 1973 in New York City (from the airquality data set), and asks
#  the user to predict the temperature on May 10th.
#  
#  This is the server.R module.  It constructs the plot of the temperature 
#  on the first 9 days of May, and it looks up the temperature on May 10th.
#  The first time the shinyServer function is executed, the actualTemp variable
#  is set to NA because we don't want the user to see it before he/she enters
#  his/her prediction.  
#


library(shiny);
library(UsingR);
library(ggplot2);
data(airquality);
# add an "day_number" column to the airquality data
airquality$day_number <- seq(1,153);

shinyServer(
  function(input, output) {
    output$newTemp <- renderPlot({
       ggplot(airquality[seq(1,9),],aes(x=day_number,y=Temp)) + geom_line() + 
         scale_x_continuous(breaks=seq(1,10)) +
         ggtitle("Temperature trend from May 1st to May 9th, 1973") +
         ylab("temperature (degrees Fahrenheit)")
    });
    output$prevTemp    <- renderText(airquality[9,]$Temp);
    # "Some operation on the UI input" shown below.  
    #  We echo the user's prediction and use the state of the go button
    #  to determine whether to print the temperature on the 10th day
    output$predictTemp <- renderText({input$predictTemp});
    output$actualTemp  <- renderText({
        if (input$goButton==0) NA
        else airquality[10,]$Temp
    });
    #  "Some reactive output displayed as a result of server calulations" shown below
    #  We display the difference between the user's prediction and the actual temperature
    #  on the 10th day.
    output$diffTemp <- renderText({
        if (input$goButton==0) NA
        else (input$predictTemp - airquality[10,]$Temp)
    });
  }
)