
#check if an argument is logical
check_logical_arg <- function(arg, arg_name) {
  
  if (!is.logical(arg)) {
    rlang::abort(paste0("`", arg_name, "` must be a logical argument, not ", typeof(arg)))
  }
}

#function to check the length of player id
check_player_id_len <- function(player_id) {
  
  if (nchar(player_id) > 11) {
    rlang::abort(paste0("The `player_id` you've passed in has too many (", nchar(player_id), ") digits. Please be sure to use the Steam32 ID rather than the 64-bit ID"))
  }
  
}

check_tidy_arg <- function(arg) {
  if (!is.logical(arg)) {
    rlang::abort(paste0("`tidy` must be a logical argument, not ", typeof(arg)))
  }
}