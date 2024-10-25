# load the data
"""this script demonstrates different types of plots from the ggplot2 module"""

require(ggplot2)
MyDF <- as.data.frame(read.csv("../data/EcolArchives-E089-51-D1.csv"))

# barplot
qplot(Predator.lifestage, data = MyDF, geom = "bar")

#boxplot
qplot(Predator.lifestage, log(Prey.mass), data = MyDF, geom = "boxplot")

#violin plot
qplot(Predator.lifestage, log(Prey.mass), data = MyDF, geom = "violin")

#density
qplot(log(Predator.mass), data = MyDF, geom = "density")

#histogram
qplot(log(Predator.mass), data = MyDF, geom = "histogram")

#scatterplot
qplot ( log(Predator.mass), log(Prey.mass), data = MyDF, geom = "point")

#smooth
qplot(log(Predator.mass), log(Prey.mass), data = MyDF, geom = "smooth")
qplot(log(Predator.mass), log(Prey.mass), data = MyDF, geom = "smooth", method = "lm")