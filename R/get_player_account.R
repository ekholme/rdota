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
get_player_account_info <- function(player_id, tidy = TRUE) {
  
  #check if player_id is too long & likely the 64-bit id
  check_player_id_len(player_id)
  
  check_tidy_arg(tidy)
  
  id <- if (is.numeric(player_id)) as.character(player_id)
  
  resource <- sprintf('players/%s', player_id)
  
  tmp <- get_response(resource = resource)
  
  out <- purrr::modify_depth(tmp, 1, replace_null)
  
  out <- if (tidy == TRUE) {
    tidy_response(out, "rdota_player_account")
  } else out
  
  return(out)
  
}

