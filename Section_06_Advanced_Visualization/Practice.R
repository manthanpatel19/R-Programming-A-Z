# #--------------- Grammar of Graphics (Layers)
# 1) Data
# 2) Aesthetics
# 3) Geometries
# 4) Statistics
# 5) Facets
# 6) Coordinates
# 7) Theme

#-------------- Data Layer (Get the data)
getwd()
setwd("C:\\Manthan\\Courses\\R_Programming_A-Z\\Section_06_Advanced_Visualization") #windows
getwd()

movies <- read.csv("P2-Movie-Ratings.csv",stringsAsFactors = TRUE)
head(movies)
colnames(movies) <- c("Film","Genre","CriticRating","AudienceRating","BudgetMillions","Year")
head(movies)
tail(movies)
str(movies)
summary(movies)

movies$Year <- factor(movies$Year)   #Because Year is not actually required to be a numeric value. We need it to be a factor


#------------- Aesthetics Layer
library(ggplot2)

ggplot(data=movies, aes(x=CriticRating, y=AudienceRating))  #This is just the aesthetics. This wont plot anything. 

#add geometry (because without it the data wont be plotted)
ggplot(data=movies, aes(x=CriticRating, y=AudienceRating)) + geom_point()

#add colour aesthetic
ggplot(data=movies, aes(x=CriticRating, y=AudienceRating,colour=Genre)) + geom_point()

#add size aesthetic
ggplot(data=movies, aes(x=CriticRating, y=AudienceRating,colour=Genre,size=BudgetMillions)) + geom_point()


#-------------- Geometries Layer (plotting with layers)
p <- ggplot(data=movies, aes(x=CriticRating, y=AudienceRating,colour=Genre,size=BudgetMillions))
#This just creates an object of the aesthetics and data. We need to "Add" a geometry layer

#point
p + geom_point()

#lines
p + geom_line() #Doesnt make sense really. Just for example

#multiple layers
p + geom_point() + geom_line() #points arent visible as the line layer is on top of the point layer
p + geom_line() + geom_point()



#----------------- Overriding Aesthetics
q <-ggplot(data=movies, aes(x=CriticRating, y=AudienceRating,colour=Genre,size=BudgetMillions))

q + geom_point() #The aesthetics are inhereted from 'q'. We can override this

#overrriding aesthtics
#ex1
q + geom_point(aes(size = CriticRating))
#ex2
q + geom_point(aes(colour = BudgetMillions))
#(q remains the same! we are just overriding the aesthtics for the specific plot)
#ex3
q + geom_point(aes(x=BudgetMillions))
#NOTE: The xlabels and the legends will remain the same. To update them too, see below example
q + geom_point(aes(x=BudgetMillions)) + xlab("Budget Millions")
#ex4
q + geom_line(size=1) + geom_point() #We did not use aes(size=1) here because we did not
#"map" the size to the aesthetics. We just "set" the size to 1. More explanation below


#-------------- Mapping (vs) Setting
r <- ggplot(data=movies, aes(x=CriticRating, y=AudienceRating))
r + geom_point()

#Add Colour
#1 - By Mapping
r + geom_point(aes(colour=Genre))
#2 -By Setting
r + geom_point(colour = "darkgreen")
#ERROR
r + geom_point(aes(colour="darkgreen"))  #This is wrong!!

#Add size
#1 - By Mapping
r + geom_point(aes(size=Genre))
#2 -By Setting
r + geom_point(size = 5)
#ERROR
r + geom_point(aes(size=5))  #This is wrong!!



#------------ Histograms & Density Charts (Statistics Layer)
s <- ggplot(data=movies,aes(x=BudgetMillions))
#Histograms
s + geom_histogram(binwidth=10)

#Add colour
s + geom_histogram(binwidth=10,fill="green") #This is setting the colour (or fill)
s + geom_histogram(binwidth=10,aes(fill=Genre))
#Add border
s + geom_histogram(binwidth=10,aes(fill=Genre),colour="black")

#Density
s + geom_density(aes(fill=Genre))
s + geom_density(aes(fill=Genre),position="stack")


#--------------- Starting Layer Tips
t <- ggplot(data=movies,aes(x=AudienceRating))
t + geom_histogram(binwidth=10,fill="white",colour="blue")

