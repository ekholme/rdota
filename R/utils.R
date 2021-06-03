
#some functions for working with nested lists
compare_lens <- function(vec, size = 1) {
  all(purrr::map_lgl(vec, ~length(unlist(.x)) == size))
}


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

#function to check the length of player id
check_player_id_len <- function(player_id) {
  
  if (nchar(player_id) > 11) {
    rlang::abort(paste0("The `player_id` you've passed in has too many (", nchar(player_id), ") digits. Please be sure to use the Steam32 ID rather than the 64-bit ID"))
  }
  
}

#remove NULLs from list and make tibble
compact_to_tibble <- function(x) {
  tibble::as_tibble(purrr::compact(x))
}
