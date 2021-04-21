#' Retrieve 32bit Steam ID
#' 
#' The OpenDota API requires a 32-bit Steam ID for player queries. This helper function will retrieve a 32-bit ID if provided a 64-bit ID
#'
#' @param long_id The 64-bit Steam ID of the player. Must be numeric.
#'
#' @return
#' @export
#'
#' @examples \dontrun{
#' retrieve_steam32_id(76561198069153050)
#' }
retrieve_steam32_id <- function(long_id) {
  
  if (!is.numeric(long_id)) {
    rlang::abort(paste0("`long_id` must be your Steam 64 bit ID number, not a ", typeof(long_id)))
  }
  
  url <- 'https://steamid.xyz/'
  
  site <- xml2::read_html(url)
  
  form <- rvest::html_elements(site, "form")
  
  form <- rvest::html_form(form[[1]])
  
  vals <- rvest::html_form_set(form, id = long_id)
  
  session <- rvest::html_session(url)
  
  sub <- rvest::session_submit(session, vals)
  
  txt <- rvest::html_text(rvest::html_elements(sub, "#guide"))
  
  lst <- stringr::str_split(txt, "\n")
  
  el <- lst[[1]][[24]]
  
  ret <- as.integer(stringr::str_remove_all(el, "\\D+"))
  
  return(ret)
  
}