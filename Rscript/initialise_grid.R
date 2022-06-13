initialise_grid <- function(data, grid) {
  
  # Labelled dataset.
  labelled <- data %>% 
    left_join(grid, by = c("eoff", "acc")) %>%
    filter(sim_count0 == 1) %>% 
    mutate(sim_count1 = as.numeric((impact_speed0 != 0)), 
           sampling_weight = 1)
  
  # Unlabelled dataset.
  unlabelled <- data %>% 
    left_join(grid, by = c("eoff", "acc")) %>%
    filter(is.na(sim_count0)) %>% 
    dplyr::select( -impact_speed0, -impact_speed1, -injury_risk0, -injury_risk1) %>% 
    mutate(collision_prob0_pred = NA_real_, 
           collision_prob1_pred = NA_real_, 
           impact_speed0_pred = NA_real_,
           impact_speed1_pred = NA_real_,
           injury_risk0_pred = NA_real_,
           injury_risk1_pred = NA_real_,
           crash0 = NA_integer_,
           crash1 = NA_integer_,
           non_crash0 = NA_integer_,
           non_crash1 = NA_integer_,
           max_impact0 = NA_integer_,
           max_impact1 = NA_integer_,
           sim_count0 = 1,
           sim_count1 = 1)  
  
  return(list(labelled = labelled, unlabelled = unlabelled))
}