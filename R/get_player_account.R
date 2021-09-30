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
  
  id <- if (is.numeric(player_id)) as.character(player_id)
  
  resource <- sprintf('players/%s', player_id)
  
  tmp <- get_response(resource = resource)
  
  tmp <- purrr::modify_depth(tmp, 1, replace_null)
  
  ret <- tidyr::pivot_wider(tibble::enframe(tmp),
                            names_from = name,
                            values_from = value)
  
  ret <- purrr::modify(ret, cond_unlist)
  
  class(ret) <- append(class(ret), "rdota_player_account")
  
  return(ret)
}

