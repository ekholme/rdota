
#' Get Public Matches
#' 
#' @description Get a selection of randomly sampled public matches. 
#'
#' @param less_than_match_id Optional. Get matches with a match ID lower than this value
#' @param mmr_ascending Optional. If TRUE, will order results by ascending MMR. Cannot be TRUE if mmr_descending is TRUE.
#' @param mmr_descending Optional. If TRUE, will order results by descending MMR. Cannot be TRUE if mmr_ascending is TRUE.
#' @param use_hero_names Logical. If TRUE, will return hero names instead of IDs. If FALSE, will return hero IDs.
#'
#' @return a tibble containing a limited set of information about the match
#' @export
#'
#' @examples \dontrun{
#' a <- get_public_matches()
#' b <- get_public_matches(less_than_match_id = 6192935701)
#' }
get_public_matches <- function(less_than_match_id = NULL, mmr_ascending = NULL, mmr_descending = NULL, use_hero_names = TRUE) {
  
  if (!is.null(less_than_match_id) && is.na(as.numeric(less_than_match_id))) {
    rlang::abort("`less_than_match_id` must be numeric or coercible to numeric")
  }
  
  if (!is.null(less_than_match_id) && nchar(less_than_match_id) != 10) {
    rlang::abort(paste0("`less_than_match_id` must be NULL or a valid 10-digit match id"))
  }
  
  if (!is.null(mmr_ascending) && !(mmr_ascending == TRUE)) {
    rlang::abort(paste0("`mmr_ascending` must be NULL or TRUE"))
  }
  
  if (!is.null(mmr_descending) && !(mmr_descending == TRUE)) {
    rlang::abort(paste0("`mmr_descending` must be NULL or TRUE"))
  }
  
  if (sum(mmr_ascending + mmr_descending) > 1) {
    rlang::abort(paste0("sort by either `mmr_ascending` or `mmr_descending`, not both"))
  }
  
  check_logical_arg(use_hero_names, "use_hero_names")
  
  resource <- "publicMatches"
  
  resp <- get_response(resource = resource, less_than_match_id = less_than_match_id, mmr_ascending = mmr_ascending,
                      mmr_descending = mmr_descending)
  
  out <- purrr::map_dfr(1:length(resp), ~purrr::modify_depth(resp[.x], 1, ~replace_null(.x, NA_integer)))
  
  out <- if (use_hero_names == TRUE) {
    
    out$radiant_team <- purrr::map_chr(1:length(resp), ~replace_hero_ids(out, "radiant_team", .x))
    out$dire_team <- purrr::map_chr(1:length(resp), ~replace_hero_ids(out, "dire_team", .x))
    
    out

  } else out
  
  return(out)
  
}



