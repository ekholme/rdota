
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
  
  resp <- httr::GET(req_url)
  
  #checking for status errors
  httr::stop_for_status(resp)
  
  #ensure query returns json
  if (httr::http_type(resp) != "application/json") {
    stop("API did not return json", call. = FALSE)
  }
  
  content <- httr::content(resp, as = "parsed", type = "application/json")
  
  structure(
    list(
      content = content,
      url = req_url,
      resp = resp
    ),
    class = "rdota_match"
  )
  
}

