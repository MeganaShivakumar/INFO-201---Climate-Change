library(plotly)
library(bslib)
library(dplyr)

# Load data
# Baby names from Social Security office
# https://www.kaggle.com/datasets/kaggle/us-baby-names
df <- read.csv("https://raw.githubusercontent.com/owid/co2-data/master/owid-co2-data.csv", stringsAsFactors = FALSE)

# Filter data in some way
subset_df <- df %>% 
  filter(country %in% c("United States", "New Zealand", "High-income countries", "Low-income countries", "India", "Greece"))

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
    # Include a Markdown file!
    # includeMarkdown("sample-text.md"),
    p("Introduction ...")
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
    # True allows you to select multiple choices...
    # multiple = TRUE,
    selected = "United States"
  )

# radio_widget <- radioButtons(
#   inputId = "gender_selection",
#   label = "Gender",
#   choices = c("F", "M"),
#   selected = "F"
# )

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
  "Data Vizualizations",
  sidebarLayout(
    sidebarPanel(
      select_widget,
      # radio_widget,
      slider_widget
    ),
    main_panel_plot
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
