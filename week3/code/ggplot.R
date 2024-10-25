##"""script using ggplot within ggplot2 """

require(ggplot2)
# load the data
MyDF <- as.data.frame(read.csv("../data/EcolArchives-E089-51-D1.csv"))

p <- ggplot(MyDF, aes(x =log(Predator.mass), 
    y = log(Prey.mass), 
    colour = Type.of.feeding.interaction))

p
#plot is blank --- NEED to specify geom

p + geom_point()

q <- p +
    geom_point(size= I(2), shape=I(10)) +
    theme_bw() +
    theme(aspect.ratio = 1) # make it into a square
q

#remove the legend
q + theme(legend.position = "none") + theme (aspect.ratio=1)

#overlapping plots - density geom
p <- ggplot(MyDF, aes(x=log(Prey.mass/Predator.mass), fill = Type.of.feeding.interaction)) + geom_density()
p
 
#overlapping transparent plots
p <- ggplot(MyDF, aes(x=log(Prey.mass/Predator.mass), fill = Type.of.feeding.interaction)) + geom_density(alpha=0.5)
p

#multifaceted plot
p <- ggplot(MyDF, aes(x = log(Prey.mass/Predator.mass), fill = Type.of.feeding.interaction)) + geom_density() + facet_wrap( .~ Type.of.feeding.interaction)
p

#scales="free"
p <- ggplot(MyDF, aes(x = log(Prey.mass/Predator.mass), fill = Type.of.feeding.interaction )) +  geom_density() + facet_wrap( .~ Type.of.feeding.interaction, scales = "free")
p

##"""plot size ratio distributions by location"""
p <- ggplot(MyDF, aes(x=log(Prey.mass/Predator.mass))) + geom_density() + facet_wrap( .~ Location, scales = "free")
p

p <- ggplot(MyDF, aes(x = log(Prey.mass), y = log(Predator.mass))) + geom_point() + facet_wrap ( .~ Location, scales ="free")
p

#combine categories
p <- ggplot(MyDF, aes(x = log(Prey.mass), y = log(Predator.mass))) + geom_point() + facet_wrap(.~ Location + Type.of.feeding.interaction, scales = "free")
p




library(ggthemes)

p <- ggplot(MyDF, aes(x = log(Predator.mass), y = log(Prey.mass),
                colour = Type.of.feeding.interaction )) +
                geom_point(size=I(2), shape=I(10)) + theme_bw()

p + geom_rangeframe() + # now fine tune the geom to Tufte's range frame
        theme_tufte() # and theme to Tufte's minimal ink theme    