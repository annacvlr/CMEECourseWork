# CMEE 2024 HPC exercises R code main pro forma
# You don't HAVE to use this but it will be very helpful.
# If you opt to write everything yourself from scratch please ensure you use
# EXACTLY the same function and parameter names and beware that you may lose
# marks if it doesn't work properly because of not using the pro-forma.
#install.packages("ggplot2")

name <- "Anna Cavalieri Canosa"
preferred_name <- "Anna"
email <- "ac524@imperial.ac.uk"
username <- "ac524"

source("Demographic.R")
library(ggplot2)

getwd()
# Please remember *not* to clear the work space here, or anywhere in this file.
# If you do, it'll wipe out your username information that you entered just
# above, and when you use this file as a 'toolbox' as intended it'll also wipe
# away everything you're doing outside of the toolbox.  For example, it would
# wipe away any automarking code that may be running and that would be annoying!

# Section One: Stochastic demographic population model

### Question 0

#popu state vector - all individuals placed in the last life stage (are adults)
#num_stages = number of life stages - determines legtrh of state vector
#initial_size = tot popu size that will be placed in the adult life stage

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

#### Question 1
#carries out deterministic sim. w 2 differ initial conditions & saves graph comparing popu size time series 
#source from demographic.R 
# run model for species w 4 life stages and sim length of 24, projection matrix end of Q
#popu of 100 individuals across the 4 life stages 
#creat and save the plot question_1.png - should show the popu size time series for both sim using differ coloured lines
# function should output as text the answer to Q ""Explain how the initial distribution of the population in different life stages affects the initial and eventual population growth."

question_1 <- function(){

initial_state_adult <- state_initialise_adult(num_stages = 4, initial_size = 100)
initial_state_spread <- state_initialise_spread(num_stages = 4, initial_size = 100) # nolint # nolint: line_length_linter.

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


population_adult <- deterministic_simulation(initial_state = initial_state_adult, 
      projection_matrix = projection_matrix, simulation_length = 24)
        
population_spread <- deterministic_simulation(initial_state = initial_state_spread, 
      projection_matrix = projection_matrix, simulation_length=24)



png("question_1.png", width = 600, height = 400)
  # plot your graph here
plot(population_adult, type = "l", col = "blue", lwd =2,
    xlab = "Time", ylab = "Population size",
    main = "Population Growth Over Time (Different Initial Conditions)")

lines(population_spread, col = "red", lwd=2)
legend("topright", legend=c("All adults initially", "Evenly spread population"), 
  col = c("blue", "red"), lwd = 2)


  Sys.sleep(0.1)
  dev.off()
  return("")
}
  
#question_1()


### Question 2

#write function which applies stochastic_simulation w smae 2 sets of initial conditions and other parameters as given to model in Q1
#growth matrix and reprod. matrix defined as above
# clutch distrib. is provided 
#create and save a png - which plots popu size time series for both simulations using differ coloured lines
#function should output plain text answer to “How does the smoothness of the earlier
#deterministic simulations compare with these stochastic simulations? Explain why this is the case.”


sum_vect <- function(x, y) {
  lenx <- length(x) 
  leny <- length(y)

  # Ensure both vectors are of equal length by padding with zeroes
  if(lenx < leny) {
    x <- c(x, rep(0, leny - lenx))
  } else if (leny < lenx) {
    y <- c(y, rep(0, lenx - leny))
  }
  return(x + y)
}

question_2 <- function(){
  clutch_distribution <- c(0.06,0.08,0.13,0.15,0.16,0.18,0.15,0.06,0.03)
  initial_state_adult <- state_initialise_adult(num_stages = 4, initial_size = 100)
  initial_state_spread <- state_initialise_spread(num_stages = 4, initial_size = 100) # nolint # nolint: line_length_linter.

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

  stochastic_population_adult <- stochastic_simulation(initial_state_adult, growth_matrix, reproduction_matrix, clutch_distribution,simulation_length = 24)
  stochastic_population_spread <- stochastic_simulation(initial_state_spread, growth_matrix, reproduction_matrix, clutch_distribution, simulation_length = 24)

  png(filename="question_2.png", width = 600, height = 400)
  plot(stochastic_population_adult, type = "l", col = "blue", lwd =2,
    xlab = "Time", ylab = "Population size",
    main = "Population Growth Over Time - Stochastic population (Different Initial Conditions)")
lines(stochastic_population_spread, col = "red", lwd=2)
legend("topright", legend=c("All adults initially", "Evenly spread population"), 
  col = c("blue", "red"), lwd = 2)

  Sys.sleep(0.1)
  dev.off()
  
  return("type your written answer here")
}

