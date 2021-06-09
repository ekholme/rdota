
#' Get Match Data
#' 
#' This function queries data for a given match. It will likely be split into other functions that return more specific information
#'
#' @param match_id Match ID to query
#' @param as_tibble logical. If TRUE, will return as a 1-row tibble with some list-cols. Otherwise, will return as a nested list.
#'
#' @return
#' @export
#'
#' @examples \dontrun{
#' get_match('6019587919')
#' }
get_match <- function(match_id, as_tibble = TRUE) {
  
  req_url <- sprintf('https://api.opendota.com/api/matches/%s/', match_id)
  
  resp <- httr::GET(req_url)
  
  #checking for status errors
  httr::stop_for_status(resp)
  
  #ensure query returns json
  if (httr::http_type(resp) != "application/json") {
    stop("API did not return json", call. = FALSE)
  }
  
  content <- httr::content(resp, as = "parsed", type = "application/json")
  
  content <- if (as_tibble == TRUE) {
    tmp <- coerce_match(content)
    
    purrr::modify(tmp, cond_unlist)
    
  } else content
  
}

