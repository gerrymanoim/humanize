

suffixes <- list(
  'decimal' =  c('kB', 'MB', 'GB', 'TB', 'PB', 'EB', 'ZB', 'YB'),
  'binary' = c('KiB', 'MiB', 'GiB', 'TiB', 'PiB', 'EiB', 'ZiB', 'YiB'),
  'gnu' = c("K","M","G","T","P","E","Z","Y")
)

#' Convert bytes to a more natural representation
#'
#' @param bytes Number of bytes
#' @param suffix_type One of 'decimal', 'binary', 'gnu'
#' @param fmt Extra number formatting
#'
#' @export
#'
#' @examples
#' natural_size(3000)
natural_size <- function(bytes, suffix_type="decimal", fmt='%.1f') {
  stopifnot(suffix_type %in% names(suffixes))
  # How much value check do I need for bytes?
  suffix <- suffixes[[suffix_type]]
  gnu <- suffix_type == "gnu"

  base <- ifelse(suffix_type %in% c('gnu', 'binary'), 1024, 1000)

  if (bytes == 1 & !gnu) {
    return("1 Byte")
  } else if (bytes < base & !gnu) {
    return(glue::glue("{bytes} Bytes"))
  } else if (bytes < base & gnu) {
    return(glue::glue("{bytes}B"))
  }

  for (i in seq_along(suffix)) {
    unit <- base ^ (i + 1)
    if (bytes < unit) {
      out_val <- sprintf(fmt,(base * bytes / unit))
      if (gnu) {
        return(glue::glue("{out_val}{suffix[[i]]}"))
      } else {
        return(glue::glue("{out_val} {suffix[[i]]}"))
      }
    }
  }

  out_val <- sprintf(fmt,(base * bytes / unit))
  if (gnu) {
    return(glue::glue("{out_val}{suffix[[length(suffix)]]}"))
  }
  return(glue::glue("{out_val} {suffix[[length(suffix)]]}"))
}
