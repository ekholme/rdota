

get_indiv_player_kda <- function(obj, player_num) {
  
  ids <- gather_player_match_identifiers(obj, player_num)
  
  keys <- c("kills", "deaths", "assists")
  
  o <- purrr::map(keys, ~purrr::pluck(obj, "players", 1, player_num, .x))
  
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
#' @param obj An 'rdota_match' or 'match_tbl' object.
#'
#' @return
#' @export
#'
#' @examples \dontrun{
#' a <- get_match('6156757097')
#' b <- pull_player_kda(a)
#' }
pull_player_kda <- function(obj) {
  
  cl <- class(obj)
  
  if (!((!"rdota_match" %in% cl) | (!"match_tbl" %in% cl))) {
    rlang::abort(paste0("`pull_player_final_items` expects an object of class 'rdota_match' or 'match_tbl', not ", class(obj)))
  }
  
  obj <- if ("rdota_match" %in% class(obj) & (!"match_tbl" %in% class(obj))) {
    tidy_rdota_match(obj)
  } else obj
  
  t <- purrr::map(1:10, ~get_indiv_player_kda(obj = obj, player_num = .x))
  
  dplyr::bind_rows(t)
}
