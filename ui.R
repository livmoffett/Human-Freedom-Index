library(plotly)
library(bslib)

climate_df <- read.csv("https://raw.githubusercontent.com/owid/co2-data/master/owid-co2-data.csv", stringsAsFactors = FALSE)

# Manually Determine a BootSwatch Theme
my_theme <- bs_theme(
  bg = "#0b3d91", # background color
  fg = "white", # foreground color
  primary = "#FCC780", # primary color
)
# Update BootSwatch Theme
my_theme <- bs_theme_update(my_theme, bootswatch = "yeti")

# bs_theme_preview(my_theme)

# Home page tab
intro_tab <- tabPanel(
  # Title of tab
  "Introduction",
  fluidPage(
    includeMarkdown("introduction-text.md"),
  )
)



# Create sidebar panel for widget
sidebar_panel_widget <- sidebarPanel(
  selectInput(
    inputId = "country_selection",
    label = "Countries",
    choices = climate_df$country,
    # True allows you to select multiple choices...
    multiple = TRUE,
    selected = "United States"
  ),
  sliderInput(
    inputId = "year_selection",
    label = h3("Select Year"),
    min = 1990,
    max = 2020,
    sep = "",
    value = c(1990, 2020)
  )
)

# Put a plot in the middle of the page
main_panel_plot <- mainPanel(
  # Make plot interactive
  plotlyOutput(outputId = "total_ghg_plot")
)

# Climate tab  — combine sidebar panel and main panel
tab_1 <- tabPanel(
  "Tab 1",fluidPage(includeMarkdown("tab-1.md")),
  sidebarLayout(
    sidebar_panel_widget,
    main_panel_plot,
  ),
)

tab_2 <- tabPanel(
  # Title of tab
  "Tab 2",
  fluidPage(
    includeMarkdown("tab-2.md"),
  )
)

tab_3 <- tabPanel(
  # Title of tab
  "Tab 3",
  fluidPage(
    includeMarkdown("tab-3.md"),
  )
)

conclusion_tab <- tabPanel(
  # Title of tab
  "Conclusion",
  fluidPage(
    includeMarkdown("conclusion.md"),
  )
)
ui <- navbarPage(
  # Select Theme
  theme = my_theme,
  # Home page title
  "Homepage",
  intro_tab,
  tab_1,
  tab_2,
  tab_3,
  conclusion_tab
)
