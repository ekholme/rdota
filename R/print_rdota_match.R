
#' print method for rdota_match class
#'
#' @param x rdota_match object
#' @param ... currently unused
#'
#' @return Prints the content element of an rdota_match object
#' @export
#'
print.rdota_match <- function(x, ...) {

  #message
  cat("<rdota_match ", x$url, ">\n\n", sep = "")
  
  #print content
  str(x$content)
  
  #return object
  invisible(x)
}