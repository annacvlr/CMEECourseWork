#script data wrangling the datasets for the Statistics in R assignment
  library(lubridate)
  library(dplyr)
  library(tidyr)


####uploading the data in read csv
girth <- read.csv("../data/AAgirth.csv") #gives girth/ circumference of monitored trees
phenology <- read.csv("../data/AAphenology.csv") # info on phenology codes for leave flushing thru spring
weather <- read.csv("../data/AASilwoodWeatherDaily.csv") #daily weather records from 9am Dec 2009 - Cambell Scientific weatgher station
trees <- read.csv("../data/AAtrees.csv") #gives species and location info of oak trees

###rename files without AA infront


#looking at the data
head(girth)
head(phenology)
head(weather)
head(trees)

####DATE
#check what kind of type are the Date columns
str(phenology$Date)
#str(weather$TIMESTAMP)

#convert date into same format
phenology$Date <- ymd(phenology$Date)
class(phenology$Date)
#weather$TIMESTAMP <- dmy_hm(weather$TIMESTAMP)

#create new column with Date in weather (no longer called TIMESTAMP)
weather$Date <- as.Date(weather$TIMESTAMP)

#both date in weather and phenology now look the same
head(weather)
head(phenology)


###DATE in girth
#convert the year ranges into the start date - put them in order 

# start year function
parse_date <- function(date_range) {
    date_range <- as.character(date_range)
  years <- strsplit(date_range, "-")[[1]]
  start_year <- as.numeric(years[1])
  return(as.Date(paste(start_year, "01", "01", sep = "-")))
}

#start year of girth
girth$DateStart <- parse_date(girth$Date)
head(girth)
#it works


#make all TreeID into integers

str(girth$TreeID)
str(phenology$TreeID)

phenology <- phenology %>%
    mutate(
        TreeID = as.character(TreeID),
        TreeID = gsub("[^0-9]", "", TreeID),
        TreeID = as.integer(TreeID)
        )


str(phenology$TreeID)

#debugging
#phenology %>% filter(!grepl("^\\d+$", as.character(TreeID)))
#phenology %>% filter(is.na(TreeID) | TreeID == "")
#phenology %>% filter(TreeID == "")

phenology <- phenology %>% 
  filter(TreeID != 0 & !is.na(TreeID))

#phenology$TreeID[is.na(phenology$TreeID) | phenology$TreeID == ""] <- 0
# Filter out rows that have any non-numeric characters remaining

####treeID NULL have been converted to 0 - take these out
#phenology <- phenology %>%
 # filter(TreeID != 0)
head(phenology)


##MERGE DATASETS
merged <- phenology %>% 
  left_join(girth, by = "TreeID") %>%
  filter(DateStart <= Date.x)
  
head(merged)

merged

merged <- merged %>%
  group_by(TreeID) %>%
  arrange(DateStart, Date.x ) %>%
  slice_max(DateStart, n = 1) %>%
  ungroup()
  

merged

summary(merged)

#### CONVERT BUDBURST score TO DUMMY VARIABLES
#merged_df <- merged_df %>%
  #mutate(Score_numeric = case_when(
    #Score %in% "2", "<2", ">2" ~ 1, ##bursting 
    #Score %in% "<3", "3", ">3", "4", "<4", ">4", "5", "<5", ">5", "<6", "6" ~ 2, ##bursted
    #Score %in% "0", "<1", ">1", "1" ~ 0, ##not bursted
    #TRUE ~ NA_real_
  #))


# Write the merged dataset to a new CSV file
write.csv(merged, file = "../data/merged.csv", row.names = FALSE)


