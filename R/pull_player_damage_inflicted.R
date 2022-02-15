
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

indiv_player_damage_inflicted_recip <- function(obj, player_num) {
  
  ids <- gather_player_match_identifiers(obj, player_num)
  
  d <- names(purrr::pluck(obj, "players", player_num, "damage_inflictor"))
  
  tmp <- purrr::map(d, ~purrr::pluck(obj, "players", player_num, "damage_targets", .x))
  
  names(tmp) <- d
  
  dmg <- purrr::map_dfr(names(tmp), ~tibble::tibble(
    match_id = ids$match_id,
    account_id = ids$account_id,
    player_slot = ids$player_slot,
    damage_source = .x,
    hero_target = names(tmp[[.x]]),
    damage_amount = tmp[[.x]]
  ))
  
  dmg$damage_source <- gsub("null", "auto_attack", dmg$damage_source)
  dmg$hero_target <- gsub("npc_dota_hero_", "", dmg$hero_target)
  
  return(dmg)
  
}


#' Pull Player Damage Inflicted
#' 
#' @description Pull the amount of damage inflicted by player by source (abilities, items, and auto-attacks) to all enemy heroes. This will not include damage done to NPCs. With 'by_hero_recipient' set to FALSE (the default), this will return the sum of damage done (by player by source) to all enemy heroes. Setting 'by_hero_recipient' to TRUE will break out damage done by each source to each enemy hero.
#'
#' @param obj A 'parsed_match' object
#' @param by_hero_recipient logical. If FALSE (the default), return the sum of damage by ability to all enemy heroes. If TRUE, return damage done by ability to each enemy hero.
#'
#' @return A tibble, including identifiers and the amount of damage done by each source
#' @export
#'
#' @examples \dontrun{
#' #note that this requires a parsed match
#' a <- get_match('6183712050')
#' b <- pull_player_damage_inflicted(a)
#' 
#' #if you want damage done to each enemy hero by ability, set 'by_hero_recipient' to TRUE:
#' x <- pull_player_damage_inflicted(a, by_hero_recipient = TRUE)
#' }
pull_player_damage_inflicted <- function(obj, by_hero_recipient = FALSE) {
  
  check_parsed_match(obj, "pull_player_damage_inflicted")
  
  check_logical_arg(by_hero_recipient, "by_hero_recipient")
  
 if (by_hero_recipient == TRUE) {
   
   purrr::map_dfr(1:10, ~indiv_player_damage_inflicted_recip(obj = obj, player_num = .x))
   
 } else purrr::map_dfr(1:10, ~indiv_player_damage_inflicted(obj = obj, player_num = .x))
  
}
