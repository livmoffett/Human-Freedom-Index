library(plotly)
library(bslib)

ef <- read.csv("INFO_201_Final_Project_Dataset.csv", stringsAsFactor = FALSE)

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
    choices = ef$countries,
    # True allows you to select multiple choices...
    multiple = TRUE,
    selected = "United States"
  ),
  sliderInput(
    inputId = "year_selection",
    label = h3("Select Year"),
    min = min(ef$year),
    max = max(ef$year),
    sep = "",
    value = c(1990, 2020)
  )
)

sidebar_panel_widget2 <- sidebarPanel(
  selectInput(
    inputId = "country_selection1",
    label = "Countries",
    choices = ef$countries,
    # True allows you to select multiple choices...
    multiple = TRUE,
    selected = "United States"
  ),
  sliderInput(
    inputId = "year_selection1",
    label = h3("Select Year"),
    min = min(ef$year),
    max = max(ef$year),
    sep = "",
    value = c(1990, 2020)
  )
)

# Put a plot in the middle of the page
main_panel_plot <- mainPanel(
  # Make plot interactive
  plotlyOutput(outputId = "total_hf_plot")
)

main_panel_plot1 <- mainPanel(
  plotlyOutput(outputId = "total_rank_plot")
)

# Climate tab  — combine sidebar panel and main panel
tab_1 <- tabPanel(
  "Tab 1", fluidPage(includeMarkdown("tab-1.md")),
  sidebarLayout(
    sidebar_panel_widget,
    main_panel_plot,
  ),
)

tab_2 <- tabPanel(
  # Title of tab
  "Tab 2",
  fluidPage(includeMarkdown("tab-2.md")),
  sidebarLayout(
    sidebar_panel_widget2,
    main_panel_plot1,
  ),
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
