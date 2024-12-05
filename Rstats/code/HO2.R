##Script following HandOut 2, using the SparrowsSize.txt data


d <- read.table("Data/SparrowSize.txt", header = TRUE)
str(d)
names(d)
head(d)
length(d$Tarsus)
hist(d$Tarsus)
mean(d$Tarsus) ##missing values --> set na.rm = TRUE so that NAs are stripped before computation
help(mean)
mean(d$Tarsus, na.rm = TRUE)
median(d$Tarsus, na.rm = TRUE)
mode(d$Tarsus)

par(mfrow = c(2,2)) # 2 columns and 2 rows, 4 plots.
hist(d$Tarsus, breaks =3, col = "grey")
hist(d$Tarsus, breaks = 10, col="grey")
hist(d$Tarsus, breaks = 30, col="grey")
hist(d$Tarsus, breaks = 100, col="grey")
# number of breaks determines number of bins used to draw histogram

head(table(d$Tarsus))
d$Tarsus.rounded<-round(d$Tarsus, digits=1)
head(d$Tarsus.rounded)

require(dplyr)
TarsusTally <- d %>% count(Tarsus.rounded, sort =TRUE)
TarsusTally
d2 <- subset(d, d$Tarsus!="NA")
length(d$Tarsus)-length(d2$Tarsus)
TarsusTally <- d2 %>% count(Tarsus.rounded, sort =TRUE)
TarsusTally

TarsusTally[1]
TarsusTally[2]
TarsusTally[[1]]
TarsusTally[[1]][1]  #if the console has ## then its a continuation of the output
mean(d$Tarsus, na.rm = TRUE)
median(d$Tarsus, na.rm = TRUE)
TarsusTally[[1]][1]

#range variance and std dev
range(d$Tarsus, na.rm=TRUE)
range(d2$Tarsus, na.rm = TRUE)
var(d$Tarsus, na.rm = TRUE)
var(d2$Tarsus, na.rm = TRUE)

sum((d2$Tarsus - mean(d2$Tarsus))^2)/(length(d2$Tarsus) -1 )
var(d2$Tarsus)
sqrt(var(d2$Tarsus))
sqrt(0.74)
sd(d2$Tarsus)

#zscores & quantiles
zTarsus <- (d2$Tarsus - mean(d2$Tarsus))/sd(d2$Tarsus)
var(zTarsus)
sd(zTarsus)
hist(zTarsus)

znormal <- rnorm(1e+06)
hist(znormal, breaks = 100)
summary(znormal)

qnorm(c(0.025, 0.975))
pnorm(.Last.value)

par(mfrow = c(1,2))
hist(znormal, breaks = 100)
abline(v = qnorm(c(0.25, 0.5, 0.75)), lwd = 2)
abline(v = qnorm(c(0.025, 0.975)), lwd = 2, lty = "dashed")
plot(density(znormal))
abline(v = qnorm(c(0.25, 0.5, 0.75)), col = "gray")
abline(v = qnorm(c(0.025, 0.975)), lty = "dotted", col = "black")
abline(h = 0, lwd = 3, col = "blue")
text(2, 0.3, "1.96", col = "red", adj = 0)
text(-2, 0.3, "-1.96", col = "red", adj = 1)

##for z score 
#z_scores <- scale(data)