#question_2()



# Questions 3 and 4 involve writing code elsewhere to run your simulations on the cluster

## Question 5
question_5 <- function () {
  #read rda files  
  rda_files <- list.files(pattern = "^simulation_quest4", full.names = TRUE)

  final_populations_list <- list()

  # Extract iter for all files
  iter_values <- sapply(rda_files, function(file) as.numeric(gsub("^.*_(\\d+)\\.rda$", "\\1", basename(file))))
  #names(iter_values)
  #print(iter_values)  # Check extracted numbers


  for (file in rda_files) {
    load(file)

    #extract final popu size -- last number in the simulation
    final_pop_sizes <- sapply(results, function(sim) tail(sim,1))
    #head(final_pop_sizes)#debugging V

    #extract numeric part of filename 
    iter <- iter_values[file]
    
    #assign initial condition based on iter
    if (iter <= 25) {
      initial_condition <- "Large Population, Adults"
    } else if (iter > 25 && iter <= 50) {
      initial_condition <- "Small Population, Adults"
    } else if (iter > 50 && iter <= 75) {
      initial_condition <- "Large Population, Spread"
    } else {
      initial_condition <- "Small Population, Spread"
    }
    #print(file)
    #print(initial_condition) #debug V

    #store data 
    temp_data <- data.frame(
      InitialCondition = rep(initial_condition, length(final_pop_sizes)), 
      FinalPopulation = final_pop_sizes 
    )
    final_populations_list[[length(final_populations_list)+1]] <- temp_data
  }
    #tail(final_populations_list) #debugg - yes we see popu w 0 and larger ones, 
    #head(final_populations_list) #debugg - yes we see other initial conditions

  #combo list into df
  final_populations <- do.call(rbind, final_populations_list)
  #head(final_populations) #debug
  #print(final_populations) #debug

  #look at extinctions
  final_populations$Extinct <-as.numeric(final_populations$FinalPopulation ==0)
  extinction_counts <- aggregate(Extinct ~ InitialCondition, data = final_populations, sum) #sum of each initial cond w extinctions
  head(extinction_counts) ##see large popu adults 0, large popu spread 0, small popu adults 185, small popu spread 590
  total_counts <- aggregate(FinalPopulation ~ InitialCondition, data = final_populations, length) # counts how many simulations for each initial condition

  #merge # of extinctions and length of each initial condition
  results_df <- merge(extinction_counts, total_counts, by = "InitialCondition")
  head(results_df)
  colnames(results_df) <- c("InitialCondition", "Extinctions", "Simulations")
  results_df$ExtinctionProportion <- results_df$Extinctions / results_df$Simulations


  # Save the bar graph
  png(filename = "question_5.png", width = 600, height = 400)
  print(
    ggplot(results_df, aes(x = InitialCondition, y = ExtinctionProportion, fill = InitialCondition)) +
      geom_bar(stat = "identity") +
      labs(title = "Proportion of Extinctions per Initial Condition",
           x = "Initial Condition",
           y = "Proportion of Populations That Went Extinct") +
      theme_minimal() +
      theme(axis.text.x = element_text(angle = 45, hjust = 1))
  )
  dev.off()
  
  # Identify the most extinction-prone initial condition population
  most_vulnerable <- results_df$InitialCondition[which.max(results_df$ExtinctionProportion)]
  print(most_vulnerable)
  # Explanation

  explanation <- paste0("The population with initial condition '", most_vulnerable,
                       "was most likely to go extinct.The high extinct proportion signifies that out of all simulations",
                       "in that condition a larger fraction went extinct.",
                       "This may be due to initial population size: smaller populations being more vulnerable to smaller population fluctuations.",
                       "They are therefore more at risk of extinction.",
                       "Additionally this population is spread out, which could make finding mates and resources more difficult, lowering",
                       "reproductive rate.")
    
  print(explanation)
  return(explanation)
}
#question_5()

