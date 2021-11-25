
pull_player_gold_progression <- function(obj) {
  
  check_rdota_match(obj, "pull_player_gold_progression")
  
  purrr::map_dfr(1:10, ~pull_time_var(obj = obj, player_num = .x, var_in = "gold_t", name_out = "gold"))
}

pull_player_xp_progression <- function(obj) {
  
  check_rdota_match(obj, "pull_player_xp_progression")
  
  purrr::map_dfr(1:10, ~pull_time_var(obj = obj, player_num = .x, var_in = "xp_t", name_out = "xp"))
}

pull_player_last_hit_progression <- function(obj) {
  
  check_rdota_match(obj, "pull_player_last_hit_progression")
  
  purrr::map_dfr(1:10, ~pull_time_var(obj = obj, player_num = .x, var_in = "lh_t", name_out = "last_hits"))
}

pull_player_deny_progression <- function(obj) {
  
  check_rdota_match(obj, "pull_player_deny_progression")
  
  purrr::map_dfr(1:10, ~pull_time_var(obj = obj, player_num = .x, var_in = "dn_t", name_out = "denies"))
}