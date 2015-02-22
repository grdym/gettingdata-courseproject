Course Project for Getting and Cleaning Data course on Coursera

This project was done based on data from Human Activity Recognition Using Smartphones Dataset created by Jorge L. Reyes-Ortiz, Davide Anguita, Alessandro Ghio, Luca Oneto.
Smartlab - Non Linear Complex Systems Laboratory
DITEN - Universit‡ degli Studi di Genova.
Via Opera Pia 11A, I-16145, Genoa, Italy.
activityrecognition@smartlab.ws
www.smartlab.ws

run_analysis.R file contains the script to do the following:

1. First, training and test sets from the original data set were merged to crteate single data set.
I loaded features into R, as well as activity labels, subjects and training and test sets, then I added the feature list as column names to test and training sets. After that I added corresponding lists of subjects and activities to test and training sets. After that I added test set to training set using rbind(), thus creating the wide version of the wide form of the data set. I then renamed first two variables to "subject" and "activity" and arranged the set by subject and activity for convenience.

2. Then from this big data set all data relating to mean and standard deviation for each measurement was extracted. This was based on the marking of the variables in the original data set. All variables that had "mean" or "std" were used here as they all are related to either mean or standard deviation data.
I used grep to extract columns featuring mean and standard deviation and then combined everything into one set again using cbind().

3. Descriptive names for activities were added replacing numbers from 1-6 with words describing activities (Walking, Walking upstairs, Walking downstairs, Sitting, Standing, Laying).

4. All labels were updated to get rid of characters not recognized by R and eliminating some errors found in the original data set feature names.
Using gsub() I cleaned all variable names so that they were more.

5. Second data set was created based on the data set created in step 4, the new data set features average of each variable for each activity and each subject.
I used group_by() to group the data set by subject and activity and then used summarise to get the average of each variable for each activity and each subject. After that I created a txt file containing tidy data created in step 5.