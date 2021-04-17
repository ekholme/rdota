#' Test if elements inside a list are all the same size
#'
#' @param vec list vector to test
#' @param size size to check against. Should be 1 (almost?) always
#'
#' @return
#' @export
#'
#' @examples
compare_lens <- function(vec, size = 1) {
  all(purrr::map_lgl(vec, ~length(unlist(.x)) == size))
}



#' Unlist a list, if possible
#'
#' @param vec list to try to unlist
#'
#' @return
#' @export
#'
#' @examples
cond_unlist <- function(vec) {
  if (compare_lens(vec) == TRUE) {
    unlist(vec)
  } else {
    vec
  }
}