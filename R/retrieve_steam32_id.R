#' Retrieve 32bit Steam ID
#' 
#' The OpenDota API requires a 32-bit Steam ID for player queries. This helper function will retrieve a 32-bit ID using the website steamidfinder.com
#'
#' @param long_id The 64-bit Steam ID of the player. Must be passed in as a string
#'
#' @return
#' @export
#'
#' @examples \dontrun{
#' retrieve_steam32_id("76561198069153050")
#' }
retrieve_steam32_id <- function(long_id) {
  
  if (!is.character(long_id)) {
    rlang::abort(paste0("`long_id` must be your Steam 64 bit ID passed in as a string, not as a ", typeof(long_id)))
  }
  
  idfinder <- 'https://steamidfinder.com/lookup/'
  
  site <- xml2::read_html(paste0(idfinder, long_id))
  
  out <- rvest::html_elements(site, "div")
  #note it's the 16th element of this list that we want
  
  txt <- rvest::html_text(out[[15]])
  
  lst <- stringr::str_split(txt, "\n")
  
  el <- lst[[1]][[5]]
  
  tmp <- stringr::str_remove_all(el, "\\D+")
  
  ret <- stringr::str_sub(tmp, start = 3L)  
  
  return(ret)
}

