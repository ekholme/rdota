rdota
================

`rdota` provides an interface to query the [OpenDota
API](https://docs.opendota.com/) using R and return the data in a tidy
format.

## Functions

`rdota` provides several functions to query the OpenDota API and return
the data, if the user so chooses, in a tidy format. Currently, the
following functions are implemented:

  - `get_player_account()`
  - `get_player_recent_matches()`
  - `get_match()`

Additionally, the `retrieve_steam32_id()` provides an easy way for users
to find their Steam32 ID, which is required for any query involving a
player id.

## Constants

In addition to providing functions to query the OpenDota API, `rdota`
also directly provides some game data that is relatively constant over
time. These built-in datasets provide data on heroes, items, and
abilities. They can be found in the following files:

  - `heroes`,
  - `items`,
  - `abilities`,
  - `ability_ids`, and
  - `item_ids`

## Installation

You can install `rdota` using:

``` r
remotes::install_github("ekholme/rdota")
```
