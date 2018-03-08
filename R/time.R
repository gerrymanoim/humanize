
now <- function() {
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
#' For date values that are tomorrow, today or yesterday compared to present day returns representing string. Otherwise, returns a string formatted according to `format`
#'
#' @param value
#' @param format
#'
#' @return
#' @export
#'
#' @examples
natural_day <- function(value, format=NULLl) {
  value <- lubridate::as_date(value) # TODO make safe
  delta <- value - now()

  switch(delta,
         0 = 'today',
         1 = 'tomorrow',
         -1 = 'yesterday',
         format(value, format)
  )

}

natural_date <- function(value) {

}
