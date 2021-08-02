#' Get Player Account Information
#'
#' @param player_id Steam32 account id
#' @param content_only logical. If TRUE, return only the content (i.e. the player account info) of the query. If FALSE, return an 'rdota' object with additional metadata
#'
#' @return
#' @export
#'
#' @examples \dontrun{
#' get_player_account_info('108887322')
#' }
get_player_account_info <- function(player_id, content_only = TRUE) {
  
  #check if player_id is too long & likely the 64-bit id
  check_player_id_len(player_id)
  
  id <- if (is.numeric(player_id)) as.character(player_id)
  
  req_url <- sprintf('https://api.opendota.com/api/players/%s', player_id)
  
  out <- get_response(url = req_url)
  
  if (content_only == TRUE) {
    out$content
  } else out
}

