##CodeBook For run_analysis.R

by R Bagnall
April 26 2015
 
##Overview

The provided R script, named run_analysis.R, produces a tidy data set from the 'Human Activity Recognition Using Smartphones Dataset' available at [https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip].
 
###Collection of the raw data

Thirty volunteers performed six activities wearing a Samsung Galaxy S II smartphone on the waist and the embedded accelerometer and gyroscope recorded measures of body movement. Multiple recordings for each person and measure were divided into test and training data sets. The raw dataset is available at [https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip].
 
##Creating the tidy datafile
 
###Guide to create the tidy data file

To execute, copy run_analysis.R script into the working directory of R and enter the following code in the R console (or RStudio console):

<!--
 source(“run_analysis.R”)
 -->


If the UCI HAR directory is not in the working directory, the script will exit with an error message.

 
###Creating Tidy Data

Initially, an activity and subject column is added to the test and tidy data set. The test and tidy data set are merged together using a row bind. Descriptive labels, conforming to the principals of tidy data, are added to each column. The average value of each subject for each activity is calculated and a tidy data frame in long form is created. 
 
##TidyData.txt description

The TidyData.txt file has:
 - Dimensions of 15480 rows and 4 columns
 - Four variables
 
##Variables

There are four variables

#Variable 1: activity

The activity performed while measurements were recorded

 - class = factor
 - six levels

laying
sitting
standing
walking
walkingdownstairs
walkingupstairs

 
#Variable 2: subject

Subjects who performed the activity. Each subject is assigned a unique integer from 1 to 30.
 
 - class = int
 - thirty values
 - 1:30

#Variable 3: feature

 - class = factor
 - 86 levels
- feature names are composite values of the following:

angle: angle between vectors
freq: frequency
body: body linear acceleration
time: time
gyro: gyroscopic
acc: acceleration
mean: mean value
std: standard deviation
jerk: jerk signal
gravity: gravity acceleration signal
mag: magnitude
x: gyroscopic x axial raw signal
y: gyroscopic y axial raw signal
z: gyroscopic z axial raw signal

 - features

angletimebodyaccjerkmeangravitymean
angletimebodyaccmeangravity
angletimebodygyrojerkmeangravitymean
angletimebodygyromeangravitymean
anglexgravitymean
angleygravitymean
anglezgravitymean
freqbodyaccjerkmagmean
freqbodyaccjerkmagmeanfreq
freqbodyaccjerkmagstd
freqbodyaccjerkmeanfreqx
freqbodyaccjerkmeanfreqy
freqbodyaccjerkmeanfreqz
freqbodyaccjerkmeanx
freqbodyaccjerkmeany
freqbodyaccjerkmeanz
freqbodyaccjerkstdx
freqbodyaccjerkstdy
freqbodyaccjerkstdz
freqbodyaccmagmean
freqbodyaccmagmeanfreq
freqbodyaccmagstd
freqbodyaccmeanfreqx
freqbodyaccmeanfreqy
freqbodyaccmeanfreqz
freqbodyaccmeanx
freqbodyaccmeany
freqbodyaccmeanz
freqbodyaccstdx
freqbodyaccstdy
freqbodyaccstdz
freqbodygyrojerkmagmean
freqbodygyrojerkmagmeanfreq
freqbodygyrojerkmagstd
freqbodygyromagmean
freqbodygyromagmeanfreq
freqbodygyromagstd
freqbodygyromeanfreqx
freqbodygyromeanfreqy
freqbodygyromeanfreqz
freqbodygyromeanx
freqbodygyromeany
freqbodygyromeanz
freqbodygyrostdx
freqbodygyrostdy
freqbodygyrostdz
timebodyaccjerkmagmean
timebodyaccjerkmagstd
timebodyaccjerkmeanx
timebodyaccjerkmeany
timebodyaccjerkmeanz
timebodyaccjerkstdx
timebodyaccjerkstdy
timebodyaccjerkstdz
timebodyaccmagmean
timebodyaccmagstd
timebodyaccmeanx
timebodyaccmeany
timebodyaccmeanz
timebodyaccstdx
timebodyaccstdy
timebodyaccstdz
timebodygyrojerkmagmean
timebodygyrojerkmagstd
timebodygyrojerkmeanx
timebodygyrojerkmeany
timebodygyrojerkmeanz
timebodygyrojerkstdx
timebodygyrojerkstdy
timebodygyrojerkstdz
timebodygyromagmean
timebodygyromagstd
timebodygyromeanx
timebodygyromeany
timebodygyromeanz
timebodygyrostdx
timebodygyrostdy
timebodygyrostdz
timegravityaccmagmean
timegravityaccmagstd
timegravityaccmeanx
timegravityaccmeany
timegravityaccmeanz
timegravityaccstdx
timegravityaccstdy
timegravityaccstdz



#Variable 4: averagevalue

Average value of each feature per person, per activity.

 - class = numeric