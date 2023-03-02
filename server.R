# Define server for application

# Load data
co2 <- read.csv("https://raw.githubusercontent.com/owid/co2-data/master/owid-co2-data.csv", stringsAsFactors = FALSE)

# Server
my_server <- function(input, output) {
  output$co2_plot <- renderPlotly({
    
    country_df <- co2 %>% 
      filter(co2 %in% input$user_selection)
      
    co2_plot <- ggplot(data = country_df, aes(x = year, y = co2)) + 
      geom_line() + 
      labs(title = "CO2 Emissions in the US", x = "Year", y = "CO2 Production-Based Emissions") + 
      theme_light()
    return(ggplotly(US_co2_plot))
  })
}