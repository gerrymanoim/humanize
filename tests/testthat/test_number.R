context("test_number.R")
test_that("count_as_ap works as expected", {
  test_input <- c(1, 2, 4, 5, 9, 10, 1000000000)
  test_output <- test_input %>%
    purrr::map_chr(count_as_ap)
  results <- c("one", "two", "four", "five", "nine", "10", "1000000000")

  purrr::walk2(test_output, results, expect_match)

  expect_error(count_as_ap(-1))
  expect_error(count_as_ap("test"))

})

test_that("count_as_word works as expected", {
  test_input <- c(100, 1000000, 1200000, 1290000, 1000000000,
                  2000000000)
  test_output <- test_input %>%
    purrr::map_chr(count_as_word)
  results <- c('100', '1.0 million', '1.2 million', '1.3 million',
              '1.0 billion', '2.0 billion')

  purrr::walk2(test_output, results, expect_match)
})
