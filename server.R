library(ggplot2)
library(plotly)
library(dplyr)

df <- read.csv("https://raw.githubusercontent.com/owid/co2-data/master/owid-co2-data.csv", stringsAsFactors = FALSE)

summary_info <- list()

summary_info$num_countries <- df %>% 
  count(country)

summary_info$max_co2_prod <- df %>% 
  filter(co2 == max(co2, na.rm = TRUE)) %>% 
  pull(country) 

summary_info$min_co2_prod <- df %>% 
  filter(co2 == min(co2, na.rm = TRUE)) %>% 
  pull(country) 

summary_info$max_energy_per_cap <- df %>% 
  filter(energy_per_capita == max(energy_per_capita, na.rm = TRUE)) %>% 
  pull(country)

summary_info$min_energy_per_cap <- df %>% 
  filter(energy_per_capita == min(energy_per_capita, na.rm = TRUE)) %>% 
  pull(country)

subset_df <- df %>% 
  filter(country %in% c("United States", "New Zealand", "High-income countries", "Low-income countries", "India", "Greece", "Afghanistan", "Algeria", "Argentina", "Bangladesh", "Bermuda", "Canada"))

server <- function(input, output) {
  
  output$country_plot <- renderPlotly({
    
    filtered_df <- subset_df %>% 
      filter(country %in% input$country_selection) %>% 
      filter(year > input$year_selection[1] & year < input$year_selection[2])
    
    # Line plot
    country_plot <- ggplot(data = filtered_df, aes(x = year, y = co2)) + 
      geom_line() + 
      labs(title = "CO2 Emissions", x = "Year", y = "CO2 Production-Based Emissions (million tonnes)") + 
      theme_light()
    
    return(country_plot)
    
  })
  
}