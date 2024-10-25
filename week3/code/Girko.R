##visualise eigenvalues of a random matrix in relatoin to an ellpisem illustrating Girko's Circular law.
#Demonstrating Girko’s circular law, the eigenvalues of a matrix of size are approximately contained in a circle in the complex plane with radius


require(ggplot2)



build_ellipse <- function(hradius, vradius) { 
    npoints = 250
    a <- seq(0, 2 * pi, length.out = npoints +1)
    x <- hradius * cos(a)
    y <- vradius * sin(a)
    return(data.frame(x = x, y = y))
}


N <- 250 #assign size of matrix 
M <- matrix (rnorm(N * N), N, N) 
eigvals <- eigen(M)$values #find eigenvalues
eigDF <- data.frame("Real" = Re(eigvals), "Imaginary" = Im(eigvals)) #dataframe building
my_radius <- sqrt(N) # radius of circle
ellDF <- build_ellipse(my_radius, my_radius) #dataframe plotting eclipse
names(ellDF) <- c("Real", "Imaginary") #rename

#plot eigen values
p <-ggplot(eigDF, aes(x = Real, y = Imaginary))
p <- p +
    geom_point (shape = I(3)) + 
    theme(legend.position = "none")

#add vertical and horiziontal line
p <- p + geom_hline(aes(yintercept = 0))
p <- p + geom_vline(aes(xintercept = 0))

#add ellipse 


#save in results folder
pdf("../results/Girko.pdf")
p <- p + geom_polygon(data = ellDF, aes(x = Real, y = Imaginary, alpha = 1/20, fill = "red"))
p
dev.off() 



