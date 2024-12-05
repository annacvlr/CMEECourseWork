# CMEE 2024 HPC exercises R code main pro forma
# You don't HAVE to use this but it will be very helpful.
# If you opt to write everything yourself from scratch please ensure you use
# EXACTLY the same function and parameter names and beware that you may lose
# marks if it doesn't work properly because of not using the pro-forma.

name <- "Anna Cavalieri Canosa"
preferred_name <- "Anna"
email <- "ac524@imperial.ac.uk"
username <- "ac524"

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

source("Demographic.R")
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
  
question_1()


### Question 2

#write function which applies stochastic_simulation w smae 2 sets of initial conditions and other parameters as given to model in Q1
#growth matrix and reprod. matrix defined as above
# clutch distrib. is provided 
#create and save a png - which plots popu size time series for both simulations using differ coloured lines
#function should output plain text answer to “How does the smoothness of the earlier
#deterministic simulations compare with these stochastic simulations? Explain why this is the case.”



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

question_2()

# Questions 3 and 4 involve writing code elsewhere to run your simulations on the cluster


# Question 5
question_5 <- function(){
  
  png(filename="question_5", width = 600, height = 400)
  # plot your graph here
  Sys.sleep(0.1)
  dev.off()
  
  return("type your written answer here")
}

# Question 6
question_6 <- function(){
  
  png(filename="question_6", width = 600, height = 400)
  # plot your graph here
  Sys.sleep(0.1)
  dev.off()
  
  return("type your written answer here")
}


# Section Two: Individual-based ecological neutral theory simulation 

# Question 7
species_richness <- function(community){
  
}

# Question 8
init_community_max <- function(size){
  
}

# Question 9
init_community_min <- function(size){
  
}

# Question 10
choose_two <- function(max_value){
  
}

# Question 11
neutral_step <- function(community){
  
}

# Question 12
neutral_generation <- function(community){
  
}

# Question 13
neutral_time_series <- function(community,duration)  {
  
}

# Question 14
question_8 <- function() {
  
  
  
  png(filename="question_14", width = 600, height = 400)
  # plot your graph here
  Sys.sleep(0.1)
  dev.off()
  
  return("type your written answer here")
}

# Question 15
neutral_step_speciation <- function(community,speciation_rate)  {
  
}

# Question 16
neutral_generation_speciation <- function(community,speciation_rate)  {
  
}

# Question 17
neutral_time_series_speciation <- function(community,speciation_rate,duration)  {
  
}

# Question 18
question_18 <- function()  {
  
  png(filename="question_18", width = 600, height = 400)
  # plot your graph here
  Sys.sleep(0.1)
  dev.off()
  
  return("type your written answer here")
}

# Question 19
species_abundance <- function(community)  {
  
}

# Question 20
octaves <- function(abundance_vector) {
  
}



#Write a function sum_vect(x,y) which accepts two vectors as inputs, x and y, and returns their
#sum, after filling whichever of the vectors that is shorter with zeros to bring it up to the correct
#length. For example, sum_vect(c(1,3),c(1,0,5,2)) should return { 2 3 5 2 } by adding { 1 3 0 0
#} and { 1 0 5 2 }. (Hint: the ‘length’ function and ‘if’ command).
#
## Question 21
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


# Question 22
question_22 <- function() {
  
  png(filename="question_22", width = 600, height = 400)
  # plot your graph here
  Sys.sleep(0.1)
  dev.off()
  
  return("type your written answer here")
}

# Question 23
neutral_cluster_run <- function(speciation_rate, size, wall_time, interval_rich, interval_oct, burn_in_generations, output_file_name) {
    
}

# Questions 24 and 25 involve writing code elsewhere to run your simulations on
# the cluster

# Question 26 
process_neutral_cluster_results <- function() {
  
  
  combined_results <- list() #create your list output here to return # 
  # save results to an .rda file
  
}

plot_neutral_cluster_results <- function(){

    # load combined_results from your rda file
  
    png(filename="plot_neutral_cluster_results", width = 600, height = 400)
    # plot your graph here
    Sys.sleep(0.1)
    dev.off()
    
    return(combined_results)
}


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

# Challenge question C
Challenge_B <- function() {
  
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

