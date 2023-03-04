library(ggplot2)
library(plotly)
library(dplyr)

# Read in data
# Baby names from Social Security office
# https://www.kaggle.com/datasets/kaggle/us-baby-names
df <- read.csv("https://raw.githubusercontent.com/owid/co2-data/master/owid-co2-data.csv", stringsAsFactors = FALSE)

# Filter the data in some way (aka pick a subset of names to examine — it's too large to include all names for all years)
# top_names <- df %>% 
#   group_by(Name) %>% 
#   summarize(total = sum(Count)) %>% 
#   slice_max(n = 100, order_by = total)

subset_df <- df %>% 
  filter(country %in% c("United States", "New Zealand", "High-income countries", "Low-income countries", "India", "Greece"))

server <- function(input, output) {
  
  output$country_plot <- renderPlotly({
    
    filtered_df <- subset_df %>% 
      # Filter for user's gender selection
      # filter(Gender %in% input$gender_selection) %>%
      # Filter for user's name selection
      filter(country %in% input$country_selection) %>% 
      # Filter for user's year selection
      filter(year > input$year_selection[1] & year < input$year_selection[2])
    
    # Line plot
    country_plot <- ggplot(data = filtered_df, aes(x = year, y = co2)) + 
      geom_line() + 
      labs(title = "CO2 Emissions", x = "Year", y = "CO2 Production-Based Emissions") + 
      theme_light()
    
    return(country_plot)
    
  })
  
}