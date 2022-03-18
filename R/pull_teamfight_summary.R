
#utility func to get x/y pos
extract_xy_avg <- function(obj, tf_num, ds) {
  tmp <- purrr::map(which(ds > 0), ~purrr::pluck(obj, "teamfights", tf_num, "players", .x, "deaths_pos"))
  
  xs <- purrr::map(seq(tmp), ~as.integer(names(tmp[[.x]])))
  ys <- purrr::map(seq(tmp), ~as.integer(names(tmp[[.x]][[1]])))
  
  ret <- list(
    x = mean(purrr::simplify(xs)),
    y = mean(purrr::simplify(ys))
  )
  
  ret
}

replace_teamfight_heroes <- function(obj, df, var, idx) {
  
  h <- pull_player_heroes(obj)$hero_name
  names(h) <- 1:10
  
  tmp <- as.character(df[idx, var])
  nout <- stringr::str_count(tmp, ", ") + 1
  tmp <- stringr::str_split_fixed(tmp, ", ", nout)
  
  paste0(h[tmp], collapse = ", ")
  
}


teamfight_summary <- function(obj, tf_num) {
  
  match_id <- obj$match_id
  
  tf_s <- purrr::pluck(obj, "teamfights", tf_num, "start")
  tf_e <- purrr::pluck(obj, "teamfights", tf_num, "end")
  dur <- tf_e - tf_s
  n_deaths <- purrr::pluck(obj, "teamfights", tf_num, "deaths")
  
  ds <- purrr::map_int(1:10, ~purrr::pluck(obj, "teamfights", tf_num, "players", .x, "deaths"))
  ds_log <- which(ds > 0)
  
  rd <- ds_log[ds_log <= 5]
  dd <- ds_log[ds_log > 5]
  
  rd <- if (length(rd) == 0) NA_character_ else rd
  
  dd <- if (length(dd) == 0) NA_character_ else dd
  
  xy <- extract_xy_avg(obj, tf_num, ds)
  
  tibble::tibble(
    match_id = match_id,
    start = tf_s,
    end = tf_e,
    duration = dur,
    n_deaths = n_deaths,
    radiant_deaths = paste0(rd, collapse = ", "),
    dire_deaths = paste0(dd, collapse = ", "),
    x = xy$x,
    y = xy$y
  )

}

#' Pull Teamfight Summaries
#' 
#' @description Pull a summary of each teamfight in the match. If there are no teamfights in the match, this function will throw an error
#'
#' @param obj A 'parsed_match' object
#'
#' @return A tibble with one row per teamfight and 9 columns, describing the start, end, and duration of the match, the number of deaths and heroes that died in each teamfight, and the approximate x and y locations of the teamfight
#' @export
#'
#' @examples \dontrun{
#' #note that the match must be a parsed match
#' a <- get_match(6478367207)
#' b <- pull_teamfight_summaries(a)
#' }
pull_teamfight_summaries <- function(obj) {
  
  check_parsed_match(obj, "pull_teamfight_summaries")
  
  len <- length(obj[["teamfights"]])
  
  if (len == 0) {
    rlang::abort("No teamfights in this match!")
  }
  
  x <- purrr::map_dfr(seq(len), ~teamfight_summary(obj, .x))
  
  x$radiant_deaths <- purrr::map_chr(seq(len), ~replace_teamfight_heroes(obj, x, "radiant_deaths", .x))
  x$dire_deaths <- purrr::map_chr(seq(len), ~replace_teamfight_heroes(obj, x, "dire_deaths", .x))
  
  x
  
}
