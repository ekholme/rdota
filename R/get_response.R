#' Core Get Response
#' 
#' This function powers the API requests in rdota. It's for internal purposes and shouldn't be called directly by the user.
#'
#' @param resource name of the resource to pass to the OpenDota API
#' @param ... query arguments
#'
#' @importFrom magrittr %>%
#'
#' @return
#' @export
#'
get_response <- function(resource, ...) {
  
  params <- list(...)
  
  httr2::request("https://api.opendota.com/api/") %>%
    httr2::req_url_path_append(resource) %>%
    httr2::req_url_query(!!!params) %>%
    httr2::req_user_agent("http://github.com/ekholme/rdota") %>%
    httr2::req_perform() %>%
    httr2::resp_body_json()

}
