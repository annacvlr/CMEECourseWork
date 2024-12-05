# CMEE 2024 HPC exercises R code pro forma
# For stochastic demographic model cluster run

#clear workspace
rm(list=ls()) 
dev.off()
#load functions sourced in Demographic R
source("Demographic.R")


#read job number from the cluster
# since script will run in parallel across multiple nodes - multiple instances on the HPC cluster 
#each instance of the script will be assigned a jpb number (iter) can be accessed thru an env. variable (PBS ARRAY INDEX)
iter <- 1
#iter <- as.numeric(Sys.getenv("PBS_ARRAY_INDEX"))
#initial_state <- state_initialise_adult(4, 100)
#small_popu_adults <- state_initialise_adult(4, 10)
#large_popu_spread <- state_initialise_spread(4, 100)
#small_popu_spread <- state_initialise_spread(4, 10)

#control random numbers to 

set.seed(iter) 

clutch_distribution <- c(0.06,0.08,0.13,0.15,0.16,0.18,0.15,0.06,0.03)

growth_matrix <- matrix(c(0.1, 0.0, 0.0, 0.0,
                          0.5, 0.4, 0.0, 0.0,
                          0.0, 0.4, 0.7, 0.0,
                          0.0, 0.0, 0.25, 0.4),
        nrow=4, ncol=4, byrow=T)

reproduction_matrix <- matrix(c(0.0, 0.0, 0.0, 2.6,
                          0.0, 0.0, 0.0, 0.0,
                          0.0, 0.0, 0.0, 0.0,
                          0.0, 0.0, 0.0, 0.0),
        nrow=4, ncol=4, byrow=T) #byrow T = fill out the row by row

projection_matrix = reproduction_matrix + growth_matrix

state_initialise_adult <- function(num_stages,initial_size){
  state_vector <- rep(0, num_stages) # all set to 0 
  state_vector[num_stages] <- initial_size # the adult stage (so the last element in the vector state_vector) should be equal to the size of the vectpr 
  return(state_vector) #returned as output 
  
}

state_initialise_spread <- function(num_stages,initial_size){
  state_vector <- rep(0, num_stages) # make all vector numbers into 0
  base_allocation <- floor(initial_size/num_stages) # numb in each spot
  state_vector[] <- base_allocation #inside state vector place base allocation

  remainder <- initial_size %% num_stages #calculates leftover individuals after the division
  for (i in 1: remainder) { # for loop runs remainder times - each iteration of loop the inidividual count of stage is increased by 1
    state_vector[i] <- state_vector[i] +1
  } # adds 1 individual to each of the first remainder life stages -- extra individuals start from youngest life stages
  return(state_vector)
}

sum_vect <- function(x, y) {
  lenx <- length(x) 
  leny <- length(y)

#if length of x is shorter than y, add repetition of 0 to the difference
#if length of y is shorter than x, add a repetition of 0 to the difference
#empty values in the vectors will be filled w zeroes
  if(lenx < leny) {
    x <- c(x, rep(0, leny - lenx))
  } else if (leny < lenx) {
    y <- x(y, rep(0, lenx-leny))
  }
  return(x+y)
}
# select initial condition
#4 differ initial conditions for the simulations - each should be assigned to a set of parallel simulations 
# conditions are: (1) 100 adults, (2) 10 adults, (3) 100 individuals spread across life stages, (4) 10 individuals spread across life stages
#assign these conditions based on iter 
condition <- iter %%4
if(condition ==1){
    initial_state <- state_initialise_adult(4, 100)
} else if (condition == 2){
   initial_state <- state_initialise_adult(4, 10)
} else if (condition == 3){
   initial_state <- state_initialise_spread(4, 100)
} else if (condition == 0) {
    initial_state <- state_initialise_spread()(4, 10)
}

results_list <-list()

for (i in 1:150) {
    
    simulation_res <- stochastic_simulation(initial_state, growth_matrix, reproduction_matrix, clutch_distribution, simulation_length = 120)
    results_list[[i]] <- simulation_res
}

filename <- paste("simulation_res", iter, ".rda", sep = "")

save(results_list, file = filename )

# save res in list 
#save list in file

load ("simulation_res.Rdata")


