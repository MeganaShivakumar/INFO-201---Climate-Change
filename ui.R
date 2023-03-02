# Define UI for application

# Load data
co2 <- read.csv("https://raw.githubusercontent.com/owid/co2-data/master/owid-co2-data.csv", stringsAsFactors = FALSE)
library(plotly)
# User Interface
my_ui <- fluidPage(
  
  # Title — Static content
  h1("A4 - Climate Change", align="center"),
  
  # Exercise 2: Display bar plot
  plotlyOutput(outputId = "co2_plot"),
  
  # Exercise 3: Create selectInput widget
  selectInput(
    inputId = "user_selection",
    label = "Countries",
    choices = co2$country,
    selected = "United States", 
    # True allows you to select multiple choices...
    multiple = TRUE
  )
  
  
  
  
)