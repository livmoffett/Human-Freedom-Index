library(ggplot2)
library(plotly)
library(dplyr)


climate_df <- read.csv("https://raw.githubusercontent.com/owid/co2-data/master/owid-co2-data.csv", stringsAsFactors = FALSE)

average_ghg_by_year <- climate_df %>% 
  filter(year >= 1989) %>% 
  group_by(year) %>% 
  summarize_if(is.numeric, median, na.rm = TRUE) %>% 
  select(year, total_ghg)


ghg_in_2018 <- climate_df %>% 
  filter(year == 2018) %>% 
  select(country, year, total_ghg)

max_ghg_in_2018 <- ghg_in_2018 %>% 
  filter(total_ghg == max(total_ghg, na.rm = TRUE))

min_ghg_in_2018 <- ghg_in_2018 %>% 
  filter(total_ghg == min(total_ghg, na.rm = TRUE))

difference_in_10_years <- 43.78 - 36.52


server <- function(input, output) {
  output$total_ghg_plot <- renderPlotly({
    filtered_df <- climate_df %>%
      filter(country %in% input$country_selection) %>%
      filter(year >= input$year_selection[1] & year <= input$year_selection[2])

    total_ghg_plot <- ggplot(data = filtered_df) +
      geom_line(mapping = aes(x = year, y = total_ghg, color = country)) +
      labs(title = "Total Greenhouse Gas emissions by Country", x = "Year", y = "Greenhouse Gas emmision (million tonnes)", color ="Country")+theme(plot.title = element_text(hjust = 0.5))

    return(total_ghg_plot)
  })
}

