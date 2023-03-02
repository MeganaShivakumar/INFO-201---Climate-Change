# Load packages
library(shiny)

# Source your ui and server to get ui and server vars
source("ui.R")
source("server.R")

# Run the application 
shinyApp(ui = ui, server = server)
