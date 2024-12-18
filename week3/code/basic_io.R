##Handles and writes CSV files

MyData <- read.csv("../data/trees.csv", header = TRUE)
write.csv(MyData, "../data/MyData.csv")
write.table(MyData[1,], file ="../results/MyData.csv", append =TRUE)
write.csv (MyData, "../results/MyData.csv", row.names=TRUE) #write row names
write.table(MyData, "../results/MyData.csv", col.names= FALSE) #ignore column names