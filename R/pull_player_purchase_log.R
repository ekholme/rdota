

get_indiv_player_plog <- function(obj, player_num) {
  
  ids <- gather_player_match_identifiers(obj, player_num)
  
  plog <- purrr::pluck(obj, "players", 1, player_num, "purchase_log")
  
  plog_tb <- tibble::tibble(
    match_id = ids$match_id,
    account_id = ids$account_id,
    player_slot = ids$player_slot,
    time = purrr::map_int(plog, "time"),
    item = purrr::map_chr(plog, "key")
  )
  
}

#' Pull Player Purchase Logs
#' 
#' @description Pull the purchase logs, purchased items and time of purchase, for all players in a match
#'
#' @param obj An 'rdota_match' object.
#'
#' @return
#' @export
#'
#' @examples \dontrun{
#' #first get an rdota_match object
#' a <- get_match(6277359804)
#' 
#' #then pull the purchase logs
#' plog <- pull_player_purchase_logs(a)
#' }
pull_player_purchase_logs <- function(obj) {
  
  check_rdota_match(obj, "pull_player_purchase_logs")
  
  purrr::map_dfr(1:10, ~get_indiv_player_plog(obj = obj, player_num = .x))
}
