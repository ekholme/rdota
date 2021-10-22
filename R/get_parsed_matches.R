
#' Get Parsed Matches
#' 
#' @description Get a vector of random match ids for parsed matches.
#'
#' @param less_than_match_id Optional. If set, will return matches with a match id lower than this value.
#'
#' @return
#' @export
#'
#' @examples \dontrun{
#' #will return a random vector of parsed matches
#' a <- get_parsed_matches()
#' 
#' #will return a random vector of parsed matches with a match id less than 6192935701
#' b <- get_parsed_matches(less_than_match_id = 6192935701)
#' }
get_parsed_matches <- function(less_than_match_id = NULL) {
  
  if (!is.null(less_than_match_id) && is.na(as.numeric(less_than_match_id))) {
    rlang::abort("`less_than_match_id` must be NULL, numeric, or coercible to numeric")
  }
  
  if (!is.null(less_than_match_id) && nchar(less_than_match_id) != 10) {
    rlang::abort(paste0("`less_than_match_id` must be NULL or a valid 10-digit match id"))
  }
  
  resource <- "parsedMatches"
  
  out <- get_response(resource = resource, less_than_match_id = less_than_match_id)
  
  unlist(out)
  
}