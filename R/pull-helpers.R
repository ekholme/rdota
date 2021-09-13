#helper to gather match identifiers for pull match

gather_player_match_identifiers <- function(obj, player_num) {
  
  match_id <- obj$match_id
  
  player_slot <- purrr::pluck(obj, "players", 1, player_num, "player_slot")
  
  account_id <- purrr::pluck(obj, "players", 1, player_num, "account_id")
  
  account_id <- replace_null(account_id, NA_integer_)
  
  ret <- list(match_id = match_id, player_slot = player_slot, account_id = account_id)
  
  return(ret)
  
}

#TODO add a class check/coerce helper here