
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
  
  #tmp$level <- seq_along(abs)
  
  #tmp$ability_id <- as.character(abs)
  
  tmp <- dplyr::left_join(tmp, rdota::ability_ids, by = "ability_id")
  
  tmp$ability_name <- as.character(tmp$ability_name)
  
  tmp
}

#RESUME HERE WITH ITERATION AND DOCUMENTATION