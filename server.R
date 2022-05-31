library(ggplot2)
library(plotly)
library(dplyr)
library(scales)

ef <- read.csv("INFO_201_Final_Project_Dataset.csv", stringsAsFactor = FALSE)

average_hf_by_year <- ef %>%
  filter(year >= 1989) %>%
  group_by(year) %>%
  summarize_if(is.numeric, median, na.rm = TRUE) %>%
  select(year, hf_score)


hf_in_2018 <- ef %>%
  filter(year == 2018) %>%
  select(year, countries, hf_score)

max_hf_in_2018 <- hf_in_2018 %>%
  filter(hf_score == max(hf_score, na.rm = TRUE))

min_hf_in_2018 <- hf_in_2018 %>%
  filter(hf_score == min(hf_score, na.rm = TRUE))


server <- function(input, output) {
  output$total_hf_plot <- renderPlotly({
    filtered_df <- ef %>%
      filter(countries %in% input$country_selection) %>%
      filter(year >= input$year_selection[1] & year <= input$year_selection[2])

    total_hf_plot <- ggplot(data = filtered_df) +
      geom_line(mapping = aes(x = year, y = hf_score, color = countries)) +
      labs(title = "Total Human Freedom Scores by Country", x = "Year", y = "Human Freedom Scores", color = "Country") +
      theme(plot.title = element_text(hjust = 0.5)) +
      scale_x_continuous(breaks = pretty_breaks())

    return(total_hf_plot)
  })
}
