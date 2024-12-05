library(dplyr)

d <- read.table("Data/SparrowSize.txt", header = TRUE)
d2 <- subset(d, d$Tarsus!="NA")

#calculate SE of Tars
SE <- (sd(d2$Tarsus) )/ sqrt (length(d2$Tarsus))
SE
length(d2$Tarsus)

mean(d2$Tarsus)
mean(d2001$Tarsus)


#na.omit work


#calculate SE of Tarsus of only 2001
d2001 <- subset(d2, Year == 2001)
SE2001 <- (sd(d2001$Tarsus) )/ sqrt (length(d2001$Tarsus))
SE2001

t.test(d2$Tarsus, mu=18.5, na.rm=TRUE) #mu = mean
t.test(d2$Tarsus~d2$Sex, na.rm=TRUE)


#Wing length
wing <- subset(d, d$Wing!="NA")
SE <- (sd(wing$Wing) )/ sqrt (length(wing$Wing))
SE

#Bill length, Body mass
bill <- subset(d, d$Bill!="NA")
SE <- (sd(bill$Bill) )/ sqrt (length(bill$Bill))
SE

#Body mass
bmass<- subset(d, d$Mass!="NA")
SE <- (sd(bmass$Mass) )/ sqrt (length(bill$Bill))
SE






