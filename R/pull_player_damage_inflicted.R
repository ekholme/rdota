
#note that this tracks damage to all enemy heroes -- not to npcs
indiv_player_damage_inflicted <- function(obj, player_num) {
  
  ids <- gather_player_match_identifiers(obj, player_num)
  
  d <- purrr::pluck(obj, "players", player_num, "damage_inflictor")
  
  names(d) <- gsub("null", "auto_attack", names(d))
  
  tmp <- tibble::tibble(
    match_id = ids$match_id,
    account_id = ids$account_id,
    player_slot = ids$player_slot,
    damage_source = names(d),
    damage_amount = as.integer(d)
  )
  
  return(tmp)
  
}

#' Pull Player Damage Inflicted
#' 
#' @description Pull the amount of damage inflicted by player by source (abilities, items, and auto-attacks) to all enemy heroes. This will not include damage done to NPCs.
#'
#' @param obj A 'parsed_match' object
#'
#' @return A 5-column tibble, including identifiers and the amount of damage done by each source
#' @export
#'
#' @examples \dontrun{
#' #note that this requires a parsed match
#' a <- get_match('6183712050')
#' b <- pull_player_damage_inflicted(a)
#' }
pull_player_damage_inflicted <- function(obj) {
  
  check_parsed_match(obj, "pull_player_damage_inflicted")
  
  purrr::map_dfr(1:10, ~indiv_player_damage_inflicted(obj = obj, player_num = .x))
  
}

##TODO -- add an option to break out by recipient