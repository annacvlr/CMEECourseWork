## Script on fitting models that use multiple variables to explain the response variable



library(dplyr)
daphnia <- read.table("../Data/daphnia.txt", header = TRUE)
summary(daphnia)
head(daphnia)

#box and whisker plot 
par(mfrow= c(1,2)) # two plots side by side
plot(Growth.rate ~ as.factor(Detergent), data = daphnia) # box plot 1 
plot(Growth.rate ~ as.factor(Daphnia), data = daphnia) # boxplot 2


#homogeneity of variances
daphnia %>%
    group_by(Detergent) %>% #group data by detergent and calculates the variance of growth rate for each group
    summarise (variance= var(Growth.rate)) ## homogeneity of variances is an assumption for stat tests


#is data normally distributed
dev.off() #closes current graphics device
dev.list() #checks for open devices

hist(daphnia$Growth.rate) # creates a histogram of growth rate to visually inspect its distribution and assess normality 

##create barploys showing means and std Errors of mean for both clonal genotype and detergent presence
# function tapply - to get means and std deviations for each of the two explanatory variables 
#summary stat functions
seFun <- function(x) {
    sqrt(var(x)/length(x))
} # custom function calculates SEM standard error of the mean for a vector of values


#calculating means and sems
detergentMean <- with(daphnia, tapply(Growth.rate, INDEX = Detergent,
    FUN = mean)) #computes SEM for each detergent
detergentSEM <- with (daphnia, tapply(Growth.rate, INDEX = Detergent, FUN=seFun)) #computes the SEM for the same groups
cloneMean <- with(daphnia, tapply(Growth.rate, INDEX = Daphnia, FUN = mean)) # computes mean for each Daphnia clone 
cloneSEM <- with(daphnia, tapply(Growth.rate, INDEX = Daphnia, FUN = seFun)) #calculates SEM for each Daphnia clone 

#bar plots
par(mfrow=c(2,1), mar=c(4,4,1,1)) # 2 vertical plots, mar adjusts margins

barMids <- barplot(detergentMean, xlab = "Detergent type", ylab= "population growth rate", ylim=c(0,5))
arrows(barMids, detergentMean - detergentSEM, barMids, detergentMean + detergentSEM, code = 3, angle = 90)
barMides <- barplot(cloneMean, xlab= "Daphnia clone", ylab = "Population gorwth rate", ylim =c(0,5))
arrows(barMids, cloneMean - cloneSEM, barMids, CloneMean + cloneSEM, code = 3, angle = 90)



daphniaMod <- lm(Growth.rate ~ Detergent + Daphnia, data = daphnia)
summary(daphniaMod)


