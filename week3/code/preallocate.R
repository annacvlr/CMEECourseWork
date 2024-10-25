##Compares the performance of two functions, one without preallocated memory for a vector and one with. 
NoPreallocFunc <- function(x) {
    a <- vector() 
    for (i in 1:x) {
        a <- c(a,i)
        print(a)
        print(object.size(a))
    }
}
system.time(NoPreallocFunc(10))


PreallocFun <- function(x) {
    a <- rep(NA, x)
    for (i in 1:x) {
        a[i] <- i 
        print(a)
        print(object.size(a))

    }
}
system.time(PreallocFun(10))

## increase iterations to script and supress print commanfs 


NoPreallocFunc <- function(x) {
    a <- vector() 
    for (i in 1:x) {
        a <- c(a,i)
    }
}
system.time(NoPreallocFunc(1000))



PreallocFun <- function(x) {
    a <- rep(NA, x)
    for (i in 1:x) {
        a[i] <- i 
    }
}
system.time(PreallocFun(1000))