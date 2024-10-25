##Demonstrates how to break out of a loop using a WHILE loop.
#breaking loops
i <- 0
    while (i < Inf) {
        if (i==10) {
            break
        } else {
            cat("i equalse", i, "\n")
            i <- i + 1
        }
    }


