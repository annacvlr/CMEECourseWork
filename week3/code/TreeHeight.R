#Script has a Function calculating the heights of trees given the distance of each tree from its base and angle to its top.
# It then uses this function on the trees.csv file and creates a new file with a new column on Tree Height (m)

#height = distance * tan(radians)

#arguments
#degrees: angle of elevation of trees
#distance : the distance from base of tree (eg meters)

#OUTPUT
#the height of the tree, same units as "distance"

#Function calculates the heights of trees given the distance of each tree from its base and angle to its top

TreeHeight <- function(degrees, distance) { #2 input parameters 
    radians <- degrees * pi / 180 #converts angle from degrees to radians
    height <- distance * tan(radians) #height of tree using trig
    print(paste("Tree height is:", height))

    return (height)
    }



#open csv file
Trees <- read.csv ("../data/trees.csv", header = TRUE)
head(Trees) #check data

#apply tree function to calculate tree heights for all rows and create a new column within trees called TreeHeights.m 
Trees$TreeHeight.m <- mapply(TreeHeight, Trees$Angle.degrees, Trees$Distance.m)

#writing Trees in a new file
write.csv(Trees, "../results/TreesHts.csv", row.names = FALSE)