#Question 6 
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

  return("Large initial populations approximate the deterministic model more c")
}

question_6()


# Section Two: Individual-based ecological neutral theory simulation 

# Question 7
#calculates species richness : number of unique species present in a given community
species_richness <- function(community){
  return(length(unique(community))) #extracts unique species from vector & counts them
}
#species_richness(c(1,4,4,5,1,6,1)) #gives 4 - debug is correct

# Question 8
# initialises a community where each individual is a unique species 
init_community_max <- function(size) {
  return(seq(1, size))
}

#init_community_max(5) #returns c(1, 2, 3, 4, 5)


# Question 9
# initialises monodmoniant community - all indiv. belong to the same species
init_community_min <- function(size) {
  return(rep(1, size))
}

#init_community_min(5)

#x <- 10
#print(species_richness(init_community_min(x))) # Should return 1
#print(species_richness(init_community_max(x))) # Should return x (10 in this case)


# Question 10
#randomly selects two distinct numbers 
choose_two <- function(max_value){
  return(sample(1:max_value, 2, replace = FALSE)) #replace = False makes 2 numbers different
}
#choose_two(4)

# Question 11
#simulates one step of a neutral model - 
#   2 indiv selected.
#   1 indiv dies and 1 reproduces 
neutral_step <- function(community){
  indices <- choose_two(length(community))
  death_index <- indices[1]
  reproduce_index <- indices[2]
  community[death_index] <- community[reproduce_index]
  return(community)
}
#set.seed(42)
#neutral_step(c(1,2))


# Question 12
#simulates a full generation in a neutral model
neutral_generation <- function(community){
  size <- length(community)
  step_number <- sample(c(floor(size/2), ceiling(size/2)), 1) 
  
  for (i in 1:step_number) {
    community<- neutral_step(community )
  }
  return(community)
}

#set.seed(42)  # For reproducibility
#neutral_generation(c(1, 2, 3, 4)) # size is 4 -> loops x2 

# Question 13
#simulates neutral theory model & tracks species richness over time 
neutral_time_series <- function(community,duration)  {
    time_series_richness <- numeric(duration + 1) #make empty vector for sp. richness at each step
    time_series_richness[1] <- species_richness(community) # record inital sp. rich. before sim.

  
  for (gen in 1:duration) {
    community <- neutral_generation(community) #update community
    time_series_richness[gen + 1] <- species_richness(community) #store sp. rich. to updated comm.
  }
  return(time_series_richness)
}

#set.seed(42)  # For reproducibility
#neutral_time_series(community = init_community_max(7), duration = 20)
#shows gradual decline - seems possible

# Question 14
#simulates neutral model - plots time series sp. richness over 200 gen. & saves plot
question_14 <- function() {
    size <- 100
    generations <- 200
    initial_community <- init_community_max(size)
    richness_time_series <- neutral_time_series(community = initial_community, duration = generations)

  graphics.off()
  png(filename="question_14.png", width = 600, height = 400)
  plot(0:generations, richness_time_series, type = "l", col = "blue", lwd = 2, 
      xlab= "Generations",
      ylab = "Species Richness", 
      main = "Neutral Model Simulation: Species Richness Over Time" )
  Sys.sleep(0.1)
  dev.off()
  
  return("Over time the system will converce to monodominance (species richness = 1). In the absence of speciation, stochastic drift leads to loss of all but one species.")
}
#question_14()

# Question 15
#simulates a single step of a neutral model w speciation
neutral_step_speciation <- function(community,speciation_rate)  {
  if (speciation_rate < 0 || speciation_rate > 1) {
    stop ("Speciation rate must be between 0 and 1")
  }
  
  indices <- choose_two(length(community))
  death_index <- indices[1]

  if (runif(1) < speciation_rate) {
    new_species <- max(community) + 1 
    community[death_index] <- new_species
  } else {
    reproduce_index <- indices[2]
    community[death_index] <- community[reproduce_index]
  }
  return(community)
}
#set.seed(42)  # For reproducibility
#neutral_step_speciation(c(1,1,2), speciation_rate = 0.2)



