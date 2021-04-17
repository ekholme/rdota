#get constant tables from OpenDota

library(tidyverse)
library(httr)
library(jsonlite)

#base url of api
url <-  'https://api.opendota.com/api/constants/'

#constant endpoints i want
cons <- c("heroes", "abilities", "items", "item_ids", "ability_ids")


# Get Heroes --------------------------------------------------------------

heroes <- fetch_constants("heroes") #looks fine

usethis::use_data(heroes, overwrite = TRUE)


# Get Abilities -----------------------------------------------------------

ab_cont <- GET(paste0(url, "abilities")) %>%
  content(as = "parsed", type = "application/json") %>%
  purrr::transpose()

abilities <- tibble(
  name = names(ab_cont$attrib),
  attribs = ab_cont$attrib
) 

usethis::use_data(abilities, overwrite = TRUE)


# Get Items ---------------------------------------------------------------

items <- fetch_constants("items")

usethis::use_data(items, overwrite = TRUE)


# Get Ability Ids ---------------------------------------------------------


ab_id_cont <- GET(paste0(url, "ability_ids")) %>%
  content(as = "parsed", type = "application/json")

ab_ids <- names(ab_id_cont)

ability_ids <- tibble(
  ability_id = ab_ids,
  ability_name = ab_id_cont
)

usethis::use_data(ability_ids, overwrite = TRUE)

# Get Item Ids ------------------------------------------------------------


item_id_cont <- GET(paste0(url, "item_ids")) %>%
  content(as = "parsed", type = "application/json")

item_ids <- tibble(
  item_id = names(item_id_cont),
  item_name = item_id_cont
)

usethis::use_data(item_ids, overwrite = TRUE)
