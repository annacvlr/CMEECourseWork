rm(list = ls())
graphics.off()
getwd()

source("ac524_HPC_2024_main.R")

iter <- as.numeric(Sys.getenv("PBS_ARRAY_INDEX"))
if (is.na(iter)) {
    iter <- 1
} #if PBS is NA or a space - becomes assigned n1
set.seed(iter) #setting seed

#print(Sys.getenv("PBS_ARRAY_INDEX"))  # Should print a number or empty string
#print(iter)  # Should print the assigned number

#assigning the different 
large_population_adults <- state_initialise_adult(4, 100)
small_population_adults <- state_initialise_adult(4, 10)
large_population_spread <- state_initialise_spread(4, 100)
small_population_spread <- state_initialise_spread(4, 10)

#matrices
growth_matrix <- matrix(c(0.1, 0.0, 0.0, 0.0,
                        0.5, 0.4, 0.0, 0.0,
                        0.0, 0.4, 0.7, 0.0,
                        0.0, 0.0, 0.25, 0.4),
                        nrow=4, ncol=4, byrow=T)
reproduction_matrix <- matrix(c(0.0, 0.0, 0.0, 2.6,
                        0.0, 0.0, 0.0, 0.0,
                        0.0, 0.0, 0.0, 0.0,
                        0.0, 0.0, 0.0, 0.0),
                        nrow=4, ncol=4, byrow=T)
clutch_distribution <- c(0.06,0.08,0.13,0.15,0.16,0.18,0.15,0.06,0.03)

results <- vector("list", 150)  #memory

for (i in 1:150) {
    print(paste("Running iteration:", i, "Job:", iter))
    if(iter <= 25){
        results[[i]] <- stochastic_simulation(large_population_adults, growth_matrix, reproduction_matrix, clutch_distribution, simulation_length = 120)
    } else if(iter > 25 && iter <= 50){
        results[[i]] <- stochastic_simulation(small_population_adults, growth_matrix, reproduction_matrix, clutch_distribution, simulation_length = 120)
    } else if(iter > 50 && iter <= 75){
        results[[i]] <- stochastic_simulation(large_population_spread, growth_matrix, reproduction_matrix, clutch_distribution, simulation_length = 120)
    } else {
        results[[i]] <- stochastic_simulation(small_population_spread, growth_matrix, reproduction_matrix, clutch_distribution, simulation_length = 120)
    }

    
}

#save files
save(results, file =paste0("simulation_quest4_",iter,".rda"))
getwd()
#print(sys.calls())  # See call stack
