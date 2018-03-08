
right_now <- function() {
  Sys.time()
}

today <- function() {
  Sys.Date()
}

natural_delta <- function(value, months=TRUE) {

}


natural_time <- function(value, future=FALSE, months=TRUE) {

}



#' Natural Day
#'
#' For date values that are tomorrow, today or yesterday compared to present day
#' returns representing string. Otherwise, returns a string formatted according
#' to `format`
#'
#' @param value
#' @param format
#'
#' @return
#' @export
#'
#' @examples
natural_day <- function(value, format='%b %d') {
  assert_that(is.date(value))
  delta <- value - today()

  if(delta == 0) {
    out <- 'today'
  } else if(delta == 1) {
    out <- 'tomorrow'
  } else if(delta == -1) {
    out <- 'yesterday'
  } else {
    out <- format(value, format)
  }

  out
}

#' Natural Date
#'
#' Like naturalday, but will append a year for dates that are a year ago or
#' more.
#'
#' @param value
#'
#' @return
#' @export
#'
#' @examples
natural_date <- function(value) {
  assert_that(is.date(value))
  delta <- abs(value - today())
  if(delta >= 365) {
    return(natural_day(value, '%b %d %Y'))
  } else {
    return(natural_day(value))
  }
}
