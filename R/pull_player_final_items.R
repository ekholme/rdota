

#core function inside of pull_player_final_items
get_indiv_player_items <- function(obj, player_num) {
  
  ids <- gather_player_match_identifiers(obj, player_num)

  ind <- c(paste0("item_", 0:5), "item_neutral", paste0("backpack_", 0:3))

  o <- purrr::map(ind, ~purrr::pluck(obj, "players", player_num, .x))

  tibble::tibble(
    match_id = ids$match_id,
    account_id = ids$account_id,
    player_slot = ids$player_slot,
    item_slot = ind,
    item = purrr::map_int(o, ~replace_null(.x, NA_integer_))
  )

}


#' Pull Player Final Items
#' 
#' @description Pull the final items of all players in the match.
#'
#' @param obj A 'parsed_match'  object.
#' @param include_item_names logical. If TRUE, the output will include a column containing item names in addition to a column containing item ids. If FALSE, will include only item ids.
#'
#' @return A tibble with 110 rows and 5 or 6 columns, depending on the value of the include_item_names argument.
#' @export
#'
#' @examples \dontrun{
#' a <- get_match('6156757097')
#' b <- pull_player_final_items(a)
#' }
pull_player_final_items <- function(obj, include_item_names = TRUE) {
  
  check_parsed_match(obj, "pull_player_final_items")
  
  check_logical_arg(include_item_names, "include_item_names")
  
  tmp <- purrr::map_dfr(1:10, ~get_indiv_player_items(obj = obj, player_num = .x))
  
  if (include_item_names == TRUE) {
    
    dplyr::left_join(tmp, rdota::item_ids, by = c("item" = "item_id"))
    
  } else tmp

}