# Question 16
neutral_generation_speciation <- function(community,speciation_rate)  {
  size <- length(community)
  step_number <- ifelse(size %% 2==0, size /2, sample(c(floor(size/2), ceiling(size / 2)), 1))

  for ( i in seq_len(step_number)) {
    community <- neutral_step_speciation(community, speciation_rate)
  }
  return(community)

}
#neutral_generation_speciation(c(1, 1, 2, 3, 4, 5), speciation_rate = 0.1)




# Question 17
#sim a neutral model w speciation over many generations
neutral_time_series_speciation <- function(community, speciation_rate, duration) {
  # make vector for species richness over time
  richness_history <- numeric(duration + 1)
  richness_history[1] <- species_richness(community)  #initial species richness
  
  
  for (gen in 1:duration) {
    community <- neutral_generation_speciation(community, speciation_rate)  # Advance one generation
    richness_history[gen + 1] <- species_richness(community)  # Store species richness
  }
  
  return(richness_history)
}

#neutral_time_series_speciation(community = init_community_max(7), speciation_rate = 0.1, duration = 20)

# Question 18
#simulates neutral theort model w speciation, plots and saves plot
#compares 2 initial conditions
#     A) maximal diversity 
#     B) monodominance
question_18 <- function()  {
  size <- 100
  generations <- 200
  speciation_rate <- 0.1

  community_max <- init_community_max(size)
  community_min <- init_community_min(size)

  richness_max <- neutral_time_series_speciation(community_max, speciation_rate, generations)
  richness_min <- neutral_time_series_speciation(community_min, speciation_rate, generations)
  
  png(filename="question_18.png", width = 600, height = 400)
  plot(0:generations, richness_max, type = "l", col = "blue", lwd = 2, 
      xlab= "Generations", ylab ="Species Richness", 
      main = "Neutral Model Simulation with Speciation")
  lines(0:generations, richness_min, col = "red", lwd = 2)  # Add second line
  
  legend("topright", legend = c("Maximal Diversity", "Monodominance"), 
         col = c("blue", "red"), lwd = 2, cex = 0.8)
  
  Sys.sleep(0.1)
  dev.off()
  
  return("The graph illustrates that, regardless of the starting conditions, species richness eventually stabilizes at a similar level. If the system begins with maximum diversity, species richness declines due to random fluctuations but is maintained by speciation. Conversely, when starting with only one species, richness increases as new species emerge. This occurs because, in a neutral model, the interplay between stochastic drift and speciation determines species richness, leading to a final equilibrium that does not depend on the initial state.")
}
#question_18()



# Question 19
#calculates abundance of each species in a comm. and returns cunts in decreasing order
species_abundance <- function(community)  {7
  return(sort(as.vector(table(community)), decreasing = T))
  
}

# Question 20
#bins species abundances into octave classes
octaves <- function(abundance_vector) {
  if(length(abundance_vector) == 0) {
    return(integer(0))
  }
  octave_indices <- floor(log2(abundance_vector)) +1 #log binning 
  return(tabulate(octave_indices))
  
}
#octaves(c(1,1,2,3,5,8,8,16,32,50))



## Question 21
# sum 2 vectors after making sure the smaller vector has enough  to match length of longer vector
sum_vect <- function(x, y) {
  len_x <- length(x) 
  len_y <- length(y)

  max_len <- max(len_x, len_y)

  if(len_x < max_len) {
    x <- c(x, rep(0, max_len - len_x))
  } 
  if (len_y < max_len) {
    y <- c(y, rep(0, max_len - len_y))
  }
  return(x+y)
}
#sum_vect(c(1,3), c(1,0,5,2))



