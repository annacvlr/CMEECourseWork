##Script on Variance and Covariance 

#variance i sthe sum of deviations ffrom the mean 


y1 <- rnorm(10, 0, sqrt(1))
var(y1)

y2 <- rnorm(10, 0, sqrt(10))
var(y2)

y3 <- rnorm(10, 0, sqrt(100))
var(y3)

#repeat 0 10x
x <- rep(0,10)
par(mfrow = c(1, 3))

plot(x, y1, xlim=c(-0.1, 0.1), ylim=c(-12,12), pch=19, cex=0.8, col="red")
abline(v=0)
abline(h=0)

plot(x, y2, xlim=c(-0.1, 0.1), ylim=c(-12,12), pch=19, cex=0.8, col="blue")
abline(v=0)
abline(h=0)

plot(x, y3, xlim=c(-0.1, 0.1), ylim=c(-12,12), pch=19, cex=0.8, col="green")
abline(v=0)
abline(h=0)


#polygons
par(mfrow = c(1,3))
plot(x, y1, xlim = c(-12,12), ylim = c(-12,12), pch=19, cex=0.8, col="red")
abline=(v=0)
abline(h=0)
polygon(x=c(0,0,y1[1], y1[1]), y=c(0, y1[1], y1[1], 0), col=rgb(1,0,0, 0.2))
polygon(x=c(0,0, y1[2], y1[2]), y=c(0, y1[2], y1[2], 0), col=rgb(1,0,0,0.2))
polygon(x=c(0,0,y1[3],y1[3]),y=c(0,y1[3],y1[3],0), col=rgb(1, 0, 0,0.2))
polygon(x=c(0,0,y1[4],y1[4]),y=c(0,y1[4],y1[4],0), col=rgb(1, 0, 0,0.2))
polygon(x=c(0,0,y1[4],y1[4]),y=c(0,y1[4],y1[4],0), col=rgb(1, 0, 0,0.2))
polygon(x=c(0,0,y1[5],y1[5]),y=c(0,y1[5],y1[5],0), col=rgb(1, 0, 0,0.2))
polygon(x=c(0,0,y1[6],y1[6]),y=c(0,y1[6],y1[6],0), col=rgb(1, 0, 0,0.2))
polygon(x=c(0,0,y1[7],y1[7]),y=c(0,y1[7],y1[7],0), col=rgb(1, 0, 0,0.2))
polygon(x=c(0,0,y1[8],y1[8]),y=c(0,y1[8],y1[8],0), col=rgb(1, 0, 0,0.2))
polygon(x=c(0,0,y1[9],y1[9]),y=c(0,y1[9],y1[9],0), col=rgb(1, 0, 0,0.2))
polygon(x=c(0,0,y1[10],y1[10]),y=c(0,y1[10],y1[10],0), col=rgb(1, 0, 0,0.2))


plot(x, y2, xlim=c(-12,12), ylim=c(-12,12), pch=19, cex=0.8, col="blue")
abline(v=0)
abline(h=0)
for (i in 1:length(y2)) {
    polygon(x=c(0, 0, y2[i], y2[i], 0), col=rgb(0,0,1,0.2))
}

plot(x, y3, xlim=c(-12,12), ylim=c(-12,12), pch=19, cex=0.8, col="darkgreen")
abline(v=0)
abline(h=0)
for (i in 1:length(y3)) {
    polygon (x=c(0, 0, y3[i], y3[1]), y=c(0, y3[i], y3[i], 0), col=rgb(0, 1, 0, 0.2))
}

rm(list = ls())
par(mfrow= c(1,3))
x <- c(-10:10)
var(x)

y1 <- x*1 +rnorm(21, 0, sqrt(1))
cov(x, y1)


plot(x, y1, xlim=c(-10,10), ylim=c(-20, 20), col="red", pch=19, cex=0.8, main=paste("Cov=",round(cov(x,y1),digits=2)))
y2<-rnorm(21, mean=0, sd=sqrt(1))

cov(x, y2)

plot(x, y2, xlim=c(-10,10), ylim=c(-20, 20), col="blue", pch=19, cex=0.8, main=paste("Cov=",round(cov(x,y2),digits=2)))

rm(list = ls())
par(mfrow= c(1,3))
x <- c(-10:10)
var(x)

y1 <- x*1 +rnorm(21, 0, sqrt(1))
cov(x, y1)


plot(x, y1, xlim=c(-10,10), ylim=c(-20, 20), col="red", pch=19, cex=0.8, main=paste("Cov=",round(cov(x,y1),digits=2)))
y2<-rnorm(21, mean=0, sd=sqrt(1))

cov(x, y2)

plot(x, y2, xlim=c(-10,10), ylim=c(-20, 20), col="blue", pch=19, cex=0.8, main=paste("Cov=",round(cov(x,y2),digits=2)))

y3<- x*(-1) + rnorm(21, 0, sqrt(1))
# Here, the association is negative
cov(x, y3)

plot(x, y3, xlim=c(-10,10), ylim=c(-20, 20), col="darkgreen", pch=19, cex=0.8, main=paste("Cov=",round(cov(x,y3),digits=2)))


#covariance changes the stronger the variables are associated with eachother