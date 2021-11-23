rdota
================

`rdota` provides an interface to query the [OpenDota
API](https://docs.opendota.com/) using R and return the data in a tidy
format.

## Installation

You can install `rdota` using:

``` r
remotes::install_github("ekholme/rdota")
```

## Get Functions

`rdota` provides several functions to query the OpenDota API and return
the data in a tidy format. Currently, the following functions are
implemented:

-   `get_match()`
-   `get_parsed_matches()`
-   `get_player_account()`
-   `get_player_recent_matches()`
-   `get_pro_matches()`
-   `get_public_matches()`

## Pull Functions

Although the `get_*()` family of functions do their best to return data
as tidy as possible, some objects – primarily `get_match()` – will still
return deeply nested data. The `pull_*()` family of functions are meant
to help extract specific data elements from these objects. Currently,
these functions include:

-   `pull_player_final_items()`
-   `pull_player_heroes()`
-   `pull_player_kda()`
-   `pull_player_purchase_log()`

## Misc Functions

The `retrieve_steam32_id()` provides an easy way for users to find their
Steam32 ID, which is required for any query involving a player id.

## Constants

In addition to providing functions to query the OpenDota API, `rdota`
also directly provides some game data that is relatively constant over
time. These built-in datasets provide data on heroes, items, and
abilities. They can be found in the following files:

-   `heroes`,
-   `items`,
-   `abilities`,
-   `ability_ids`, and
-   `item_ids`
