##Defines a function and demonstrates its application on a matrix.


SomeOperation <- function(v) {
    if (sum(v) > 0) {
        return (v *100)
    } else {
        return (v)
    }
}

M <- matrix(rnorm(100), 10,10)
print(apply(M, 1, SomeOperation))


#takes input v - if sum of v is bigger than zero it multiplies the value by 100
# if v has positive and negative numbers - if the sum is positive it will multiply them by 100


#lappy and sapply apply a function to each element of a list