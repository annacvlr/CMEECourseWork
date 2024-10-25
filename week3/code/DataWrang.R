################################################################
################## Wrangling the Pound Hill Dataset ############
################################################################

############# Load the dataset ###############
# header = false because the raw data don't have real headers
MyData <- as.matrix(read.csv("../data/PoundHillData.csv", header = FALSE))

# header = true because we do have metadata headers
MyMetaData <- read.csv("../data/PoundHillMetaData.csv", header = TRUE, sep = ";")

############# Inspect the dataset ###############
head(MyData) #shows the first 6 rows
#head(MyData, 10) would show the first 10 rows

dim(MyData)
#dimension of data frame matrix - gives the numbers of rows & columns as a vector 
#45 and 60 so has 45 rows, 60 columns

str(MyData)
#structure of data - gives info on datatypes of each column, num of observ, previoew of data

fix(MyData) 
#opens a spreadsheet like editor for dataframe - allows to edit data directly --- caution as it will modify the original data frame
fix(MyMetaData)

############# Transpose ###############
# To get those species into columns and treatments into rows 
MyData <- t(MyData) 
#transposing dataframe --> switch of rows w columns 
head(MyData)
dim(MyData)
#dimensions have switched 


############# Replace species absences with zeros ###############
MyData[MyData == ""] = 0

MyMetaData #to check the metadata

############# Convert raw matrix to data frame ###############

TempData <- as.data.frame(MyData[-1,],stringsAsFactors = F) #stringsAsFactors = F is important!
# tempdata from all rows except the first - making sure all character data remians as character

colnames(TempData) <- MyData[1,] # assign column names from original data
#assigns values of first row of Mydata as column names
head(TempData)
rownames(TempData) <- NULL
#remove first column
head(TempData)
############# Convert from wide to long format  ###############
install.packages("reshape2")
require(reshape2) # load the reshape2 package

?melt #check out the melt function

MyWrangledData <- melt(TempData, id=c("Cultivation", "Block", "Plot", "Quadrat"), variable.name = "Species", value.name = "Count")
#transforms TemData from wide to long format
#melt - uses identifiers to unpivot data  (cultivation, block, plot, quadrat)
#variable name - created new columns 

MyWrangledData[, "Cultivation"] <- as.factor(MyWrangledData[, "Cultivation"])
MyWrangledData[, "Block"] <- as.factor(MyWrangledData[, "Block"])
MyWrangledData[, "Plot"] <- as.factor(MyWrangledData[, "Plot"])
MyWrangledData[, "Quadrat"] <- as.factor(MyWrangledData[, "Quadrat"])
MyWrangledData[, "Count"] <- as.integer(MyWrangledData[, "Count"])

str(MyWrangledData)
head(MyWrangledData)
dim(MyWrangledData)

############# Exploring the data (extend the script below)  ###############

require(tidyverse)
MyWrangledData <- dplyr::as_tibble(MyWrangledData) 
MyWrangledData
class(MyWrangledData)

glimpse(MyWrangledData) #like str()
filter(MyWrangledData, Count>100) #like subset()
slice(MyWrangledData, 10:15) # particular range of rows


MyWrangledData %>%
    group_by(Species) %>%
        summarise(avg = mean(Count)) %>% #bring it to the next line with pipe command
        print(n =Inf)
#pipe operator creates sequence of manipulations on each species type

aggregate(MyWrangledData$Count, list(MyWrangledData$Species), FUN=mean)
