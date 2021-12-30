
#' Pull Time Varying Player Variables
#' 
#' @description These functions will pull the progression of the given
#' variable (denies, last hits, experience, or gold) over time for each player in a match.
#' 
#' @param obj A 'parsed_match' object.
#' 
#' @return A 5-column tibble containing match and player identifying information, timestamps (in seconds),
#' and the value of the given variable at that timestamp
#' @export
#' @rdname pull_player_time_varying
#' 
#' @examples \dontrun{
#' a <- get_match('6156757097')
#' b <- pull_player_last_hit_progression(a)
#' }
pull_player_deny_progression <- pull_time_var_factory(check_msg = "pull_player_deny_progression", 
                                                  var_in = "dn_t",
                                                  name_out = "denies")

#' @rdname pull_player_time_varying
#' @export
pull_player_last_hit_progression <- pull_time_var_factory(check_msg = "pull_player_last_hit_progression", 
                                                  var_in = "lh_t",
                                                  name_out = "last_hits")

#' @rdname pull_player_time_varying
#' @export
pull_player_xp_progression <- pull_time_var_factory(check_msg = "pull_player_xp_progression", 
                                                          var_in = "xp_t",
                                                          name_out = "xp")

#' @rdname pull_player_time_varying
#' @export
pull_player_gold_progression <- pull_time_var_factory(check_msg = "pull_player_gold_progression", 
                                                          var_in = "gold_t",
                                                          name_out = "gold")