#get constant tables from OpenDota

library(tidyverse)
library(httr)
library(jsonlite)

url <-  'https://api.opendota.com/api/constants/'

call <- GET(paste0(url, "heroes"))

tst <- content(call, as = "parsed", type = "application/json")

tst2 <- tst %>%
  purrr::transpose() %>%
  as_tibble() %>%
  mutate(across(.cols = everything(), ~cond_unlist(vec = .x)))

#all of the above works -- now to figure out the constants we actually want

#constants I want for now -- heroes, abilities, items, item_ids

cons <- c("heroes", "abilities", "items", "item_ids", "ability_ids")

fetch_constants <- function(cons) {
  
  url <-  'https://api.opendota.com/api/constants/'
  
  call <- GET(paste0(url, cons))
  
  cont <- content(call, as = "parsed", type = "application/json")
  
  ret <- cont %>%
    purrr::transpose() %>%
    as_tibble(.name_repair = "unique") %>%
    mutate(across(.cols = everything(), ~cond_unlist(vec = .x)))
}

cons_out <- map(cons, fetch_constants)

#let's try one at a time here
heroes_out <- fetch_constants("heroes") #looks fine
abilities_out <- fetch_constants("abilities") #needs work -- see below
items_out <- fetch_constants("items") #looks fine
item_ids_out <- fetch_constants("item_ids") #doesn't work
ability_id_out <- fetch_constants("ability_ids")



# Abilities ---------------------------------------------------------------


ab_cont <- GET(paste0(url, "abilities")) %>%
  content(as = "parsed", type = "application/json")

tst3 <- ab_cont %>%
  purrr::transpose()

nms <- names(tst3$attrib)

tst4 <- tibble(
  name = nms,
  attribs = tst3$attrib
) #this might be as good as the abilities are going to get
  


# Ability Ids -------------------------------------------------------------

ab_id_cont <- GET(paste0(url, "ability_ids")) %>%
  content(as = "parsed", type = "application/json")

ab_ids <- names(ab_id_cont)

ab_id_tbl <- tibble(
  ability_id = ab_ids,
  ability_name = ab_id_cont
) #this is reasonable for this point


# Item Ids ----------------------------------------------------------------

item_id_cont <- GET(paste0(url, "item_ids")) %>%
  content(as = "parsed", type = "application/json")

item_id_tbl <- tibble(
  item_id = names(item_id_cont),
  item_name = item_id_cont
)
