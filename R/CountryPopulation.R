#' A function that takes in the country's name and
#' returns a graph that shows the population from 1950 to 2020.
#'
#'@param countryName the country name as a string
#'
#'@return A graph the shows country's population from 1950 to 2020.
#'@export

CountryPopulation <- function(countryName)
{
  if(!countryName %in% WorldPopulation$`Country Name`)
  {
    stop('Error, country name does not exist')
  }

  # pivot the data so i can get the population
  WorldPopPivot <- WorldPopulation %>%
    pivot_longer(cols = `1950`:`2020`,
                 names_to = "Year",
                 values_to = "Population") %>%
    # make year and population numeric
    mutate(
      Year = as.numeric(Year),
      Population = as.numeric(Population)
    ) %>%
    # get only the input country
    filter(`Country Name` == countryName)

  # create the graph
  graph <- ggplot(WorldPopPivot, aes(x = Year, y = Population)) +
    geom_line() +
    labs(x = "Year", y = "Population",
         title = paste('Population Growth from 1960 to 2020 for',countryName)) +
    theme(plot.title = element_text(size = 8, hjust = 0.5))

  return(graph)
}
