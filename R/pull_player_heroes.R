
# xx <- gather_player_match_identifiers(mt, 1)
# 
# o <- purrr::pluck(mt, "players", 1, 1, "hero_id")
# 
# t <- as_tibble(xx)
# 
# t$hero_id <- o
# 
# t

get_indiv_player_hero <- function(obj, player_num) {
  
  ids <- gather_player_match_identifiers(obj, player_num)
  
  hero <- purrr::pluck(obj, "players", 1, player_num, "hero_id")
  
  t <- tibble::as_tibble(ids)
  
  t$hero_id <- hero
  
  t
}

#' Pull Player Heroes
#' 
#' @description Pull the hero ids/hero names for all players in a given match.
#'
#' @param obj An 'rdota_match' or 'match_tbl' object.
#' @param include_hero_names logical. If TRUE, will include a column with hero names as well as hero id. If FALSE, will only include hero id.
#'
#' @return A 10x5 tibble
#' @export
#'
#' @examples \dontrun{
#' a <- get_match('6183712050')
#' b <- pull_player_heroes(a)
#' }
pull_player_heroes <- function(obj, include_hero_names = TRUE) {
  
  check_rdota_match(obj, "pull_player_heroes")
  
  tmp <- purrr::map_dfr(1:10, ~get_indiv_player_hero(obj = obj, player_num = .x))
  
  if (include_hero_names == TRUE) {
    
    h <- dplyr::select(rdota::heroes, id, hero_name = localized_name)
    
    dplyr::left_join(tmp, h, by = c("hero_id" = "id"))
    
  } else tmp
  
}