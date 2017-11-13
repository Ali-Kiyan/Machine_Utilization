#Deliverable - a list with the following components:
#Character: machine name 
#Vector: (min, mean, max) Utilization for the month (excluding unknown hours)
#Logical: Has utilization ever fallen below 90% ? TRUE / FALSE
#Vector: All hours where utilization is unknown (NA's)
#Dataframe: for this machine
#Plot For all machines 
util <- read.csv("Machine-Utilization.csv")
head(util, 12)
str(util)
summary(util)
#Derive utilization
util$Utilization <- 1-util$Percent.Idle
head(util, 12)
#POSIX is a standard for everything when you are moving from one machine to the other so basically handles time in R
util$PosixTime <- as.POSIXct(util$Timestamp, format="%d/%m/%Y %H:%M") 
head(util,12)
summary(util)
#tip how to rearenge cols in a df
util$Timestamp <- NULL
head(util,12)
util <- util[,c(4,1,2,3)]
