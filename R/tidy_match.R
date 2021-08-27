
#' Tidy an rdota_match object
#' 
#' Take an rdota_match object -- the result of get_match() -- and turn it into a tibble. Some columns will still contain (deeply) nested lists. Please see pull_*() helper functions to extract data from these columns
#'
#' @param match_obj An rdota_match object.
#'
#' @return
#' @export
#'
#' @examples \dontrun{
#' a <- get_match('6019587919')
#' tidy_rdota_match(a)
#' }
tidy_rdota_match <- function(match_obj) {
  
  #check class of match_obj
  if (!"rdota_match" %in% class(match_obj)) {
    rlang::abort(paste0("`tidy_match` expects an object of class 'rdota_match', not ", class(match_obj)))
  }
  
  content <- match_obj$content
  
  tmp <- purrr::modify_depth(content, 1, replace_null)
  
  ret <- tidyr::pivot_wider(tibble::enframe(tmp),
                            names_from = name,
                            values_from = value)
  
  ret <- purrr::modify(ret, cond_unlist)
  
  class(ret) <- append(class(ret), "match_tbl")
  
  return(ret)
  
}