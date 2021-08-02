
get_response <- function(url) {
  
  #check value of url
  if (is.null(url) || !nzchar(url)) {
    rlang::abort("The query url must not be blank")
  }
  
  #set user agent
  ua <- httr::user_agent("http://github.com/ekholme/rdota")
  
  #get response
  resp <- httr::GET(url)
  
  #checking for status errors
  httr::stop_for_status(resp)
  
  #ensure query returns json
  if (httr::http_type(resp) != "application/json") {
    stop("API did not return json", call. = FALSE)
  }
  
  #parse the content of the response
  content <- httr::content(resp, as = "parsed", type = "application/json")
  
  structure(
    list(
      content = content,
      url = url,
      resp = resp
    ),
    class = "rdota"
  )
  
  
}