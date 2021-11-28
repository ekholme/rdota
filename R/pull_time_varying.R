
pull_player_deny_progression <- pull_time_var_factory(check_msg = "pull_player_deny_progression", 
                                                  var_in = "dn_t",
                                                  name_out = "denies")

pull_player_last_hit_progression <- pull_time_var_factory(check_msg = "pull_player_last_hit_progression", 
                                                  var_in = "lh_t",
                                                  name_out = "last_hits")

pull_player_xp_progression <- pull_time_var_factory(check_msg = "pull_player_xp_progression", 
                                                          var_in = "xp_t",
                                                          name_out = "xp")

pull_player_gold_progression <- pull_time_var_factory(check_msg = "pull_player_gold_progression", 
                                                          var_in = "gold_t",
                                                          name_out = "gold")