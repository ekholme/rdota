
#' Get Match Data
#' 
#' This function queries data for a given match. You can use it in conjunction with several pull_*() helpers to get and tidy match data
#'
#' @param match_id Match ID to query
#'
#' @return
#' @export
#'
#' @examples \dontrun{
#' get_match('6019587919')
#' }
get_match <- function(match_id) {
  
  req_url <- sprintf('https://api.opendota.com/api/matches/%s/', match_id)
  
  out <- get_response(url = req_url)
  
  #append the 'rdota_match' class to the object
  class(out) <- append(class(out), "rdota_match")
  
  return(out)
  
  
}