# Question 22
#runs 2 neutral model simulations w speciation, records species abundance distributions at intervals
#plots mean species abundance distribution for both initial conds.
question_22 <- function() {
  size <- 100
  duration_burnin <- 200
  duration_main <- 2000
  interval <- 20
  speciation_rate <- 0.1

  community_max <- init_community_max(size)
  community_min <- init_community_min(size)

  community_max <- neutral_generation_speciation(community_max, speciation_rate)
  community_min <- neutral_generation_speciation(community_min, speciation_rate)

  octaves_max <- list()
  octaves_min <- list()

  for ( gen in 1:duration_main) {
    community_max <- neutral_generation_speciation(community_max, speciation_rate)
    community_min <- neutral_generation_speciation(community_min, speciation_rate)
  
    if (gen %% interval == 0 ) {
      octaves_max <- append(octaves_max, list(octaves(species_abundance((community_max)))))
      octaves_min <- append(octaves_min, list(octaves(species_abundance((community_min)))))

    }
  } 

  mean_octaves_max <- Reduce(sum_vect, octaves_max) / length (octaves_max)
  mean_octaves_min <- Reduce(sum_vect, octaves_min) / length (octaves_min)


  png(filename="question_22.png", width = 600, height = 400)
  par(mfrow = c(1,2))
  barplot(mean_octaves_max, col = "blue", main = "Mean Species Abundance (Max Diversity)",
      xlab = "Octave Bins", 
      ylab = "Mean Count of Species")
  barplot(mean_octaves_min, col = "red", main = "Mean Species Abundance (Monodominance)", 
      xlab = "Octave Bins",
      ylab = "Mean Count of Species")

  Sys.sleep(0.1)
  dev.off()
  
  return("The initial condition of the system does not affect the final equilibrium distribution of species abundance. 
 After enough generations, both starting conditions result in a similar species abundance distribution, 
 because the balance between stochastic drift and speciation determines the long-term state of the system."
)
}

#question_22()


# Question 23
#HPC simulation of neutral model w speciation
#neutral_cluster_run <- function(speciation_rate, size, wall_time, interval_rich, interval_oct, burn_in_generations, output_file_name) {
    
#}

neutral_cluster_run <- function(speciation_rate, size, wall_time, interval_rich, interval_oct, burn_in_generations, output_file_name) {
  # Initialize the community with minimal diversity
  
  community <- init_community_min(size)
  
  # Set up data storage
  time_series <- c() #store sp. richness during burn-in
  abundance_list <- list() #store octaves thruout sim.
  
  # Start the timer
  start_time <- proc.time()[3]  # Get elapsed time in seconds
  elapsed_time <- 0
  
  # Main simulation loop
  gen <- 0
  while (elapsed_time < (wall_time * 60)) {  # Convert wall_time to seconds
    gen <- gen + 1
    community <- neutral_generation_speciation(community, speciation_rate)
    
    # Record species richness only during burn-in period
    if (gen <= burn_in_generations && gen %% interval_rich == 0) {
      time_series <- c(time_series, species_richness(community))
    }
    
    # Record species abundance octaves at interval generations
    if (gen %% interval_oct == 0) {
      abundance_list <- append(abundance_list, list(octaves(species_abundance(community))))
    }
    
    # Update elapsed time
    elapsed_time <- proc.time()[3] - start_time
  }
  
  # Save the final state of the simulation
  final_community <- community
  total_time <- elapsed_time
  
  # Save data to a file
  save(time_series, abundance_list, final_community, total_time,
       speciation_rate, size, wall_time, interval_rich, interval_oct, burn_in_generations,
       file = output_file_name)
}

# Example usage (test with a short time limit)
#neutral_cluster_run(
 # speciation_rate = 0.1,
  #size = 100,
  #wall_time = 10,  # Run for 10 minutes
  #interval_rich = 1,
  #interval_oct = 10,
  #burn_in_generations = 200,
  #output_file_name = "my_test_file_1.rda"
#)

#load("my_test_file_1.rda")
#print(time_series)
#print(total_time)




# Questions 24 and 25 involve writing code elsewhere to run your simulations on
# the cluster
 # Function to process a given range of simulation results
function_for_process20 <- function(range) {
  octaves_sum <- c()
  counts_of_repeats <- 0
  
  for (i in range) {
    load(paste0("simulation_results_", i, ".rda"))  # Load simulation results
    
    for (index in seq(length(abundance_list))) {
      generations <- (index - 1) * interval_oct  # Convert index to actual generations
      
      if (generations > burn_in_generations) {  # Post-burn-in data
        octaves_list_post_burn_in <- abundance_list[[index]]
        octaves_sum <- sum_vect(octaves_sum, octaves_list_post_burn_in)
        counts_of_repeats <- counts_of_repeats + 1
      }
    }
  }
  
  mean_average <- octaves_sum / counts_of_repeats  # Compute mean
  return(mean_average)
}


