##Demonstrates various various control structures: conditional statements, for loops, and while loops.

#"""conditional"""
a <- TRUE
if (a==T) {
    print ("a is TRUE")
} else {
    print (" a is FALSE")
}


z<- runif(1) 
if (z<=0.5) {print("Less than a half")}
###^^^ all in one line, better to indent it to understand what is happening

#"""for loops"""
for ( i in 1:10) {
    j <- i *i
    print(paste(i, "sqared is", j))
}

1:10
#same as using seq()

for (species in c('Heliodoxa rubinoides', 
                 'Boissonneaua jardini', 
                 'Sula nebouxii')) {
    print(paste("the species is", species))
                 }

v1 <- c("a", "bc", "def")
for (i in v1) {
    print(i)
}

##while loops 
i <-0
while (i < 10) {
    i <- i+1
    print(i^2)
}


