
indiv_player_ability_upgrades <- function(obj, player_num) {
  
  ids <- gather_player_match_identifiers(obj, player_num)
  
  abs <- purrr::pluck(obj, "players", player_num, "ability_upgrades_arr")
  
  tmp <- tibble::tibble(
    match_id = ids$match_id,
    account_id = ids$account_id,
    player_slot = ids$player_slot,
    level = seq_along(abs),
    ability_id = as.character(abs)
  )
  
  tmp <- dplyr::left_join(tmp, rdota::ability_ids, by = "ability_id")
  
  tmp$ability_name <- as.character(tmp$ability_name)
  
  tmp
}


#' Pull Player Ability Upgrades
#' 
#' @description Pull the ability upgrades chosen for each hero at each level in a match
#'
#' @param obj A 'parsed_match' object
#'
#' @return
#' @export
#'
#' @examples \dontrun{
#' #note that this will only work with a parsed match
#' a <- get_match('6183712050')
#' b <- pull_player_ability_upgrades(a)
#' }
pull_player_ability_upgrades <- function(obj) {
  
  check_parsed_match(obj, "pull_player_ability_upgrades")
  
  purrr::map_dfr(1:10, ~indiv_player_ability_upgrades(obj = obj, player_num = .x))
}