# Function to process all simulation outputs and save results
process_neutral_cluster_results <- function() {
  combined_results <- list(
    function_for_process20(1:25),   # Size 500
    function_for_process20(26:50),  # Size 1000
    function_for_process20(51:75),  # Size 2500
    function_for_process20(76:100)  # Size 5000
  )
  
  save(combined_results, file = "Processed_cluster_results.rda")  # Save processed data
}

# Function to generate octave category labels
Forming_colname <- function(octaves_vector) { 
  return(sapply(seq(length(octaves_vector)) - 1, function(x) 
    ifelse(x == 0, "1", paste0(2^x, "-", 2^(x + 1) - 1))
  ))
}

# Function to plot a bar graph for a given abundance distribution
ploting_for_question20 <- function(data, size, lab = "Neutral Model") {
  barplot(data, names.arg = Forming_colname(data),
          xlab = paste0("Number of individuals per Species (Community Size: ", size, ")"),
          ylab = "Species richness", 
          main = paste0("Mean Species Abundance Distribution of ", lab),
          ylim = c(0, ceiling(max(data))))
}

# Function to plot and save the results as an image
plot_neutral_cluster_results <- function() {
  graphics.off()  # Close existing plots
  load("Processed_cluster_results.rda")  # Load processed results
  
  png("plot_neutral_cluster_results.png", width = 1200, height = 900)  # Save as PNG
  par(mfrow = c(2, 2), mar = c(4, 4, 3, 1))  # Multi-panel layout
  
  ploting_for_question20(combined_results[[1]], 500)
  ploting_for_question20(combined_results[[2]], 1000)
  ploting_for_question20(combined_results[[3]], 2500)
  ploting_for_question20(combined_results[[4]], 5000)
  
  dev.off()  # Close the PNG device
  return(combined_results)
}


# Run processing and plotting functions (Uncomment when ready to execute)
process_neutral_cluster_results()
plot_neutral_cluster_results()
###########try this one ^^


# Question 26 
process_neutral_cluster_results <- function() {

  result_files <- list.files(path = "rda", pattern= "simulation_results_", full.names = TRUE)

  #debug
   if (length(result_files) == 0) {
        stop("No simulation results found in the 'rda' directory.")
    }
  

  sizes <- c(500, 1000, 2500, 5000)
  octave_sums <- vector ("list", length(sizes))
  names(octave_sums) <- as.character(sizes)

  counts <- setNames(rep(0, length(sizes)), sizes)

  sum_vect <- function(x, y) {
  lenx <- length(x) 
  leny <- length(y)

  # Ensure both vectors are of equal length by padding with zeroes
  if(lenx < leny) {
    x <- c(x, rep(0, leny - lenx))
  } else if (leny < lenx) {
    y <- c(y, rep(0, lenx - leny))
  }
  return(x + y)
}
  #load file per file 
  for (file in result_files) {
    load(file)

    if (as.character(size) %in% names(octave_sums)) {
        post_burn_in_octaves <- abundance_list

      if (is.null(octave_sums[as.character(size)])){
        octave_sums[[as.character(size)]] <- post_burn_in_octaves
    } else { 
        octave_sums[[as.character(size)]] <- Map(sum_vect, octave_sums[[as.character(size)]], post_burn_in_octaves)
    }
    counts[as.character(size)] <- counts[as.character(size)] + length(post_burn_in_octaves)
  }
  }
for (size in names(octave_sums)) {
        if (counts[size] > 0) {
            octave_sums[[size]] <- Reduce(sum_vect, octave_sums[[size]]) / counts[size]
        } else {
            warning(paste("No data found for size", size))
        }
    }
    
    save(octave_sums, file = "processed_neutral_cluster_results.rda")
    return(octave_sums)
}

process_neutral_cluster_results()

