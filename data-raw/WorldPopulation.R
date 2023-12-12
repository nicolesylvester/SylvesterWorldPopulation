library(tidyverse)
library(readxl)

WorldPopulation <- read_excel("data-raw/World_Population.xlsx", sheet = "ESTIMATES",
                           range = "A17:BZ306") %>%
  # filter out anything not of type country
  filter(str_detect(Type, "Country/Area")) %>%
  # get the country name
  mutate("Country Name" = `Region, subregion, country or area *`) %>%
  # select only the country name and years
  select(`Country Name`, `1950`:`2020`)

usethis::use_data(WorldPopulation, overwrite = TRUE)

