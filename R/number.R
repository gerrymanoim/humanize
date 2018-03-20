
count_as_ordinal <- function(value) {

}

count_as_comma <- function(value, sep=",") {

}

human_powers <- 10^c(6, 9, 12, 15, 18, 21, 24, 27, 30, 33, 100)
names(human_powers) <- c(
  'million','billion','trillion','quadrillion',
  'quintillion','sextillion','septillion',
  'octillion','nonillion','decillion','googol'
)

#' Convert Large Counts into Friendly Text
#'
#' Note - currently limited to `.Machine$integer.max`.
#'
#' @param value A single positive integer
#' @param fmt Extra number formatting supplied to sprintf
#'
#' @return Returns a string with the power of a number replaced by the appropriate word.
#' @export
#'
#' @examples
#' count_as_word(100)
#' count_as_word(1000000)
#' count_as_word(1200000000)
count_as_word <- function(value, fmt='%.1f') {
  assert_that(is.count(value))

  if (value < human_powers[1]) {
    return(format(value, scientific = FALSE))
  }
  # Drop the first value, but shift our index
  for (i in seq_along(human_powers[-1]) + 1) {
    if (value < human_powers[[i]]) {
      chopped <- value / human_powers[[i - 1]]
      human_name <- names(human_powers[i - 1])
      return(paste(sprintf(fmt, chopped), human_name))
    }
  }
  # gigantic values
  # R does not seem to have percision here. TODO?
  return(format(value, scientific = FALSE))
}


ap_numbers <- c("one", "two", "three", "four", "five", "six", "seven", "eight", "nine")


#' Convert to AP Number
#'
#' @param value A single positive integer
#'
#' @return For numbers 1-9, returns the number spelled out. Otherwise, returns
#'   the number as a string.
#' @export
#'
#' @examples
#' count_as_ap(3)
#' count_as_ap(20)
count_as_ap <- function(value) {
  assert_that(is.count(value))
  if (value >= 10) {
    return(format(value, scientific = FALSE))
  }

  ap_numbers[value]
}

fractional <- function(value) {

}
