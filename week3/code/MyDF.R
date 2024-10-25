
"""opening EcolArchives-E089-51-D1.csv file and seeing its dimensions"""


MyDF <- read.csv("../data/EcolArchives-E089-51-D1.csv")
dim(MyDF)
str(MyDF)
head(MyDF)

require(tidyverse)
glimpse(MyDF)

##dataset contains predator prey body size information

MyDF$Type.of.feeding.interaction <- as.factor(MyDF$Type.of.feeding.interaction)
MyDF$Location <- as.factor(MyDF$Location)
str(MyDF)



#scatterplot

plot(MyDF$Predator.mass,MyDF$Prey.mass)

#take logarithmic 
plot(log(MyDF$Predator.mass),log(MyDF$Prey.mass))

plot(log10(MyDF$Predator.mass),log10(MyDF$Prey.mass))
#looking w a log10 - you can see orders of magnitude 


plot(log10(MyDF$Predator.mass),log10(MyDF$Prey.mass),pch=20) # Change marker

plot(log10(MyDF$Predator.mass),log10(MyDF$Prey.mass),pch=20, xlab = "Predator Mass (g)", ylab = "Prey Mass (g)") 
#xlab and ylab are labels


#histograms
hist(MyDF$Predator.mass)
#data skwewd - small body sized organisms dominating

hist(log10(MyDF$Predator.mass), xlab = "log10(Predator Mass g)", ylab= "count", col="lightblue", border="pink")



#histograms
hist(MyDF$Prey.mass)
#data skwewd - small body sized organisms dominating


hist(log10(MyDF$Prey.mass), xlab = "log10(Prey Mass g)", ylab= "count", col="red", border="black", cex.lab =1.5, font.lab= 2)

hist(log10(MyDF$Predator.mass), xlab = "log10(Predator Mass g)", ylab= "count", col="red", border="black", cex.lab =1.5, font.lab= 2)


#subplots - to see two plots together at the same time

par(mfcol=c(2,1)) #multi panel plot. 2 rows, 1 column. 2 items one on top of eachother
par(mfg=c(1,1))  #specify first subplot 
hist(log10(MyDF$Predator.mass), xlab = "log10 (Predator Mass g)", ylab= "Count", col="blue", border="black", main="Predator")
par(mfg = c(2,1))
hist(log10(MyDF$Prey.mass), xlab= "log10 (Prey Mass g))", ylab ="Count", col = "green", border ="black", main="Prey")


#overlaying plots
bin_width=0.5
hist(log10(MyDF$Predator.mass), xlab="log10 (Body Mass g)", ylab= "count", col= rgb(1, 0, 0, 0.5), main="Predator prey size overlap", breaks = seq(floor(min(log10(MyDF$Predator.mass))), ceiling(max(log10(MyDF$Predator.mass))), by = bin_width))
hist(log10(MyDF$Prey.mass), col= rgb(0,0,1,0.5), add=T, breaks = seq(floor(min(log10(MyDF$Prey.mass))), ceiling(max(log10(MyDF$Prey.mass))), by = bin_width))
legend("topleft", c("Predators", "Prey"), fill=c(rgb(1, 0,0, 0.5), rgb(0, 0, 1, 0.5)))



#boxplots
boxplot(log10(MyDF$Predator.mass), xlab="location", ylab="log10(Predator Mass)", main="Predator mass")

boxplot(log(MyDF$Predator.mass) ~ MyDF$Location, 
    xlab = "Location", ylab = "Predator Mass",
    main = "Predator mass by location")
##tilde seperates dependent variable (xL) vs indepedent variable (xR)

boxplot(log(MyDF$Predator.mass) ~ MyDF$Type.of.feeding.interaction,
    xlab = "Location", ylab = "Predator Mass",
    main = "Predator mass by feeding interaction type")


#combining plot types
par(fig=c(0,0.8,0,0.8)) # figure size
#scatterplot
 plot(log(MyDF$Predator.mass),log(MyDF$Prey.mass), xlab = "Predator Mass (g)", ylab = "Prey Mass (g)") # Add labels
 #boxplot for predator
 par(fig=c(0,0.8,0.4,1), new=TRUE)
 boxplot(log(MyDF$Predator.mass), horizontal=TRUE, axes=FALSE)
