
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

#internal function to replace hero ids with hero names in get_public_match()
replace_hero_ids <- function(df, var, idx) {
  
  h_vec <- rdota::heroes$localized_name
  names(h_vec) <- heroes$id
  
  tmp <- as.character(df[idx, var])
  tmp <- stringr::str_split_fixed(tmp, ",", 5)
  
  paste(h_vec[tmp], collapse = ", ")
  
}