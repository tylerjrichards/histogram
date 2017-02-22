#here is the data we're going to use
#http://bit.ly/2lq7WN0
#if you haven't run install.packages('ggplot2')

#first step is always to upload the data
library(ggplot2)
setwd("~/Downloads")
landdata <- read.csv("landdata-states.csv")


#now we want to look at the data itself
head(landdata)

#why ggplot2?
#we need to check base R vs ggplot2 to see why 
#let's do it via histogram

hist(landdata$Home.Value)

ggplot(landdata, aes(x = Home.Value)) +
  geom_histogram()

#which is better? It is not even close

#the qplot function is extremely useful when dealing with data, especially for correlations
qplot(landdata$Home.Value, landdata$Land.Value)
qplot(landdata$Home.Value, landdata$Home.Price.Index)

#this also works with functions
qplot(landdata$Home.Value, log(landdata$Land.Value))

#the most powerful tool in ggplot2 is the function ggplot
?ggplot

#ggplot takes a few different arguments
ggplot(subset(landdata, State %in% c("FL", "MO")),
       aes(x=Date,
           y=Home.Value,
           color=State))+
  geom_point()

#points are geom_point
#lines are geom_line 
#boxplot are geom_boxplot 

#manually changing colors
ggplot(subset(landdata, State %in% c("FL", "MO")),
       aes(x=Date,
           y=Home.Value,
           color=State))+
  scale_colour_brewer(type = "seq", palette = "Oranges") +
  geom_point()


#mapping linear models
Year2001 <- subset(landdata, Date == 2001.25) 
Year2001$Prediction <- predict(lm(Structure.Cost ~ log(Land.Value), data = Year2001))

p1 <- ggplot(Year2001, aes(x = log(Land.Value), y = Structure.Cost))

p1 + geom_point(aes(color = Home.Value)) +
  geom_line(aes(y = Prediction))

#smoothing out graphs
p1 +
  geom_point(aes(color = Home.Value)) +
  geom_smooth()

#different shapes
p1 +
  geom_point(aes(color=Home.Value, shape = region))