#boxplot for prey
 par(fig=c(0.55,1,0,0.8),new=TRUE)
 boxplot(log(MyDF$Prey.mass), axes=FALSE)
 #add titles
 mtext("Fancy Predator-prey scatterplot", side=3, outer=TRUE, line=-3)

 #save a pdf
 pdf("../results/Pred_Prey_Overlay.pdf", # Open blank pdf page using a relative path
    11.7, 8.3) # These numbers are page dimensions in inches
hist(log(MyDF$Predator.mass), # Plot predator histogram (note 'rgb')
    xlab="Body Mass (g)", ylab="Count", col = rgb(1, 0, 0, 0.5), main = "Predator-Prey Size Overlap") 
hist(log(MyDF$Prey.mass), # Plot prey weights
    col = rgb(0, 0, 1, 0.5), 
    add = T)  # Add to same plot = TRUE
legend('topleft',c('Predators','Prey'), # Add legend
    fill=c(rgb(1, 0, 0, 0.5), rgb(0, 0, 1, 0.5))) 
graphics.off(); #you can also use dev.off() 


#quick plotting qplot
require(ggplot2)
qplot(Prey.mass, Predator.mass, data=MyDF)
qplot(log(Prey.mass), log(Predator.mass), data =MyDF)
qplot(log(Prey.mass), log(Predator.mass),data=MyDF, colour = Type.of.feeding.interaction, asp= 1)

qplot(log(Prey.mass), log(Predator.mass), 
    data = MyDF, colour = "red")

#real red
qplot(log(Prey.mass), log(Predator.mass), data = MyDF, colour = I("red"))
#same w size
qplot(log(Prey.mass), log(Predator.mass), data = MyDF, size = 3) #with ggplot 
qplot(log(Prey.mass), log(Predator.mass),  data = MyDF, size = I(3)) 

# will give error qplot(log(Prey.mass), log(Predator.mass), data = MyDF, shape = 3) 
qplot(log(Prey.mass), log(Predator.mass), data = MyDF, shape= I(3))
qplot(log(Prey.mass), log(Predator.mass), data = MyDF, colour = Type.of.feeding.interaction, alpha= I(0.5))

#smoothers and regression lines
qplot(log(Prey.mass), log(Predator.mass), data = MyDF, geom=c("point", "smooth"))
qplot(log(Prey.mass), log(Predator.mass), data = MyDF, geom = c("point", "smooth")) + geom_smooth(method = "lm")
qplot(log(Prey.mass), log(Predator.mass), data = MyDF, geom = c("point", "smooth"), colour = Type.of.feeding.interaction ) + geom_smooth(method = "lm",fullrange = TRUE)
qplot(Type.of.feeding.interaction, log(Prey.mass/Predator.mass), data = MyDF)
qplot(Type.of.feeding.interaction, log(Prey.mass/Predator.mass), data = MyDF, geom = "jitter")

#boxplot
qplot(Type.of.feeding.interaction, log(Prey.mass/Predator.mass), data = MyDF, geom = "boxplot")

#histogram 
qplot(log(Prey.mass/Predator.mass), data = MyDF, geom = "histogram")
qplot(log(Prey.mass/Predator.mass), data = MyDF, geom =  "histogram",fill = Type.of.feeding.interaction)
qplot(log(Prey.mass/Predator.mass), data = MyDF, geom =  "histogram", fill = Type.of.feeding.interaction, binwidth = 1)
qplot(log(Prey.mass/Predator.mass), data = MyDF, geom =  "density", fill = Type.of.feeding.interaction)
qplot(log(Prey.mass/Predator.mass), data = MyDF, geom =  "density", fill = Type.of.feeding.interaction, alpha = I(0.5))
qplot(log(Prey.mass/Predator.mass), data = MyDF, geom =  "density", colour = Type.of.feeding.interaction)

#multifaceted plots
qplot(log(Prey.mass/Predator.mass), facets = Type.of.feeding.interaction ~., data =MyDF, geom ="density") #row
qplot(log(Prey.mass/Predator.mass), facets =  .~ Type.of.feeding.interaction, data = MyDF, geom =  "density") #column configuration


#plot annotations
qplot(Prey.mass, Predator.mass, data = MyDF, log="xy",
    main = "relationship btw predator and prey mass", 
    xlab = "log (Prey mass g)", ylab = "log (Predator mass g)" + theme_bw())

pdf("../results/MyFirst-ggplot2-Figure.pdf")
print(qplot(Prey.mass, Predator.mass, data = MyDF,log="xy",
    main = "Relation between predator and prey mass", 
    xlab = "log(Prey mass) (g)", 
    ylab = "log(Predator mass) (g)") + theme_bw())
dev.off()



