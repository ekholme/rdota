#helper to gather match identifiers for pull match

gather_player_match_identifiers <- function(obj, player_num) {
  
  match_id <- obj$match_id
  
  player_slot <- purrr::pluck(obj, "players", 1, player_num, "player_slot")
  
  account_id <- purrr::pluck(obj, "players", 1, player_num, "account_id")
  
  account_id <- replace_null(account_id, NA_integer_)
  
  ret <- list(match_id = match_id, player_slot = player_slot, account_id = account_id)
  
  return(ret)
  
}

#function to check if an object is an rdota match and coerce if not
check_rdota_match <- function(x) {
  
  cl <- class(x)
  
  if (!("rdota_match" %in% cl | "match_tbl" %in% cl)) {
    rlang::abort(paste0("`pull_player_final_items` expects an object of class 'rdota_match' or 'match_tbl', not ", cl))
  }
  
  ret <- if ("rdota_match" %in% cl & (!"match_tbl" %in% cl)) {
    tidy_rdota_match(x)
  } else x
  
  ret
}
