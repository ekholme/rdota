#' Get Player Account Information
#'
#' @param player_id Steam32 account id
#'
#' @return
#' @export
#'
#' @examples \dontrun{
#' get_player_account_info('108887322')
#' }
get_player_account_info <- function(player_id) {
  
  #check if player_id is too long & likely the 64-bit id
  check_player_id_len(player_id)
  
  url <- 'https://api.opendota.com/api/players/'
  
  id <- if (is.numeric(player_id)) as.character(player_id)
  
  req_url <- sprintf('https://api.opendota.com/api/players/%s', player_id)
  
  resp <- httr::GET(req_url)
  
  #checking for status errors
  httr::stop_for_status(resp)
  
  content <- httr::content(resp, as = "parsed", type = "application/json")
  
  return(content)
}

