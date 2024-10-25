##creates a large 1000x1000 matrix of random numbers, defines a function to compute the sum of all its elements using nested loops, and measures the execution time for this loop-based approach versus using the built-in vectorized sum function.

M <- matrix(runif(1000000),1000,1000)

SumAllElements <- function(M) {
    Dimensions <- dim(M)
    Tot <- 0
    for (i in 1:Dimensions[1]) {
        for (j in 1:Dimensions [2]) {
            Tot <- Tot + M[i,j]
        }
    }
    return (Tot)
}

print("using loops, the time taken is:")
print(system.time(SumAllElements(M)))

print("using the in built vectorized function, the time taken is:")
print(system.time(sum(M)))

