##script going through simple linear functions from hand out 7

x <- seq (-5, 5, 1)
x

x[[1]]

x[[1]] -5

x[[2]]

x[[9]]

x[[length(x)]] #length(x) is 11 so its basically asking to get the 11th indice so it gives 5

i <- 1
x[[i]]

i <- seq(0,10,1)
i

x[[i[[2]]]]

i <- 1
x[[i]]
i <- seq(0,10,1)
i

x[[i[[2]]]]


a <- 2
b <- 1
y <- a+b*x
plot(x,y)
segments(0, -10, 0, 10, lty=3)
segments(-10, 0, 10, 0, lty=3)
plot(x, y, col="white")
segments(0, -10, 0, 10, lty=3)
segments(-10, 0, 10, 0, lty=3)
abline(a=2, b=1)


