


get_indiv_player_items <- function(obj, player_num) {

  ind <- c(paste0("item_", 0:5), "item_neutral", paste0("backpack_", 0:3))

  o <- purrr::map(ind, ~purrr::pluck(obj, "players", 1, player_num, .x))
  
  match_id <- obj$match_id
  
  player_slot <- purrr::pluck(obj, "players", 1, player_num, "player_slot")

  account_id <- purrr::pluck(obj, "players", 1, player_num, "account_id")
  
  account_id <- replace_null(account_id, NA_integer_)

  tibble::tibble(
    match_id = match_id,
    account_id = account_id,
    player_slot = player_slot,
    item_slot = ind,
    item = purrr::map_int(o, ~replace_null(.x, NA_integer_))
  )

}


#' TODO
#'
#' @param obj 
#'
#' @return
#' @export
#'
#' @examples
pull_player_final_items <- function(obj) {
  
  cl <- class(obj)
  
  if (!((!"rdota_match" %in% cl) | (!"match_tbl" %in% cl))) {
    rlang::abort(paste0("`pull_player_final_items` expects an object of class 'rdota_match' or 'match_tbl', not ", class(obj)))
  }
  
  obj <- if ("rdota_match" %in% class(obj) & (!"match_tbl" %in% class(obj))) {
    tidy_rdota_match(obj)
  } else obj

  t <- purrr::map(1:10, ~get_indiv_player_items(obj = obj, player_num = .x))
  
  dplyr::bind_rows(t)

}
