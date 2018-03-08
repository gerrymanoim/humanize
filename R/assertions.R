#' @importFrom assertthat assert_that
assertthat::assert_that

#' @importFrom assertthat is.date
assertthat::is.date


can_be_date <- function(x) {
  !is.na(suppressWarnings(lubridate::as_date(x)))
}
