# Clear the workspace and turn off graphics
rm(list = ls()) 
graphics.off()   

# Load required functions (ensure main.R contains all necessary function definitions)
source("ac524_HPC_2024_main.R")  

iter <- as.numeric(Sys.getenv("PBS_ARRAY_INDEX"))


#local test 
#iter<-10
set.seed(iter)

speciation_rate <-0.003604 #value from get my seed


#Everyone will use the same values for community size in their simulations(500,1000,2500,5000)
if (iter %in% 1:25){
  size = 500
  }else if (iter %in% 26:50){
  size = 1000
  }else if (iter %in% 51:75){
  size = 2500
  }else if (iter %in% 76:100){
  size = 5000
}

wall_time = 11.5*60 #11.5 hour to minutes

output_file_name <- paste0("simulation_results_", iter, ".rda")

neutral_cluster_run(
  speciation_rate,
  size,
  wall_time,
  interval_rich = 1,
  interval_oct = size/10,
  burn_in_generations = 8*size,
  output_file_name = output_file_name
  )

cat("Simulation completed for iter:", iter, "\n")

