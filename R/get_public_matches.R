
get_public_matches <- function(less_than_match_id = NULL, mmr_ascending = NULL, mmr_descending = NULL) {
  
  if (!is.null(less_than_match_id) && is.na(as.numeric(less_than_match_id))) {
    rlang::abort("`less_than_match_id` must be numeric or coercible to numeric")
  }
  
  if (!is.null(less_than_match_id) && nchar(less_than_match_id) != 10) {
    rlang::abort(paste0("`less_than_match_id` must be NULL or a valid 10-digit match id"))
  }
  
  resource <- "publicMatches"
  
  out <- get_response(resource = resource, less_than_match_id = less_than_match_id, mmr_ascending = mmr_ascending,
                      mmr_descending = mmr_descending)
  
  out
  
  #next step is to turn this into a tibble. need to use a combination of map, as_tibble, and the func below to replace NULLs
  #purrr::modify_depth(yy, 1, ~replace_null(.x, NA_integer_))
  
  #also need to add some checks for mmr_ascending and mmr_descending
  
  #and functionality to unpack the heroes
}

