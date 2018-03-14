
#' @importFrom lubridate now
lubridate::now

#' @importFrom lubridate today
lubridate::today

#' Takes in a number of seconds and computes a "human" delta
#'
#' @param seconds A positive number of seconds
#' @param use_months Boolean whether we should (imprecisely) use months as a unit
#'
#' @seealso `natural_time`
#' @export
seconds_to_natural_delta <- function(seconds, use_months=TRUE) {
  seconds_in_day <- 60*60*24

  seconds <- abs(seconds)
  days <- trunc(seconds/seconds_in_day)
  years <- trunc(days/365)
  days <- days %% ifelse(years == 0, 365, 365*years)
  months <- trunc(days / 30.5) #interpolate
  # with much thanks to humanize (python)
  if (years == 0) {
    if (days < 1) {
      if (seconds == 0) {
        return("now")
      } else if (seconds == 1) {
        return("a second")
      } else if (seconds < 60) {
        return(glue::glue("{seconds} seconds"))
      } else if (60 <= seconds & seconds < 120) {
        return("a minute")
      } else if ( 120 <= seconds & seconds < 3600) {
        minutes = trunc(seconds / 60)
        return(glue::glue("{minutes} minutes"))
      } else if ( 3600 <= seconds & seconds < (3600 * 2)) {
        return("an hour")
      } else if ( 3600 < seconds) {
        hours = trunc(seconds / 3600)
        return(glue::glue("{hours} hours"))
      }
    } else {
      if (days == 1) {
        return("a day")
      }
      if (!use_months) {
        return(glue::glue("{days} days"))
      } else {
        if (months == 0) {
          return(glue::glue("{days} days"))
        } else if (months == 1) {
          return("a month")
        } else {
          return(glue::glue("{months} months"))
        }
      }
    }
  } else if (years == 1) {
    if (months == 0) {
      if (days == 0) {
        return("a year")
      } else if (days == 1) {
        return(glue::glue("1 year, 1 day"))
      } else {
        return(glue::glue("1 year, {days} days"))
      }
    } else if (use_months) {
      if (months == 1) {
        return("1 year, 1 month")
      } else {
        return(glue::glue("1 year, {months} months"))
      }
    } else {
      return(glue::glue("1 year, {days} days"))
    }
  } else {
    return(glue::glue("{years} years"))
  }
}



#' Convert times to natural values relative to now.
#'
#' Given a datetime or a number of seconds, return a natural representation of
#' that resolution that makes sense. Ago/From now determined by positive or
#' negative values.
#'
#' @param value a datetime or a number of seconds
#' @param use_months Boolean whether we should (imprecisely) use months as a
#'   unit
#'
#' @export
#' @examples
#' natural_time(Sys.time()-1)
#' natural_time(Sys.time()-100)
natural_time <- function(value, use_months=TRUE) {
  if (assertthat::is.number(value)) {
    interval_seconds <- value
  } else {
    time_diff <- lubridate::interval(value, now())
    interval_seconds <- lubridate::time_length(time_diff, "seconds")
  }
  if (interval_seconds >= 0) {
    future <- FALSE
  } else {
    future <- TRUE
  }
  interval_seconds <- abs(interval_seconds)
  natural_delta <- seconds_to_natural_delta(trunc(interval_seconds), use_months)
  if (natural_delta == "now") {
    return(natural_delta)
  }

  rel_str <- ifelse(future, "from now", "ago")
  paste(natural_delta, rel_str)
}



#' Natural Day
#'
#' For date values that are tomorrow, today or yesterday compared to present day
#' returns representing string. Otherwise, returns a string formatted according
#' to `format`
#'
#' @param value A date value
#' @param format Optional formatting string for dates not yesterday, today, tomorrow
#'
#' @return A nicely formatted date
#' @export
#'
#' @examples
#' natural_day(Sys.Date())
#' natural_day(Sys.Date()-10)
natural_day <- function(value, format='%b %d') {
  assert_that(is.date(value))
  delta <- value - today()

  if (delta == 0) {
    out <- 'today'
  } else if (delta == 1) {
    out <- 'tomorrow'
  } else if (delta == -1) {
    out <- 'yesterday'
  } else {
    out <- format(value, format)
  }

  out
}

#' Natural Date
#'
#' Like natural day, but will append a year for dates that are a year or
#' more in the past or future
#'
#' @param value A Date value
#'
#' @export
#' @seealso `natural_day`
#' @examples
#' natural_date(Sys.Date())
#' natural_date(Sys.Date()-10)
natural_date <- function(value) {
  assert_that(is.date(value))
  delta <- abs(value - today())
  if (delta >= 365) {
    return(natural_day(value, '%b %d %Y'))
  } else {
    return(natural_day(value))
  }
}
