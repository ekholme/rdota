

get_indiv_player_lanerole <- function(obj, player_num) {
  
  ids <- gather_player_match_identifiers(obj, player_num)
  
  lr <- purrr::pluck(obj, "players", player_num, "lane_role")
  
  lr <- switch(lr,
               "safe",
               "mid",
               "off")

  tb <- tibble::as_tibble(ids)

  tb$lane <- lr

  tb
}

#' Pull Lanes and Roles
#' 
#' @description Pull the lanes players played in during the laning phase as well as their roles (i.e. support/core). Roles are estimated using players' lanes and net worth at the 10 minute mark. If a game lasts less than 10 minutes, roles will not be returned.
#'
#' @param obj A 'parsed_match' object
#'
#' @return a 10-row tibble containing match/player identifiers, lane played in, and player role
#' @export
#'
#' @examples \dontrun{
#' a <- get_match('6387933253')
#' b <- pull_lane_roles(a)
#' }
pull_lane_roles <- function(obj) {
  check_parsed_match(obj, "pull_lane_roles")
  
  tmp <- purrr::map_dfr(1:10, ~get_indiv_player_lanerole(obj = obj, player_num = .x))
  
  gold <- pull_player_gold_progression(obj)
  
  ret <- if (max(gold$time, na.rm = TRUE) < 600) {
    cat("Game did not last long enough to determine player roles (i.e. support/core). Only returning lane position")
    
    return(tmp)
  } else {
    
    g <- gold[gold$time == 600,]
    g <- g[, -which(names(g) == "time")]
    
    tmp <- suppressMessages(dplyr::left_join(tmp, g))
    
    tmp <- tmp %>%
      dplyr::mutate(side = dplyr::if_else(player_slot < 100, "radiant", "dire")) %>%
      dplyr::group_by(side, lane) %>%
      dplyr::mutate(role = dplyr::if_else(gold == max(gold, na.rm = TRUE), "core", "support")) %>%
      dplyr::ungroup() %>%
      dplyr::select(-c("gold", "side"))
    
    return(tmp)
    
  }
  
  ret
}