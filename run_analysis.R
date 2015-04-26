#!/usr/bin/Rscript
# r script to produce a tidy data set of data collected from the accelerometers from the Samsung Galaxy S smartphone
# raw data files are available for download at https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
# compiled by rbagnall for the 'Getting and Cleaning Data' module of the Coursera Data Science course
# 2015-April-26

# required libraries are dplyr and reshape2
library(dplyr)
library(reshape2)

# check to see if raw data exists in the current working directory and if not, exit with a comment
if(!file.exists("UCI\ HAR\ Dataset")){
      stop("The UCI HAR Dataset directory must be present in your working directory", call. =FALSE)      
}

# read training data sets
training <- read.table("UCI\ HAR\ Dataset/train/X_train.txt", header=FALSE)
trainingActivity <- read.table("UCI\ HAR\ Dataset/train/y_train.txt", header=FALSE)
trainingSubject <- read.table("UCI\ HAR\ Dataset/train/subject_train.txt", header=FALSE)

# read test data sets
test <- read.table("UCI\ HAR\ Dataset/test/X_test.txt", header=FALSE)
testActivity <- read.table("UCI\ HAR\ Dataset/test/y_test.txt", header=FALSE)
testSubject <- read.table("UCI\ HAR\ Dataset/test/subject_test.txt", header=FALSE)

# column bind the test/training activity and subject columns to the test/training data frames
trainActSubjDF <- cbind(trainingActivity, trainingSubject, training)
testActSubjDF <- cbind(testActivity, testSubject, test)

# row bind test and training data frames
mergedDF <- rbind(testActSubjDF, trainActSubjDF)

# add column headers (i.e. features)
features <- read.table("UCI\ HAR\ Dataset/features.txt", header=FALSE)

# make vector of column headers; remember to include "activity" and "subject"
columnHeaders <- c("activity", "subject", as.character(features[,2]))

# add column headers to mergedDF
names(mergedDF) <- columnHeaders

# subset mergedDF in to columns with [Mm]ean or std in the header, using grep
# also include the activity and subject columns
greppedNames <- grep("std|[Mm]ean|activity|subject", names(mergedDF), value=TRUE)
selectedDF <- mergedDF[,greppedNames] 

# tidy up column names and change to lower case
names(selectedDF) <- gsub("\\(|\\)|-|,", "", names(selectedDF))
names(selectedDF) <- gsub("BodyBody", "body", names(selectedDF))
names(selectedDF) <- gsub("^t", "time", names(selectedDF), perl=TRUE)
names(selectedDF) <- gsub("^f", "freq", names(selectedDF), perl=TRUE)
names(selectedDF) <- tolower(names(selectedDF))

# replace activity numbers with lower case activity labels
activityLabels <- read.table("UCI\ HAR\ Dataset/activity_labels.txt", header=FALSE)
activityLabels <- as.data.frame(sapply(activityLabels, tolower))
activityLabels[,-1] <-gsub("_", "", as.matrix(activityLabels[,-1]))
names(activityLabels) <- c("activitylabel", "activity")
labelledDF <- merge(activityLabels, selectedDF, by.x="activitylabel", by.y="activity", sort=FALSE)

# use dplyr to get mean of each variable, subsetted by subject and activity (i.e. wide data)
summarised <- labelledDF %>% group_by(subject,activity) %>% summarise_each(funs(mean))

# get rid of redundant numeric activity label column
wideDF <- select(summarised, -activitylabel)

# melt into long data form and rename column headers
tidyDF <- melt(wideDF, id.vars=c("activity", "subject"))
names(tidyDF) <- c("activity", "subject", "feature", "averagevalue")

# write data set to TidyDataFrame.txt file in the current working directory
write.table(tidyDF, "TidyDataFrame.txt", row.name=FALSE, sep="\t")
