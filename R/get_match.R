
#' Get Match Data
#' 
#' This function queries data for a given match. You can use it in conjunction with several pull_*() helpers to get and tidy match data
#'
#' @param match_id Match ID to query
#' @param tidy logical. If TRUE (the default), will return a tidied tibble with class "rdota_match." If FALSE, will return the raw response body as a list.
#'
#' @return
#' @export
#'
#' @examples \dontrun{
#' a <- get_match('6019587919')
#' }
get_match <- function(match_id) {
  
  if (nchar(match_id) != 10) {
    rlang::abort(paste0("`match_id` must be a valid 10-digit match id"))
  }
  
  resource <- sprintf("matches/%s", match_id)
  
  out <- get_response(resource = resource)
  
  # out <- if (tidy == TRUE) {
  #   tidy_response(out, "rdota_match")
  # } else out
  
  new_match_class(out)
  
}
#list of length 43 is a parsed match; list of length 39 is an unparsed match