#another way to achieve the same
t <- ggplot(data=movies)
t + geom_histogram(aes(x=AudienceRating),binwidth=10,fill="white",colour="blue")
#Avoid overriding all the time! 
#sometimes we also create a skeleton plot like this:
t <- ggplot() #Add the data later


#----------- Statistical Layer (Transformations)
u <- ggplot(data=movies,aes(x=CriticRating,y=AudienceRating,colour=Genre))

u + geom_point() + geom_smooth(fill=NA)

#boxplots
u <- ggplot(data=movies,aes(x=Genre,y=CriticRating,colour=Genre))

u + geom_boxplot()
u + geom_boxplot(size=1.2)
u + geom_boxplot(size=1.2) + geom_point()
#tip
u + geom_boxplot(size=1.2) + geom_jitter() #instead of point use jitter (better for visualizing the amount of data present)
u + geom_jitter() + geom_boxplot(size=1.2,alpha=0.5)



#------------ Using Facets (Facets Layer)
v <- ggplot(data=movies,aes(x=BudgetMillions))
v + geom_histogram(binwidth=10,aes(fill=Genre),colour="black")

#facets
v + geom_histogram(binwidth=10,aes(fill=Genre),colour="black") + facet_grid(Genre~.,scales="free")

#facets with scatterplots
w <- ggplot(data=movies,aes(x=CriticRating,y=AudienceRating,colour=Genre))
w + geom_point(size=3) + facet_grid(Genre~.)
w + geom_point(size=3) + facet_grid(.~Year)
w + geom_point(size=3) + facet_grid(Genre~Year)

w + geom_point(size=3) + facet_grid(Genre~Year) + geom_smooth()

w + geom_point(aes(size=BudgetMillions)) + facet_grid(Genre~Year) + geom_smooth()


#------------ Geometries Layer
m <- ggplot(data=movies,aes(x=CriticRating,y=AudienceRating,size=BudgetMillions,colour=Genre))

m + geom_point()
#now add limits
m + geom_point() + xlim(50,100) + ylim(50,100)

#this wont work well always. why?
n <- ggplot(data=movies,aes(x=BudgetMillions))
n + geom_histogram(binwidth=10,aes(fill=Genre),colour="black") + ylim(50,100)
n + geom_histogram(binwidth=10,aes(fill=Genre),colour="black") + ylim(0,50) #This does not "zoom in" but cuts out the data

n + geom_histogram(binwidth=10,aes(fill=Genre),colour="black") + coord_cartesian(ylim=c(0,50))



#--------------- Theme Layer 
o <- ggplot(data=movies,aes(x=BudgetMillions))
h <- o + geom_histogram(binwidth=10,aes(fill=Genre),colour="black")

#Add axis label
h + xlab("Money Axis") + ylab("Number of Movies")

#Add label formatting
h + xlab("Money Axis") + ylab("Number of Movies") +
  theme(axis.title.x = element_text(colour = "darkgreen", size =20),
        axis.title.y = element_text(colour = "red", size =20))

#Add tickmark formatting
h + xlab("Money Axis") + ylab("Number of Movies") +
  theme(axis.title.x = element_text(colour = "darkgreen", size =20),
        axis.title.y = element_text(colour = "red", size =20),
        axis.text.x = element_text(size =15),
        axis.text.y = element_text(size =15))

#Note: use the help for ?theme to get all the theme formatting that can be done
?theme

#Legend formatting
h + xlab("Money Axis") + ylab("Number of Movies") +
  theme(axis.title.x = element_text(colour = "darkgreen", size =20),
        axis.title.y = element_text(colour = "red", size =20),
        axis.text.x = element_text(size =15),
        axis.text.y = element_text(size =15),
        legend.title = element_text(size=20),
        legend.text = element_text(size=15),
        legend.position = c(1,1),
        legend.justification = c(1,1))

#Add title of plot
h + xlab("Money Axis") + ylab("Number of Movies") +
  ggtitle("Movie Budget Distribution") +
  theme(axis.title.x = element_text(colour = "darkgreen", size =20),
        axis.title.y = element_text(colour = "red", size =20),
        axis.text.x = element_text(size =15),
        axis.text.y = element_text(size =15),
        legend.title = element_text(size=20),
        legend.text = element_text(size=15),
        legend.position = c(1,1),
        legend.justification = c(1,1),
        plot.title = element_text(colour="darkblue",size=30,family="Courier New"))


















