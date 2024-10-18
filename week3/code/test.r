a <- 4
a

a*a

a_squared <- a*a
sqrt(a_squared)

v <- c(0,1,2,3,4)
v

is.vector(v) #check whetehr its a vector
mean(v)

var(v)
median(v)
sum(v)
prod(v+1)
length(v)


wing.width.cm <- 1.2
wing.length.cm <- c(4.7, 5.2, 4.8)
wing. #then hit tab -- reveals all variables in category

x <- (1 + (2*3)) # when parenthesis arent closed a + apperas

li = list(c(1,2,3))
class(li)
li[[1]]
li[1]

v <- TRUE
v

class(v)
v <- 3.2
class(v)
v <- 2L
class(v)
v <- "string"
class (v)
b <- NA
class(b)

is.na(b)
b <- 0/0
b

is.nan(b)
b <- 5/0
b

is.nan(b)

is.infinite(b)
is.finite(b)
is.finite(0/0)

as.integer(3.1)
as.numeric(4)
as.roman(155)
as.character(155)
as.logical(5)
as.logical(0)

1E4
1e4
5e-2
1E4^2
1/3/1e8


a <- 5
is.vector(a)

v1 <- c(0.02, 0.5, 1)
v2 <- c("a", "bc", "def","ghij")
v3 <- c(T, T, F) # you can abbreviate True w T, False w F
v1;v2;v3

v1 <- c(0.02, T, 1)
v1
#True gets converted to 1

v1 <- c(0.02, "Mary", 1)
v1

v2 <- character(3)
v2
v3 <- numeric(3)
v3


##matrices and arrays 

mat1 <- matrix(1:25,5,5)
mat1
print(mat1)

mat1<- matrix(1:25, 5, 5, byrow=TRUE) # order matrix by row
mat1 


dim(mat1) ##dimension of row x column

arr1 <- array(1:50, c(5,5,2))
arr1[,,1]

print(arr1)

arr1[,,2]

mat1[1,1] <- "one"
mat1 #became a str matrix (chr)


MyList <- list(species=c("Quercus robur", "Fraxinus excelsior"), age=c(123,84))
MyList

MyList[[1]]
MyList[1]
MyList[[1]][1]

MyList$species
MyList[["species"]]

MyList$species[1]

pop1 <- list (species="Cancer magister", 
            latitude=48.3, longitude=-123.1,
            startyr=1980, endyr=1985, 
            pop=c(303,402,101,607,802,35))
pop1

pop1<- list(lat=19, long=57,
            pop=c(100,101,99))
pop2<- list(lat=56, long=-120,
            pop=c(1,4,7,7,2,1,2))
pop3<- list(lat=32, long=-10,
            pop=c(12,11,2,1,14))
pops<- list(sp1=pop1, sp2=pop2, sp3=pop3)
pops

pops$sp1
pops$sp1["pop"] #sp1 popu size

pops[[2]]$lat

pops[[3]]$pop[3]<-102
pops

Col1 <-1:10 #numbers from 1 to 10
Col1

Col2 <- LETTERS[1:10] # letters from 1 to 10
Col2

Col3 <- runif(10) # 10 ranfom rumbers of Uniform Distribution
Col3

MyDF<- data.frame(Col1,Col2,Col3)
MyDF
print(MyDF)

names(MyDF) <- c("MyFirstColumn", "MySecondColumn", "MyThirdColumn")
MyDF

MyDF$MySecondColumn

colnames(MyDF)[2] <-" MySecond_Column"
MyDF

MyDF$MyThirdColumn
MyDF[,1] # all rows, only first column

MyDF[1,1]
MyDF[1,]

MyDF[c("MyFirstColumn","MyThirdColumn")]
#show only these two columns

class(MyDF)
str(MyDF)

head(MyDF)
tail(MyDF)


MyMat =matrix(1:8,4,4)
MyMat

MyDF=as.data.frame(MyMat)
MyDF

object.size(MyMat)
object.size(MyDF)

years <- 1990:2009
years

years <- 2009:1990
years
#you can also write it in reverse order

seq(1,10,0.5)

?seq

seq(from=1, to=10, by=0.5)
seq(from=1, by=0.5, to=10)
#argument matching - makes R accessible 

#simple vector
MyVar <- c('a','b','c','d','e')
MyVar[1]
# ^^ asks for 1st position -( in python 1st indice is 0)
MyVar[2]
MyVar[4]
# ^^ asks for 4th position

MyVar[c(3,2,1)
# indices but in reverse order

MyVar[c(1,1,5,5)]
# indices are repeated - terminal output repeats duplicates

v <-c(0,1,2,3,4)
#^ create a vector
v[3]

v[1:3]
#^access 0,1,2 sequential elements

v[c(1,4)]
#^ access non sequential indices

v[-3]
#^ remove the third position (2)

##matrix
mat1 <- matrix(1:25, 5, 5, byrow=T)
mat1

mat1[1,2]
#^for matrices you use [row,column]

mat1[1,2:4]
#^ row 1, columns from 2 to 4

mat1[1:2,2:4]
#creates a new matrix

mat1[1,]
# first row all columns

mat1[,1]
#first column all rows

a <- c(1,5)+2
a

x <- c(1,2); y <- c(5,3,9,2)
x;y

x + c(y,1)


v <- c(0, 1, 2, 3, 4)
v2 <- v*2
v2

v*v2

t(v)
#transpose the vector

v %*% t(v)
#matrix/vector product

v3 <- 1:7
v3

v4 <- c(v2, v3)
v4

species.name <- "Quercus robur" 
species.name

paste("Quercus", "robur")
paste("Quercus","robur", sep=" ")
paste("Quercus", "robur", sep= ",")

paste('Year is:', 1990:2000)

set.seed(1234567)
rnorm(1)

rnorm(10)

set.seed(1234567)
rnorm(11)


getwd()

MyData <- read.csv("week3/data/trees.csv")
ls(pattern = "My*")
# checking if data appears

class(MyData)
head(MyData)

str(MyData)
MyData <- read.csv("week3/data/trees.csv", header = F) 
head(MyData)


MyData <- read.table("week3/data/trees.csv", sep = ',', header = TRUE)
head(MyData)

MyData <- read.table("week3/data/trees.csv", skip = 5)
head(MyData)

write.csv(MyData, "week3/results/MyData.csv")
dir("week3/results/")
write.table(MyData[1,], file = "week3/results/MyData.csv",append=TRUE)

write.csv(MyData, "week3/results/MyData.csv", row.names=TRUE) 
write.table(MyData, "week3/results/MyData.csv", col.names=FALSE) # ignore col names

MyData <- read.csv("../data/trees.csv", skip = 5) # skip first 5 lines

