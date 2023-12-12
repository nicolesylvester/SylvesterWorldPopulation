library(tidyverse)
library(rvest)

url = 'https://en.wikipedia.org/wiki/FIFA_World_Cup'

page <- read_html(url)

page <- page %>%
  html_nodes('table') %>%
  .[[4]] %>%
  html_table(header=FALSE, fill=TRUE)

# assign the data from to World_Cup
World_Cup <- page %>%
  # name the columns
  magrittr::set_colnames(c('Year','Hosts', 'Venues/Cities',
                           'Totalattendance', 'Matches', 'Averageattendance')) %>%
  # select the needed columns
  select(Year, Hosts, Matches, Totalattendance, Averageattendance) %>%
  # remove commas and make columns numeric
  mutate(
    Totalattendance = as.numeric(str_replace_all(Totalattendance, ',', '')),
    Averageattendance = as.numeric(str_replace_all(Averageattendance, ',', '')),
    Matches = as.numeric(Matches)
  ) %>%
  drop_na(Matches) %>%
  #remove overall and years that have not occurred
  filter(Year != 'Overall' & Year < 2024)

World_Cup <- World_Cup %>%
  # paste together host and year and have no space between
  mutate(WorldCup = paste(Hosts, Year, sep = '')) %>%
  # remove old columns
  select(-Hosts, -Year) %>%
  # move new column to front
  select(WorldCup, Matches, Totalattendance, Averageattendance)

usethis::use_data(World_Cup, overwrite = TRUE)
