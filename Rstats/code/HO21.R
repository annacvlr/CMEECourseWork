## script on Poisson models including: data exploration, model building and fitting, initial interpretations, model validation, model refitting, model interpretation and plotting

require(ggplot2)
require(MASS)
require(ggpubr)

fish <- read.csv ("../Data/fisheries.csv")
str(fish)
# dataset includes abundance data fro range of uniqye sites dfrom 1977 to 2002
# Dens = density
# MeanDepth = mean depth in km of water column
#period1 from 1979 to 1989, period 3 from 1997 to 2002
#swept area = total area sampled in each site 

#investigate total abundance changes with mean depth of water column
ggplot(fish, aes(x=MeanDepth, y=TotAbund))+ 
    geom_point()+
    labs(x="Mean Depth km", y="Total Abundance") +
    theme_classic()

#basic model has total abundance as our response variable and mean dpeth as explanatory variable

M1 <- glm(TotAbund~MeanDepth, data = fish, family = "poisson")
summary(M1) 
#from summary we can build initial model equation and infer tht as mean depth increases the total abundance of fish decreases

#model diagnostics 
par(mfrow=c(2,2)) #plot window w for objects, 2x2
plot(M1)
#std Pearson resid vs leverage plot highlights potential foe large number of outliers 
#outliers have a Cook's distance more than 1 
sum(cooks.distance(M1)> 1) #we have 29 outliers - cannot drop them all 

#examine dispersion parameter 
15770/144#=109.5139 model is overdispersed
#possibly bec missing covariates or inherent dependency

scatterplot <- ggplot(fish, aes(x=MeanDepth, y=TotAbund, color=factor(Period)))+
    geom_point() +
    labs(x="Mean Depth km", y="Total Abundance") +
    theme_classic()+
    scale_color_discrete(name="Period", labels=c("1979-1989", "1977-2002"))
    
boxplot <- ggplot(fish, aes(x=factor(Period, labels=c("1979-1989", "1997-2002")), y = TotAbund)) +
    geom_boxplot() +
    theme_classic()+
    labs(x= "Period", y="Tot Abundance")

ggarrange(scatterplot, boxplot, labels=c("A", "B"), ncol=1, nrow=2)
#it looks like theres a relationship btw mean depth and tot abund and period 2 has less total abundance than peroiod 1
fish$Period <- factor(fish$Period)
M2 <- glm(TotAbund~MeanDepth*Period, data = fish, family = "poisson")
summary(M2)
anova(M2, test="Chisq")
#period has a significant impact on the affecr of meandepth on tot abund 