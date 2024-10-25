##Reads a CSV file into a dataframe and converts it into a matrix.

MyData <- as.matrix(read.csv("../data/PoundHillData.csv",header = FALSE))
class(MyData)

MyMetaData <- read.csv("../data/PoundHillMetaData.csv", header = TRUE, sep=";")
class(MyMetaData)


MyMetaData

head(MyMetaData)
