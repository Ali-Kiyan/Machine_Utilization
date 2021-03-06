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
RL1 <- util[util$Machine=="RL1",]
summary(RL1)
RL1$Machine <- factor(RL1$Machine)
#Construct List 
util_stats_rl1 <- c(min(RL1$Utilization, na.rm=T),
                    mean(RL1$Utilization, na.rm=T),
                    max(RL1$Utilization, na.rm=T))
util_stats_rl1
#which give use the TRUE's and ignores NA's !
length(which(RL1$Utilization < 0.90)) > 0
#another alt
util_under_90_flag <- as.logical(length(which(RL1$Utilization < 0.90)))
util_under_90_flag
list_rl1 <- list("RL1",util_stats_rl1,util_under_90_flag)
#Naming Components of a list
list_rl1
names(list_rl1)
names(list_rl1) <- c("Mahcine", "Stats", "LowThreshhold")
#alternative way 
rm(list_rl1)
list_rl1 <- list(Machine="RL1", Stats=util_stats_rl1, LowThreshold=util_under_90_flag)
#Extracting components of a list 
#Three ways 
#[]
#[[]] - will always return the actual object
#$ - same as [[]] but prettier 
list_rl1
#returns vector
list_rl1[1]
#returns list
list_rl1[[1]]
list_rl1$Machine

list_rl1[2]
typeof(list_rl1[2])
typeof(list_rl1[[2]])
typeof(list_rl1$Stats)
list_rl1$Stats[3]
#Adding and deleting list component
list_rl1[6] <- "New Information"
# via $
#a all hours where Utilization is unkwnown
list_rl1$UnknownHours <- RL1[is.na(RL1$Utilization),"PosixTime"]
#remove a component
list_rl1[5] <- NULL
#Note that nomeration is changed here
list_rl1[4]
#Data frame: For this machine
list_rl1$Data <- RL1
summary(list_rl1)
#In R everything is a vector 
str(list_rl1) 
#Subsetting a list 
list_rl1[1:3]
list_rl1[c(1,4)]
sublist_rl1 <- list_rl1[c("Machine","Stats")]
library("ggplot2")
p <- ggplot(data=util)
p + geom_line(aes(x=PosixTime, y=Utilization,colour=Machine), size=1.2) +
facet_grid(Machine~.) + 
