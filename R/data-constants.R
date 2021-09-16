
#' Heroes
#' 
#' @description Information on playable heroes in Dota 2.
#' 
#' @format A tibble with 29 variables:
#' \describe{
#' \item{id}{Hero id number}
#' \item{name}{'Proper' hero name}
#' \item{localized_name}{'Common' hero name}
#' \item{primary_attr}{Primary attribute}
#' \item{attack_type}{Attack type (melee or ranged)}
#' \item{roles}{Recommended/common roles for hero}
#' \item{img}{Hero image url. Prefix with media.steampowered.com}
#' \item{icon}{Hero icon url. Prefix with media.steampowered.com}
#' \item{base_health}{Hero base health}
#' \item{base_health_regen}{Hero base health regeneration}
#' \item{base_mana}{Hero base mana}
#' \item{base_mana_regen}{Hero base mana regeneration}
#' \item{base_armor}{Hero base armor}
#' \item{base_mr}{Hero base magic resistance}
#' \item{base_attack_min}{Hero base attack damage minimum}
#' \item{base_attack_max}{Hero base attack damage maximimum}
#' \item{base_str}{Hero base strength}
#' \item{base_agi}{Hero base agility}
#' \item{base_int}{Hero base intelligence}
#' \item{str_gain}{Strength gained per level}
#' \item{agi_gain}{Agility gained per level}
#' \item{int_gain}{Intelligence gained per level}
#' \item{attack_range}{Hero attack range}
#' \item{projectile_speed}{Travel speed of the hero attack projectile}
#' \item{attack_rate}{Base time between hero attacks}
#' \item{move_speed}{Base hero movement speed}
#' \item{turn_rate}{Base speed at which hero turns in place}
#' \item{cm_enabled}{Logical. Is the hero enabled in captain's mode?}
#' \item{legs}{Number of legs the hero has}
#' }
#' 
#' @source \url{https://docs.opendota.com/#tag/constants}
"heroes"


#' Abilities
#' 
#' Hero abilities in Dota 2
#' 
#' @format A tibble with 2 variables:
#' \describe{
#'   \item{name}{Ability name}
#'   \item{attribs}{Ability attributes, formatted as a nested list}
#' }
#' 
#' @source \url{https://docs.opendota.com/#tag/constants}
"abilities"

#' Items
#' 
#' Available items in Dota 2
#' 
#' @format A tibble with 14 variables:
#' \describe{
#'   \item{hint}{Text hint(s) displayed on item tooltip}
#'   \item{id}{Item id number}
#'   \item{img}{Item image url. Prefix with media.steampowered.com}
#'   \item{dname}{Item name}
#'   \item{qual}{Item quality}
#'   \item{cost}{Item cost, in gold}
#'   \item{notes}{Additional item notes}
#'   \item{attrib}{Item attributes, as a nested list}
#'   \item{mc}{Mana cost to use item}
#'   \item{cd}{Item cooldown, in seconds}
#'   \item{lore}{Item lore}
#'   \item{components}{Components used to create item, if applicable}
#'   \item{created}{Logical. Is the item created from other items?}
#'   \item{charges}{Number of item charges available up on purchase/creation, if applicable}
#' }
#' 
#' @source \url{https://docs.opendota.com/#tag/constants}
"items"

#' Ability Ids
#' 
#' Mapping of ability names to ids
#' 
#' @format A tibble with 2 variables:
#' \describe{
#'   \item{ability_id}{Ability id number}
#'   \item{ability_name}{Ability name}
#' }
#' 
#' @source \url{https://docs.opendota.com/#tag/constants}
"ability_ids"

#' Item Ids
#' 
#' Mapping of item names to ids
#' 
#' @format A tibble with 2 variables:
#' \describe{
#'   \item{item_id}{Item id number}
#'   \item{item_name}{Item name}
#' }
#' 
#' @source \url{https://docs.opendota.com/#tag/constants}
"item_ids"