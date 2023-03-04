library(ggplot2)
library(dplyr)
library(plotly)

US <- co2 %>% 
  filter(country == "United States") 

US_co2_plot <- ggplot(data = US, aes(x = year, y = co2)) + 
  geom_line() + 
  labs(title = "CO2 Emissions in the US", x = "Year", y = "CO2 Production-Based Emissions") + 
  theme_light()

ggplotly(US_co2_plot)

# change y axis to be different col measurement

# select a year that zooms in on that year, uses a bar chart

library(dplyr)

co2 <- read.csv("https://raw.githubusercontent.com/owid/co2-data/master/owid-co2-data.csv", stringsAsFactors = FALSE)

co2 <- co2 %>% 
  filter(country != "OECD (GCP)")

summary_info <- list()

summary_info$num_countries <- co2 %>% 
  count(country)

summary_info$max_co2_prod <- co2 %>% 
  filter(co2 == max(co2, na.rm = TRUE)) %>% 
  pull(country) 

summary_info$min_co2_prod <- co2 %>% 
  filter(co2 == min(co2, na.rm = TRUE)) %>% 
  pull(country) 

summary_info$max_energy_per_cap <- co2 %>% 
  filter(energy_per_capita == max(energy_per_capita, na.rm = TRUE)) %>% 
  pull(country)

summary_info$min_energy_per_cap <- co2 %>% 
  filter(energy_per_capita == min(energy_per_capita, na.rm = TRUE)) %>% 
  pull(country)