question_6 <- function(){
  sim_results <- list()
  # Load results from the second half of the simulations
  for (i in 51:100) {
    file_name <- paste0("simulation_quest4_", i, ".rda")
    load(file_name)
    sim_results <- append(sim_results, results)
  }

  # Aggregate and average results from stochastic simulations
  large_IC_avg <- rep(0, 121)
  small_IC_avg <- rep(0, 121)

  for (i in 1:3750){
    large_IC_avg <- large_IC_avg + sim_results[[i]]
  }
  large_IC_avg <- large_IC_avg / 3750

  for (i in 3751:7500){
    small_IC_avg <- small_IC_avg + sim_results[[i]]
  }
  small_IC_avg <- small_IC_avg / 3750

  # Define growth and reproduction matrices
  growth_matrix <- matrix(c(0.1, 0, 0, 0,
                            0.5, 0.4, 0, 0,
                            0, 0.4, 0.7, 0,
                            0, 0, 0.25, 0.4), 4, 4, byrow = TRUE)

  reproduction_matrix <- matrix(c(0, 0, 0, 2.6,
                                  0, 0, 0, 0,
                                  0, 0, 0, 0,
                                  0, 0, 0, 0), 4, 4, byrow = TRUE)

  projection_matrix = growth_matrix + reproduction_matrix

  simulation_length = 120

  # Run deterministic simulations for different initial conditions
  initial_state_large = state_initialise_spread(4, 100)
  deterministic_large <- deterministic_simulation(initial_state_large, projection_matrix, simulation_length)

  initial_state_small = state_initialise_spread(4, 10)
  deterministic_small <- deterministic_simulation(initial_state_small, projection_matrix, simulation_length)

  # Calculate deviations and plot results
  deviation_large <- large_IC_avg / deterministic_large
  deviation_small <- small_IC_avg / deterministic_small

  png(filename="question_6.png", width = 600, height = 400)
  plot(1:121, deviation_small, type = "l", col = "red", lwd = 2, 
       xlab = "Time", ylab = "Deviation Ratio", main = "Deviation Between Stochastic and Deterministic Simulations")
  lines(1:121, deviation_large, col = "blue", lwd = 2)
  legend("bottomright", legend = c("Large Initial Condition", "Small Initial Condition"), col = c("blue", "red"), lwd = 2, bty = "n")
  dev.off()

  return("Large initial populations approximate the deterministic model more closely, showing smaller deviations.")
}

question_6()