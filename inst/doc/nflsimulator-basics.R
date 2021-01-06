## ---- include = FALSE---------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## ----setup, message = F, warning = F------------------------------------------
library(NFLSimulatoR)
library(knitr)
set.seed(584)

## -----------------------------------------------------------------------------
pbp_data <- NFLSimulatoR::download_nflscrapR_data(year = 2019)
pbp_data <- NFLSimulatoR::prep_pbp_data(pbp_data)

## ---- eval = FALSE------------------------------------------------------------
#  pbp_data <- NFLSimulatoR::download_nflfastR_data(year = 2019)
#  pbp_data <- NFLSimulatoR::prep_pbp_data(pbp_data)

## -----------------------------------------------------------------------------
play <- NFLSimulatoR::sample_play(
  what_down = 3,
  yards_to_go = 2,
  yards_from_own_goal = 45,
  play_by_play_data = pbp_data,
  strategy = "normal"
)
knitr::kable(play[, c("desc",
                      "down",
                      "ydstogo",
                      "yardline_100",
                      "play_type",
                      "yards_gained")])

## -----------------------------------------------------------------------------
play <- NFLSimulatoR::sample_play(
  what_down = 3,
  yards_to_go = 2,
  yards_from_own_goal = 45,
  play_by_play_data = pbp_data,
  strategy = "passes_rushes",
  prop_passes = 0.5
)
knitr::kable(play[, c("desc",
                      "down",
                      "ydstogo",
                      "yardline_100",
                      "play_type",
                      "yards_gained")])

## -----------------------------------------------------------------------------
play <- sample_play(
  what_down = 4,
  yards_to_go = 2,
  yards_from_own_goal = 45,
  play_by_play_data = pbp_data,
  strategy = "fourth_downs",
  fourth_down_strategy = "yds_less_than",
  yards_less_than = 5
)
knitr::kable(play[, c("desc",
                      "down",
                      "ydstogo",
                      "yardline_100",
                      "play_type",
                      "yards_gained")])

## -----------------------------------------------------------------------------
drives <- NFLSimulatoR::sample_drives(
  n_sims = 10,
  from_yard_line = 25,
  play_by_play_data = pbp_data,
  strategy = "fourth_downs",
  fourth_down_strategy = "empirical",
  single_drive = T,
  progress = F #shows progress bar for simulations
)
drives$points

