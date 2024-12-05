##Script analysing the SparrowSize dataset. comparing winglength with year and sex.


#Test if wing length in 2001 differs from the grand-total mean in wing length
#Test if male and female wing length differ in 2001
#Test if male and female wing length differ in the full dataset
#Report in a table, don’t forget the N’s!

#Report in text

library(dplyr)

d <- read.table("Data/SparrowSize.txt", header = TRUE)
d2 <- subset(d, d$Tarsus!="NA")


#wing length 2001 vs wing length mean
wing_mean <- mean(d$Wing, na.rm = TRUE)
wing_mean #gran total mean

library(dplyr)

d <- read.table("Data/SparrowSize.txt", header = TRUE)
d2 <- subset(d, d$Tarsus!="NA")


#wing length 2001 vs wing length mean
wing_mean <- mean(d$Wing, na.rm = TRUE)
wing_mean #gran total mean

d2001 <- subset(d, Year == 2001)
wing_2001_mean <- mean(d2001$Wing, na.rm = TRUE)

t <- t.test(wing_2001_mean, mu = wing_mean)
t
d2001 <- subset(d, Year == 2001)
wing_2001_mean <- mean(d2001$Wing, na.rm = TRUE)

t <- t.test(d2001$Wing, mu = wing_mean)
t ##wing length in 2001 is different from mu but not statistically significant 



#Test if male and female wing length differ in 2001
t.test(d2001$Wing~d2001$Sex, na.rm=TRUE)
# 95% the difference is not 0 so they are different
# there is statistically significant difference in wing lengths btw males and females in 2001
#males have longer wing lengths with a mean difference of 2.19



#Test if male and female wing length differ in the full dataset
t.test(d2$Wing~d2$Sex, na.rm=TRUE)