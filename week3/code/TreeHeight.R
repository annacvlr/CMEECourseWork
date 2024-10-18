#this function calculates the heights of trees given the distance of each tree from its base and angle to its top

#height = distance * tan(radians)

#arguments
#degrees: angle of elevation of trees
#distance : the distance from base of tree (eg meters)

#OUTPUT
#the height of the tree, same units as "distance"

TreeHeight <- function(degrees, distance) {
    radians <- degrees * pi / 180
    height <- distance * tan(radians)
    print(paste("Tree height is:", height))

    return (height)
    }

TreeHeight(37,40)