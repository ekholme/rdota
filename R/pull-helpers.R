#helper to gather match identifiers for pull match

gather_player_match_identifiers <- function(obj, player_num) {
  
  match_id <- obj$match_id
  
  player_slot <- purrr::pluck(obj, "players", player_num, "player_slot")
  
  account_id <- purrr::pluck(obj, "players", player_num, "account_id")
  
  account_id <- replace_null(account_id, NA_integer_)
  
  ret <- list(match_id = match_id, player_slot = player_slot, account_id = account_id)
  
  return(ret)
  
}

#function to check if an object is an rdota match and coerce if not
check_rdota_match <- function(x, fn) {
  
  cl <- class(x)
  
  if (!("rdota_match") %in% cl) {
    rlang::abort(paste0("`", fn, "` expects an object of class 'rdota_match', not ", cl))
  }
  
}

check_parsed_match <- function(x, fn) {
  
  cl <- class(x)
  
  if (cl != "parsed_match") {
    rlang::abort(paste0("`", fn, "` expects an object of class 'parsed_match', not ", cl))
  }
}

#helper to pull variables that change over time (gold, exp, etc)
pull_time_var <- function(obj, player_num, var_in, name_out) {
  
  ids <- gather_player_match_identifiers(obj, player_num)
  
  tmp <- purrr::pluck(obj, "players", player_num, var_in)
  
  time_sec <- 0:(length(tmp)-1)*60
  
  val <- unlist(tmp)
  
  out <- tibble::tibble(
    match_id = ids$match_id,
    account_id = ids$account_id,
    player_slot = ids$player_slot,
    time = time_sec,
    val = val
  )
  
  names(out)[5] <- name_out
  
  return(out)
  
}

#factory to produce similar pulling functions
pull_time_var_factory <- function(check_msg, var_in, name_out) {
  
  function(obj) {
    check_parsed_match(obj, check_msg)
    
    purrr::map_dfr(1:10, ~pull_time_var(obj = obj, player_num = .x, var_in = var_in, name_out = name_out))
  }
  
}
