##defines multiple functions to calculate the mean of random samples from a population and compares the execution time of different sampling methods, including loops with and without preallocation, as well as vectorized approaches using lapply and sapply.


#### Vectorization example ####


# function: mean of sample size (n) from a population (popn) 
myexperiment <- function(popn, n) {
    pop_sample <- sample(popn, n, replace = FALSE)
    return(mean(pop_sample))
}


#for loop to calc mean of a vector without prealloc
loopy_sample1 <- function(popn, n, num) {
    result1 <- vector() 
    for (i in 1:num) {
        result1 <- c(result1, myexperiment(popn, n))
    }
    return(result1)
}

## To run "num" iterations of the experiment using a FOR loop on a vector with preallocation:
loopy_sample2 <- function(popn, n, num) {
    result2 <- vector(,num) #Preallocate expected size
    for(i in 1:num) {
        result2[i] <- myexperiment(popn, n)
    }
    return(result2)
}

## To run "num" iterations of the experiment using a FOR loop on a list with preallocation:
loopy_sample3 <- function(popn, n, num) {
    result3 <- vector("list", num) #Preallocate expected size
    for(i in 1:num) {
        result3[[i]] <- myexperiment(popn, n)
    }
    return(result3)
}


## To run "num" iterations of the experiment using vectorization with lapply:
lapply_sample <- function(popn, n, num) {
    result4 <- lapply(1:num, function(i) myexperiment(popn, n))
    return(result4)
}

## To run "num" iterations of the experiment using vectorization with sapply:
sapply_sample <- function(popn, n, num) {
    result5 <- sapply(1:num, function(i) myexperiment(popn, n))
    return(result5)
}



set.seed(12345)
popn <- rnorm(10000) # Generate the population
hist(popn)


n <- 100 # sample size for each experiment
num <- 10000 # Number of times to rerun the experiment


#n <- 2
#num <- 10

print("Using loops without preallocation on a vector took:" )
print(system.time(loopy_sample1(popn, n, num)))

print("Using loops with preallocation on a vector took:" )
print(system.time(loopy_sample2(popn, n, num)))

print("Using loops with preallocation on a list took:" )
print(system.time(loopy_sample3(popn, n, num)))

print("Using the vectorized sapply function (on a list) took:" )
print(system.time(sapply_sample(popn, n, num)))

print("Using the vectorized lapply function (on a list) took:" )
print(system.time(lapply_sample(popn, n, num)))




