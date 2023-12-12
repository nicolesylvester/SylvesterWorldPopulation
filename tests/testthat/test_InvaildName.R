library(testthat)
library(SylvesterWorldPopulation)


test_that('Country name is present in data', {

  expect_error(CountryPopulation("Nicole's World"))
  expect_error(CountryPopulation("America"))
  expect_no_error(CountryPopulation("Mexico"))
})
