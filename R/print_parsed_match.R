
#' print method for parsed_match class
#'
#' @param x parsed_match object
#' @param ... currently unused
#'
#' @return Prints summary information for a parsed_match object
#' @export
#'
print.parsed_match <- function(x, ...) {

  #message
  cat("Match ID: ", x$match_id, "\n", sep = "")
  
  cat("Duration: ", x$duration, " seconds \n", sep = "")
  
  winner <- if (x$radiant_win == TRUE) "Radiant" else "Dire"
  
  cat("Winning Team: ", winner, "\n")
  
  #print content
  cat("Content of 'parsed_match': ", names(x))
  
  #return object
  invisible(x)
}