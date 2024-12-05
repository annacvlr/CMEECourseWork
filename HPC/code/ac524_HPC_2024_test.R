# CMEE 2024 HPC excercises R code HPC run code proforma

rm(list=ls()) # good practice 
source("ac524_HPC_2024_main.R")
source("Demographic.R")

# it should take a faction of a second to source your file
# if it takes longer you're using the main file to do actual simulations
# it should be used only for defining functions that will be useful for your cluster run and which will be marked automatically

# do what you like here to test your functions (this won't be marked)
# for example
species_richness(c(1, 4, 4 , 5, 1, 6, 1))
# should return 4 when you've written the function correctly for question 1

# you may also like to use this file for playing around and debugging
# but please make sure it's all tidied.
#up by the time it's made its way into the main.R file or other files.



#####Q0
#state_initialise_adult <- function(num_stages,initial_size){
#   state_vector <- rep(0, num_stages)
#   state_vector[num_stages] <- initial_size
#   return(state_vector)
#}

state_initialise_adult(5,10)

state_initialise_spread(3,8)

sum_vect(c(1,3), c(1, 0, 5, 3))

