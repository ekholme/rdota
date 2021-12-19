

get_indiv_player_kda <- function(obj, player_num) {
  
  ids <- gather_player_match_identifiers(obj, player_num)
  
  keys <- c("kills", "deaths", "assists")
  
  o <- purrr::map(keys, ~purrr::pluck(obj, "players", player_num, .x))
  
  tmp <- tibble::tibble(
    match_id = ids$match_id,
    account_id = ids$account_id,
    player_slot = ids$player_slot,
    key = keys,
    val = purrr::map_int(o, ~replace_null(.x, NA_integer_))
  )
  
  tidyr::pivot_wider(tmp, names_from = key, values_from = val)
}

#' Pull Player KDA
#' 
#' @description Pull the final kills-deaths-assists (KDA) scores for all players in a match.
#'
#' @param obj A 'parsed_match' object.
#'
#' @return
#' @export
#'
#' @examples \dontrun{
#' a <- get_match('6156757097')
#' b <- pull_player_kda(a)
#' }
pull_player_kda <- function(obj) {
  
  check_parsed_match(obj, "pull_player_kda")
  
  purrr::map_dfr(1:10, ~get_indiv_player_kda(obj = obj, player_num = .x))
  
}
