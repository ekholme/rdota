#' Get Player Account Information
#'
#' @param player_id Steam32 player id to get info for
#'
#' @return
#' @export
#'
#' @examples \dontrun{
#' get_player_account_info('108887322')
#' }
get_player_account_info <- function(player_id) {
  
  #check if player_id is too long & likely the 64-bit id
  if (nchar(player_id) > 11) {
    rlang::abort(paste0("The `player_id` you've passed in has too many (", nchar(player_id), ") digits. Please be sure to use the Steam32 ID rather than the 64-bit ID"))
  }
  
  url <- 'https://api.opendota.com/api/players/'
  
  id <- if (is.numeric(player_id)) as.character(player_id)
  
  req_url <- sprintf('https://api.opendota.com/api/players/%s', player_id)
  
  resp <- httr::GET(req_url)
  
  #checking for status errors
  httr::stop_for_status(resp)
  
  content <- httr::content(resp, as = "parsed", type = "application/json")
  
  return(content)
}

