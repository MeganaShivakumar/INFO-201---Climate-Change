library(plotly)
library(bslib)
library(dplyr)

df <- read.csv("https://raw.githubusercontent.com/owid/co2-data/master/owid-co2-data.csv", stringsAsFactors = FALSE)

# Filter data in some way
subset_df <- df %>% 
  filter(country %in% c("United States", "New Zealand", "High-income countries", "Low-income countries", "India", "Greece", "Afghanistan", "Algeria", "Argentina", "Bangladesh", "Bermuda", "Canada"))

# Manually Determine a BootSwatch Theme
my_theme <- bs_theme(
  bg = "#0b3d91", # background color
  fg = "white", # foreground color
  primary = "#FCC780", # primary color
)
# Update BootSwatch Theme
my_theme <- bs_theme_update(my_theme, bootswatch = "cerulean")

# Home page tab
intro_tab <- tabPanel(
  # Title of tab
  "Introduction",
  fluidPage(
    p("Within this Shiny Application, I have chosen to focus on CO2 production-based emissions. The graph has two widgets, allowing the user to change the country displayed on the graph and the years displayed on the x axis. The countries include a few countries that I thought would be interesting to look at, as well as two general categories: high-income countries and low-income countries. I specifically chose these two broader categories as I thought it would be interesting to see how the level of resources a country has impacts their CO2 emission levels."), 
    p("The dataset that is being utilized for this project is the CO2 and Greenhouse Gas Emissions dataset maintained by Our World in Data. The data comes from a variety of different sources, including bp, the U.S. Energy Information Administration, and the Global Carbon Project to name a few. The data was collected to allow the general public to have access to key metrics relating to climate change and allow individuals to understand what is happening within our environment. Some of the possible limitations that arise from this data are that since many different sources were used to compile the dataset, there may be slight inconsistencies in how data was collected or how the measures relate to one another. This is an important aspect of the data to keep in mind when conducting analyses."), 
    p("Some of the key metrics that I found using this data are that this dataset includes 268 countries. The continent that produces the highest amount of production-based emissions of CO2 is Asia, while the continent with the lowest emissions is Africa. The country that has the highest primary energy consumption per capita is the United States Virgin Islands, a territory of the US with a population of about 100,000. The country with the lowest primary energy consumption per capita is Micronesia, a country near Oceania made of four islands, also with a population of about 100,000."), 
    p("This visualization shows that overall, CO2 production continues to increase in both high and low income countries. One detail that I thought was interesting was the slight increase and decrease that happened from year to year in some countries. I wonder what specific actions were taken that led to the decrease in CO2 production, and how that could be implemented on a larger scale. In addition, even smaller countries, with lower capital values and smaller populations, continue to increase their CO2 production rate at a similar rate to higher income countries, so I wonder if there is a way to decrease per capita usage in those types of areas.")
  )
)

# We want our next tab to have a sidebar layout
# So we're going to create a sidebarPanel() and a mainPanel() and then add them together

# Create sidebar panel for widget
select_widget <-
  selectInput(
    inputId = "country_selection",
    label = "Countries",
    choices = unique(subset_df$country), 
    selectize = TRUE,
    selected = "United States"
  )

# https://shiny.rstudio.com/gallery/widget-gallery.html
slider_widget <- sliderInput(
  inputId = "year_selection",
  label = "Years",
  min = min(subset_df$year),
  max = max(subset_df$year),
  value = c(1750, 2021),
  sep = "")

# Put a plot in the middle of the page
main_panel_plot <- mainPanel(
  # Make plot interactive
  plotlyOutput(outputId = "country_plot")
)

# Data viz tab  — combine sidebar panel and main panel
viz_tab <- tabPanel(
  "Data Visualizations",
  sidebarLayout(
    sidebarPanel(
      select_widget,
      slider_widget
    ),
    main_panel_plot
  ), 
  fluidPage(
    p("This graph displays the CO2 production - based emissions for a variety of countries, as well as two larger groups: high income countries and low income countries. The user is able to choose which country's emissions are viewed, as well as the years that are displayed. I wanted to include this chart as I was cuorious about how CO2 emissions have changed, and if the current COVID - 19 pandemic has caused any shifts in the pattern. Overall, the rate of CO2 emissions continues to drastically increase, leading to even more environmental and climate changes.")
  )
)

ui <- navbarPage(
  # Select Theme
  theme = my_theme,
  # Home page title
  "Climate Change Visualizations",
  intro_tab,
  viz_tab
)
