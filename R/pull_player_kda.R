
# library(tidyverse)
# 
# keys <- c("kills", "deaths", "assists")

get_indiv_player_kda <- function(obj, player_num) {
  
  keys <- c("kills", "deaths", "assists")
  
  match_id <- obj$match_id
  
  player_slot <- purrr::pluck(obj, "players", 1, player_num, "player_slot")
  
  account_id <- purrr::pluck(obj, "players", 1, player_num, "account_id")
  
  account_id <- replace_null(account_id, NA_integer_)
  #make all of the above into a function
  
  o <- purrr::map(keys, ~purrr::pluck(obj, "players", 1, player_num, .x))
  
  tmp <- tibble::tibble(
    match_id = match_id,
    account_id = account_id,
    player_slot = player_slot,
    key = keys,
    val = purrr::map_int(o, ~replace_null(.x, NA_integer_))
  )
  
  tidyr::pivot_wider(tmp, names_from = key, values_from = val)
}

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
