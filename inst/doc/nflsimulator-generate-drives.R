## ---- include = FALSE---------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## ----setup, eval = F, message = F, warning = F--------------------------------
#  library(NFLSimulatoR)
#  library(knitr)
#  library(foreach)
#  library(doParallel)
#  library(dplyr)

## ---- eval=FALSE--------------------------------------------------------------
#  df <- dplyr::bind_cols(
#    nflfastR::load_pbp(2018),
#    nflfastR::load_pbp(2019))
#  
#  pbp_data <- df %>%
#    prep_pbp_data(.) %>%
#    filter(abs(score_differential) < 28, half_seconds_remaining/60 > 2)
#  
#  pbp_data_18 <- pbp_data %>%
#    filter(.,substr(game_date,0,4) == 2018)
#  
#  pbp_data_19 <- pbp_data %>%
#    filter(.,substr(game_date,0,4) == 2019)

## ---- eval = FALSE------------------------------------------------------------
#  # Pass Proportion 2019
#  drives <- NULL
#  results_pass_19 <- NULL
#  df_drives <- NULL
#  registerDoParallel(cores = 4)
#  prop <- seq(0,1, by = .1)
#  results_pass_19 <- foreach (i= 1:11, .combine = rbind, .packages = c("NFLSimulatoR", "progress","dplyr", "tidyverse"))  %dopar% {
#    set.seed(i)
#    drives <- sample_drives(n_sims = 10,
#                            from_yard_line = 25,
#                            play_by_play_data = pbp_data_19,
#                            strategy = "passes_rushes",
#                            single_drive = T,
#                            progress = F,
#                            prop_passes = prop[i])
#    df_drives <- drives %>%
#    #add additional identifiers below as needed i.e. year, etc
#    mutate(proportion = prop[i],year = 19)
#  }

## ---- eval = FALSE------------------------------------------------------------
#  # 4th down strategies
#    drives <- NULL
#    results_fourths_1 <- NULL
#    df_drives <- NULL
#    registerDoParallel(cores = 4)
#    strats <- c("always_go_for_it","empirical","exp_pts","never_go_for_it", "yds_less_than")
#    results_fourths_1 <- foreach (i = 3:4, .combine = rbind, .packages = c("NFLSimulatoR", "progress","dplyr", "tidyverse"))  %dopar% {
#      set.seed(i)
#      drives <- sample_drives(n_sims = 10000,
#                              from_yard_line = 25,
#                              play_by_play_data = pbp_data,
#                              strategy = "fourth_downs",
#                              fourth_down_strategy = strats[i],
#                              single_drive = T,
#                              progress = F
#                              )
#      df_drives <- drives %>%
#      #add additional identifiers below as needed i.e. year, etc
#      mutate(Scenario = strats[i])
#    }

## ---- eval = FALSE------------------------------------------------------------
#  # RTG Data
#  # Team RTG read in (2017-2019)
#  RTG <- read.csv("path/to/file/given/above/Team_Passing_Offense.csv")
#  
#  #Store Tercile Cutoffs (2017-2019)
#  
#  cutoffs <- quantile(RTG$Rate,probs = c(0:3/3))
#  
#  # Passer Rate Terciles
#  
#  RTG_list <- list()
#  years <- c("2018","2019")
#  terciles <- c("Low","Mid","High")
#  for (j in 1:2){
#    list_year <- list()
#    for (i in 1:3){
#      teams <- RTG %>%
#        filter(.,Year == years[j],
#               Rate >= cutoffs[i] & Rate < cutoffs[(i+1)] ) %>%
#        select(.,Team)
#      list_year[[paste(terciles[i],years[j],sep = "_")]] <- pbp_data %>%
#        filter(.,substr(game_date,0,4) == years[j],
#               posteam %in% as.matrix(teams))
#    }
#    RTG_list <- append(RTG_list,list_year)
#  }
#  

## ---- eval = FALSE------------------------------------------------------------
#  # Passer Rating - RTG
#  drives <- NULL
#  df_drives <- NULL
#  RTG_thirds_sims <- NULL
#  registerDoParallel(cores = 4)
#  prop <- seq(0,1, by = .1)
#  RTG_thirds_sims <- foreach (j = 1:6, .combine = rbind ) %:%
#    foreach (i= 1:11, .combine = rbind, .packages = c("NFLSimulatoR", "progress","dplyr", "tidyverse"))  %dopar% {
#      set.seed(i)
#      drives <- sample_drives(n_sims = 10,
#                            from_yard_line = 25,
#                            play_by_play_data = RTG_list[[j]],
#                            strategy = "passes_rushes",
#                            single_drive = T,
#                            progress = F,
#                            prop_passes = prop[i])
#      df_drives <- drives %>%
#      #add additional identifiers below as needed i.e. year, etc
#      mutate(proportion = prop[i],
#             RTG = names(RTG_list[j]),
#             year = substr(RTG, nchar(RTG)-1, nchar(RTG)))
#  }
#  

