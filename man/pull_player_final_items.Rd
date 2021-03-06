% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/pull_player_final_items.R
\name{pull_player_final_items}
\alias{pull_player_final_items}
\title{Pull Player Final Items}
\usage{
pull_player_final_items(obj, include_item_names = TRUE)
}
\arguments{
\item{obj}{A 'parsed_match'  object.}

\item{include_item_names}{logical. If TRUE, the output will include a column containing item names in addition to a column containing item ids. If FALSE, will include only item ids.}
}
\value{
A tibble with 110 rows and 5 or 6 columns, depending on the value of the include_item_names argument.
}
\description{
Pull the final items of all players in the match.
}
\examples{
\dontrun{
a <- get_match('6156757097')
b <- pull_player_final_items(a)
}
}
