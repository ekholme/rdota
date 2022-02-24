extract_ycount <- function(obj, player_num, x, ids) {
    yc <- purrr::pluck(obj, "players", player_num, "lane_pos", x)

    tmp <- tibble::tibble(
        match_id = ids$match_id,
        account_id = ids$account_id,
        player_slot = ids$player_slot,
        x = x,
        y = names(yc),
        n = as.integer(yc)
    )

    return(tmp)
}

indiv_player_xy <- function(obj, player_num) {
    ids <- gather_player_match_identifiers(obj, player_num)

    xs <- names(purrr::pluck(obj, "players", player_num, "lane_pos"))

    purrr::map_dfr(xs, ~extract_ycount(obj, player_num, x = .x, ids = ids))
}

#' Pull Player Locations
#' 
#' @description Pull the x/y locations of each player throughout the match
#'
#' @param obj A 'parsed_match'
#'
#' @return A tibble including identifiers, x/y coordinates, and a count of player appearances at those coordinates
#' @export
#'
#' @examples \dontrun{
#' #note that this requires a parsed match
#' a <- get_match('6183712050')
#' b <- pull_player_xy(a)
#' }
pull_player_xy <- function(obj) {
    check_parsed_match(obj, "pull_player_xy")

    purrr::map_dfr(1:10, ~indiv_player_xy(obj = obj, player_num = .x))
}