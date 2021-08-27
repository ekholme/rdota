
ind <- c(paste0("item_", 0:5), "item_neutral", paste0("backpack_", 0:3))

o <- purrr::map(ind, ~purrr::pluck(mt, "players", 1, 1, .x))

t <- tibble::tibble(
  item_slot = ind,
  item = purrr::map_int(o, ~replace_null(.x, NA_integer_))
)
#so, the above will work for a single player. Now we want to get them for each player

get_indiv_player_items <- function(obj, player_num) {
  
  ind <- c(paste0("item_", 0:5), "item_neutral", paste0("backpack_", 0:3))
  
  o <- purrr::map(ind, ~purrr::pluck(obj, "players", 1, player_num, .x))
  
  account_id <- purrr::pluck(obj, "players", 1, player_num, "account_id")
  
  tibble::tibble(
    account_id = account_id,
    item_slot = ind,
    item = purrr::map_int(o, ~replace_null(.x, NA_integer_))
  )
  
}

aa <- get_indiv_player_items(mt, 1)

pull_player_final_items <- function(obj) {
  
  purrr::map(1:10, ~get_indiv_player_items(obj = obj, player_num = .x))
  
}
#not sure what's going on here -- resume here later
