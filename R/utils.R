
#some functions for working with nested lists
compare_lens <- function(vec, size = 1) {
  all(purrr::map_lgl(vec, ~length(unlist(.x)) == size))
}

#useful for simplifying a list into a vector in cases where it's appropriate
cond_unlist <- function(vec) {
  if (compare_lens(vec) == TRUE) {
    unlist(vec)
  } else {
    vec
  }
}

#wrapper to help get constants
fetch_constants <- function(cons) {
  
  url <-  'https://api.opendota.com/api/constants/'
  
  call <- httr::GET(paste0(url, cons))
  
  cont <- httr::content(call, as = "parsed", type = "application/json")
  
  ret <- cont %>%
    purrr::transpose() %>%
    tibble::as_tibble(.name_repair = "unique") %>%
    dplyr::mutate(dplyr::across(.cols = dplyr::everything(), ~cond_unlist(vec = .x)))
}

#remove NULLs from list and make tibble
compact_to_tibble <- function(x) {
  tibble::as_tibble(purrr::compact(x))
}

#replace nulls in a list
replace_null <- function(x, replacement = NA_character_) {
  
  if (is.null(x)) replacement else x
  
}


#create classes for matches
new_match_class <- function(obj) {
  
  i <- if (length(obj) == 43) {
    "parsed_match"
  } else "unparsed_match"
  
  structure(obj, class = i)
  
}
