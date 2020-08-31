#---------------- Read data into dataframe

#Method 1
stats <- read.csv(file.choose())
stats

#Method 2
getwd()
setwd("C:\\Manthan\\Courses\\R_Programming_A-Z\\Section_05_Data_Frames") #Windows
rm(stats)
stats <- read.csv("P2-Demographic-Data.csv",stringsAsFactors = TRUE)
stats

#------------------- Exploring data
nrow(stats)
ncol(stats)
head(stats)
tail(stats,n=3)
str(stats)
summary(stats)



#--------------- Using the $ sign
stats[3,3]
stats[3,"Birth.rate"]
stats$Internet.users #Identical to: stats[,"Internet.users"]
stats$Internet.users[2]
levels(stats$Income.Group)



#---------------- Basic Operations with a dataframe
stats[1:10,] #this is subsetting
stats[c(1,4),]
stats[1,]
is.data.frame(stats[1,]) #no need for drop = FALSE like in the case of matrices
stats[,1]
is.data.frame(stats[,1]) #drop = FALSE is required when working with columns.
#multiply/add/sub/divide columns
stats$Birth.rate * stats$Internet.users
#add column to dataframe
stats$mycalc <- stats$Birth.rate * stats$Internet.users
str(stats)
stats$xyz = 1:5
stats
# remove a column from dataframe
stats$mycalc <- NULL
stats$xyz <- NULL
stats
str(stats)

#Filtering Dataframes
head(stats)
filter <- stats$Internet.users < 2
stats[filter,]
stats[stats$Birth.rate > 40 & filter ,]
levels(stats$Income.Group)
stats[stats$Country.Name == "Malta",]


#-------------- Qplot

?qplot()
library(ggplot2)
?qplot()
qplot(data=stats,x = Internet.users)

qplot(data=stats,x = Income.Group,y=Birth.rate,size=I(1),
      colour = I("blue"))

qplot(data=stats,x = Income.Group,y=Birth.rate,
      colour = I("blue"), geom = "boxplot")


#--------------------- Visualizing dataframes
qplot(data = stats, x= Internet.users,y=Birth.rate,size=I(4),
      colour= Income.Group)


#------------------Creating new data
#Run the CountryRegionVectors.R file to get the vectors

mydf <- data.frame(Countries_2012_Dataset,Codes_2012_Dataset,
                   Regions_2012_Dataset)
head(mydf)
colnames(mydf)
colnames(mydf) <- c("Country","Codes","Regions")

mydf <- data.frame(Country=Countries_2012_Dataset,
                   Code = Codes_2012_Dataset,
                   Region = Regions_2012_Dataset,stringsAsFactors = TRUE)
#This approach of assigning names of columns works even with cbind and rbind functions
head(mydf)


#-------------- Merging Dataframes
head(stats)
head(mydf)
str(stats)
str(mydf)

merged_df <- merge(stats,mydf,by.x = "Country.Code", by.y = "Code")
head(merged_df)
str(merged_df)
merged_df$Country <- NULL


#-------------- Visualizing the new dataframe (as per the challenge)
qplot(data = merged_df, x= Internet.users,y=Birth.rate,size=I(5),
      colour= Region)
#shape
qplot(data = merged_df, x= Internet.users,y=Birth.rate,size=I(5),
      colour= Region,shape = I(19))
#transparency
qplot(data = merged_df, x= Internet.users,y=Birth.rate,size=I(5),
      colour= Region,shape = I(19), alpha = I(0.6))
#title
qplot(data = merged_df, x= Internet.users,y=Birth.rate,size=I(5),
      colour= Region,shape = I(19), alpha = I(0.6),
      main= "Birth Rate (vs) Internet Users")




