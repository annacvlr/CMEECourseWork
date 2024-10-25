

#function runs a simulation that involves sampling from a synthetic population w replacement and takes its mean but only if at least 30 unique samples are obtaines

doit <- function(x) {
    temp_x <- sample(x, replace = TRUE)
    if(length(unique(temp_x)) > 30) { #take maean if sample is sufficient
        print(paste("mean of this sample is:", as.character(mean(temp_x))))
        }
    else {
        stop("Couldn't calculate mean: too few unique values")
    }
}



set.seed(1345) #again to get the same result for illustration
popn <- rnorm(50)
hist(popn)
lapply(1:15, function(i) doit(popn))

result <- lapply(1:15, function(i) try(doit(popn), FALSE))

class(result)
result

result <- vector("list", 15) #preallocate 
for(i in 1:15) {
    result[[i]] <- try(doit(popn), FALSE)
}

result


