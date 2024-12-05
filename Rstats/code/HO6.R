##script plotting 5 coordinates and carrying out basic statistics 
##script on statistical power 

x <- c(1,2,3,4,8)
y <- c(4,3,5,7,9)
model1 <- (lm(y~x))
model1
summary(model1)
anova(model1)
resid(model1)
cov(x,y)
var(x)
plot(y~x)

#y=0.8288x+2.6164

install.packages("WebPower")
require(WebPower)
0.3/1.2
y <- rnorm(51, mean=1, sd=1.3)
x<- seq(0, 5, 0.1)
length(x)

plot(hist(y, breaks=10))
mean(y)
sd(y)
segments(x0=(mean(y)), y0=(0), x1=(mean(y)), y1=40, lty=1, col="blue")
segments(x0=(mean(y)+0.25*sd(y)), y0=(0), x1=(mean(y)+0.25*sd(y)), y1=40, lty=1, col="red")

?wp.t
wp.t(d=0.25, power=0.8, type="two.sample", alternative="two.sided")
## two sample t test compares means of two independent groups 
# n indicates required sample size for each group to achieve desired power level 
# d is the effect size which measures std difference btw two means
# alpha is the significance level
#power probability of correctly rejecting null hypothesis -- 80% chance of detecting an effect if there is one

res.1 <- wp.t(n1=seq(20,300,20), n2=seq(20,300,20), d=0.25, type="two.sample.2n", alternative="two.sided")
res.1
##n1 and n2 are number of participants in each group 
# d is effect size 0.25 small to medium size effect

plot(res.1, xvar="n1", yvar="power")



##exercises
#1) dataset of 2 groups, each group has n = 300
#1) difference btw groups w effect size of 0.11 (d=0.11) w a p=0.044 
#1) calculate stat test power of test and discuss what the reuslt means

wp.t(n1=(300),n2=(300), d=0.11, type="two.sample.2n", alternative ="two.sided")
#there is a 27% chance of correctly rejecting the null hypothesis if there is a true effect of size 0.11 --- 73% chance of failing to detect a true effect 
# there is low accuracy in null hypothesis rejection --- more data should be collected w a higher effect size. 


wp.t(d=0.11, power=0.8, type="two.sample", alternative="two.sided")
#we require 1298.293 samples




