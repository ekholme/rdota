
#internal function to tidy responses from api queries
tidy_response <- function(resp, class_out) {
  
  tmp <- purrr::modify_depth(resp, 1, replace_null)
  
  ret <- tidyr::pivot_wider(tibble::enframe(tmp),
                            names_from = name,
                            values_from = value)
  
  ret <- purrr::modify(ret, cond_unlist)
  
  class(ret) <- append(class(ret), class_out)
  
  return(ret)
}