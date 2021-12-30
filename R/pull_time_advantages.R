
pull_time_adv <- function(obj, var_in) {
  
  id <- obj$match_id
  
  tmp <- purrr::pluck(obj, var_in)
  
  time_sec <- 0:(length(tmp)-1)*60
  
  val <- unlist(tmp)
  
  out <- tibble::tibble(
    match_id = id,
    time = time_sec,
    val = val
  )
  
  names(out)[3] <- var_in
  
  out
  
}

#' Pull Radiant Gold & XP Advantage
#'
#' @param obj A 'parsed_match' object
#' 
#' @rdname pull_radiant_adv
#'
#' @return A 3-column tibble containing the match id, timestamps (in seconds),
#' and the value of the given variable at that timestamp -- either the radiant gold or experience advantage. Negative
#' values indicate dire advantage on the given metric
#' @export
#'
#' @examples \dontrun{
#' a <- get_match('6156757097')
#' b <- pull_radiant_gold_adv(a)
#' }
pull_radiant_gold_adv <- function(obj) {
  
  check_parsed_match(obj, "pull_radiant_gold_adv")
  
  pull_time_adv(obj, "radiant_gold_adv")
}

#' @rdname pull_radiant_adv
#' @export
pull_radiant_xp_adv <- function(obj) {
  
  check_parsed_match(obj, "pull_radiant_xp_adv")
  
  pull_time_adv(obj, "radiant_xp_adv")
  
}