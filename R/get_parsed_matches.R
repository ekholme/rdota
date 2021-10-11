
#' Get Parsed Matches
#' 
#' @description Get a vector of random match ids from parsed matches.
#'
#' @param less_than_match_id Optional. If set, will return matches with a match id lower than this value.
#' @param simplify logical. If TRUE, will return the result as a numeric vector of match ids. If FALSE, will return raw the API response
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
get_parsed_matches <- function(less_than_match_id = NULL, simplify = TRUE) {
  
  if (!is.null(less_than_match_id) && is.na(as.numeric(less_than_match_id))) {
    rlang::abort("`less_than_match_id` must be numeric or coercible to numeric")
  }
  
  if (!is.null(less_than_match_id) && nchar(less_than_match_id) != 10) {
    rlang::abort(paste0("`less_than_match_id` must be NULL or a valid 10-digit match id"))
  }
  
  if (!is.logical(simplify)) {
    rlang::abort('`simplify` must be either TRUE or FALSE')
  }
  
  resource <- "parsedMatches"
  
  # args <- list(less_than_match_id = less_than_match_id)
  # 
  # req_url <- httr::parse_url("https://api.opendota.com/api/parsedMatches/")
  # 
  # req_url$scheme <- 'https'
  # 
  # req_url$query <- args
  # 
  # req_url <- httr::build_url(req_url)
  # 
  # ret <- get_response(req_url)
  # 
  # if (simplify == TRUE) {
  #   unlist(ret$content)
  # } else ret
  
}