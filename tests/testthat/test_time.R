
today <- Sys.Date()
tomorrow <- today + 1
yesterday <- today - 1
past_date <- as.Date('2015-06-01')
test_that("natural_day works as expected", {


  expect_equal(natural_day(today), 'today')
  expect_equal(natural_day(tomorrow), 'tomorrow')
  expect_equal(natural_day(yesterday), 'yesterday')
  expect_equal(natural_day(past_date), "Jun 01")
  # TODO Error tests

})


test_that("natural_date works as expected", {
  past_date <- as.Date('2015-06-01')

  expect_equal(natural_date(today), 'today')
  expect_equal(natural_date(tomorrow), 'tomorrow')
  expect_equal(natural_date(yesterday), 'yesterday')
  expect_equal(natural_date(past_date), "Jun 01 2015")
  # TODO Error tests

})
