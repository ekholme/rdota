
#' Get Player's Recent Matches
#'
#' @param player_id Steam32 account id
#' @param as_tibble logical. If TRUE, will return the result as a tibble where each row is a match. If false, will return as a nested list.
#'
#' @return
#' @export
#'
#' @examples \dontrun{
#' get_player_recent_matches('108887322')
#' }
get_player_recent_matches <- function(player_id, as_tibble = TRUE) {
  
  #check if player_id is too long & likely the 64-bit id
  check_player_id_len(player_id)
  
  #check type of as_tibble arg
  if(!is.logical(as_tibble)) {
    rlang::abort(paste0("`as_tibble` must be logical, not ", typeof(as_tibble)))
  }
  
  req_url <- sprintf('https://api.opendota.com/api/players/%s/recentMatches/', player_id)
  
  resp <- httr::GET(req_url)
  
  #checking for status errors
  httr::stop_for_status(resp)
  
  #ensure query returns json
  if (httr::http_type(resp) != "application/json") {
    stop("API did not return json", call. = FALSE)
  }
  
  content <- httr::content(resp, as = "parsed", type = "application/json")
  
  #return content as requested
  content <- if (as_tibble == TRUE) {
    purrr::map_dfr(content, compact_to_tibble)
  } else content

  return(content)
}


