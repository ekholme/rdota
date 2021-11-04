
#' Get Pro Matches
#'
#' @description Get a selection of randomly sampled pro matches.
#' 
#' @param less_than_match_id Optional. Get matches with a match ID lower than this value
#'
#' @return a tibble containing a limited set of information about the match. Passing match ids to \code{\link{get_match}}
#' can provide more data about individual matches
#' @export
#'
#' @examples \dontrun{
#' a <- get_pro_matches()
#' 
#' #or if you want to limit to less than a certain match id
#' b <- get_pro_matches(less_than_match_id = 6257294935)
#' }
get_pro_matches <- function(less_than_match_id = NULL) {
  
  if (!is.null(less_than_match_id) && is.na(as.numeric(less_than_match_id))) {
    rlang::abort("`less_than_match_id` must be numeric or coercible to numeric")
  }
  
  if (!is.null(less_than_match_id) && nchar(less_than_match_id) != 10) {
    rlang::abort(paste0("`less_than_match_id` must be NULL or a valid 10-digit match id"))
  }
  
  resource <- "proMatches"
  
  resp <- get_response(resource = resource, less_than_match_id = less_than_match_id)
  
  purrr::map_dfr(1:length(resp), ~purrr::modify_depth(resp[.x], 1, ~replace_null(.x, NA_integer)))
}