
#' Get Player's Recent Matches
#'
#' @param player_id Steam32 account id
#' @param tidy logical. If TRUE, will return the result as a tibble where each row is a match. If false, will return the raw body of the response as a list.
#'
#' @return
#' @export
#'
#' @examples \dontrun{
#' get_player_recent_matches('108887322')
#' }
get_player_recent_matches <- function(player_id, tidy = TRUE) {
  
  #check if player_id is too long & likely the 64-bit id
  check_player_id_len(player_id)
  
  check_tidy_arg(tidy)
  
  resource <- sprintf("players/%s/recentMatches/", player_id)
  
  out <- get_response(resource = resource)
  
  #return the data compacted as a tibble if requested; otherwise return the raw response
  if (tidy == TRUE) {
    purrr::map_dfr(out, compact_to_tibble)
  } else out
  
}


