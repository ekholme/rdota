rdota
================

`rdota` provides an interface to query the [OpenDota
API](https://docs.opendota.com/) using R and return the data in a tidy
format.

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
