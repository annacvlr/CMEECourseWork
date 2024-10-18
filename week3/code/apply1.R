##apply used when you want to apply a function to rows or columns of a matrix 

#random matrix
M <- matrix(rnorm(100),10,10)


#mean of each row
RowMeans <- apply(M, 1, mean)
print(RowMeans)

#variance
RowVars <- apply(M, 1, var )
print (RowVars)

#mean by column
ColMeans <- apply(M, 2, mean)
print(ColMeans)