plot_neutral_cluster_results <- function(){
  
    # load combined_results from your rda file
    load("processed_neutral_cluster_results.rda")
    df_list <- lapply(names(octave_sums), function(size) {
      data.frame(CommunitySize = as.numeric(size), 
          Octave = seq_along(octave_sums[[size]]), 
          Abundance = octave_sums[[size]])
       }
      )
    df <- do.call(rbind, df_list)
    
    p <- ggplot(df, aes(x= Octave, y = Abundance, fill = as.factor(CommunitySize))) +
        geom_bar(stat = "identity", show.legend = FALSE) +
        facet_wrap( ~ CommunitySize, scales = "free_y") +
        labs(title = "Mean Species Abundance by Community Size", 
          x = "Octave", y = "Mean Abundance" ) +
        theme_minimal()
    
    ggsave("")


plot_neutral_cluster_results <- function(){
  
    # load combined_results from your rda file
    load("processed_neutral_cluster_results.rda")
    df_list <- lapply(names(octave_sums), function(size) {
      data.frame(CommunitySize = as.numeric(size), 
      Octave = seq_along(octave_sums[[size]]), 
      Abundance = octave_sums[[size]])
       }
      )
    df <- do.call(rbind, df_list)
    
    p <- ggplot(df, aes(x= Octave, y = Abundance, fill = as.factor(CommunitySize))) +
        geom_bar(stat = "identity", show.legend = FALSE) +
        facet_wrap( ~ CommunitySize, scales = "free_y") +
        labs(title = "Mean Spevies Abundance by Community Size", 
          x = "Octave", y = "Mean Abundance" ) +
        theme_minimal()
    
    ggsave("plot_neutral-cluster-results.png", plot = p, dpi = 300)
    return(df)
}
# Function to process simulation results from cluster

# Challenge questions - these are substantially harder and worth fewer marks.
# I suggest you only attempt these if you've done all the main questions. 

# Challenge question A
Challenge_A <- function(){
  
  png(filename="Challenge_A", width = 600, height = 400)
  # plot your graph here
  Sys.sleep(0.1)
  dev.off()
  
}

# Challenge question B
Challenge_B <- function() {
  
  png(filename="Challenge_B", width = 600, height = 400)
  # plot your graph here
  Sys.sleep(0.1)
  dev.off()
  
}



Challenge_B <- function() {
    library(ggplot2)

    n_simulations <- 50
    generations <- 2200
    richness_data <- matrix(NA, nrow=n_simulations, ncol=generations)

    for (i in 1:n_simulations) {
        community <- rep(1:100, each=1)
        for (gen in 1:generations) {
            community <- sample(community, replace=TRUE)
            richness_data[i, gen] <- length(unique(community))
        }
    }

    mean_richness <- colMeans(richness_data)
    ci_97_2 <- apply(richness_data, 2, function(x) quantile(x, c(0.014, 0.986)))

    df <- data.frame(Generation=1:generations, Mean=mean_richness, Lower=ci_97_2[1,], Upper=ci_97_2[2,])

    ggplot(df, aes(x=Generation, y=Mean)) +
        geom_line(color="blue") +
        geom_ribbon(aes(ymin=Lower, ymax=Upper), alpha=0.3, fill="blue") +
        ggtitle("Mean Species Richness Over Time") +
        xlab("Generations") + ylab("Mean Species Richness") +
        theme_minimal()

    ggsave("Challenge_B.png")

    return("The system reaches equilibrium after approximately 1500 generations, where mean richness stabilizes.")
}

Challenge_B()


# Challenge question C
Challenge_C <- function() {
  



  png(filename="Challenge_C", width = 600, height = 400)
  # plot your graph here
  Sys.sleep(0.1)
  dev.off()

}

# Challenge question D
Challenge_D <- function() {
  
  png(filename="Challenge_D", width = 600, height = 400)
  # plot your graph here
  Sys.sleep(0.1)
  dev.off()
}

# Challenge question E
Challenge_E <- function() {
  
  png(filename="Challenge_E", width = 600, height = 400)
  # plot your graph here
  Sys.sleep(0.1)
  dev.off()
  
  return("type your written answer here")
}


if (dev.cur() > 1) dev.off()  # Close only if an active device exists
