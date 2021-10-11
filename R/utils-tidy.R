##utility functions to tidy objects

#tidy the result of get_match()
tidy_match <- function(match_obj) {
  
  tmp <- purrr::modify_depth(match_obj, 1, replace_null)
  
  ret <- tidyr::pivot_wider(tibble::enframe(tmp),
                            names_from = name,
                            values_from = value)
  
  ret <- purrr::modify(ret, cond_unlist)
  
  class(ret) <- append(class(ret), "rdota_match")
  
  return(ret)
  
}