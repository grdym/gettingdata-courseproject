#### Course Project for Getting and Cleaning Data course ####

# Load features
dir <- getwd()
setwd("UCI HAR Dataset")
features <- read.table("features.txt", header=F)

# Load test data
setwd("test")
subject_test <- read.table("subject_test.txt", header=T)
x_test <- read.table("X_test.txt", header=T, col.names=features[,2])
y_test <- read.table("Y_test.txt", header=T)

# Merge labels and test data
test <- cbind(subject_test, y_test, x_test)

# Load train data
setwd("..")
setwd("train")
subject_train <- read.table("subject_train.txt", header=T)
x_train <- read.table("X_train.txt", header=T, col.names=features[,2])
y_train <- read.table("Y_train.txt", header=T)

#Return to main working directory
setwd(dir)

# Merge labels and train data
train <- cbind(subject_train, y_train, x_train)

# Combine train and test sets
colnames(train)[1] <- "X2"
combined <- rbind(test, train)
library("dplyr")
combined <- arrange(combined, X2, X5)
colnames(combined)[1] <- "subject"
colnames(combined)[2] <- "activity"

# Select columns with mean  and standard deviation data
mean <- combined[,grep("mean", colnames(combined), ignore.case = T), ]
std <- combined[,grep("std", colnames(combined), ignore.case = T), ]
meanstd <- cbind(combined[,1:2], mean, std)

# Change activity labels to descriptive
meanstd$activity[meanstd$activity == 1] <- "Walking"
meanstd$activity[meanstd$activity == 2] <- "WalkingUpstairs"
meanstd$activity[meanstd$activity == 3] <- "WalkingDownstairs"
meanstd$activity[meanstd$activity == 4] <- "Sitting"
meanstd$activity[meanstd$activity == 5] <- "Standing"
meanstd$activity[meanstd$activity == 6] <- "Laying"

# Make variable names more descriptive
variables <- gsub("tBody", "TimeBody", variable_names, ignore.case = TRUE, perl = FALSE, fixed = FALSE, useBytes = FALSE)
variables <- gsub("...", "-", variables, ignore.case = TRUE, perl = FALSE, fixed = TRUE, useBytes = FALSE)
variables <- gsub("..", "", variables, ignore.case = TRUE, perl = FALSE, fixed = TRUE, useBytes = FALSE)
variables <- gsub("fBody", "FreqBody", variables, ignore.case = TRUE, perl = FALSE, fixed = FALSE, useBytes = FALSE)
variables <- gsub("fGravity", "FreqGravity", variables, ignore.case = TRUE, perl = FALSE, fixed = FALSE, useBytes = FALSE)
variables <- gsub("tGravity", "TimeGravity", variables, ignore.case = TRUE, perl = FALSE, fixed = FALSE, useBytes = FALSE)
variables <- gsub("BodyBody", "Body", variables, ignore.case = TRUE, perl = FALSE, fixed = FALSE, useBytes = FALSE)
variables <- gsub(".mean", "Mean", variables, ignore.case = TRUE, perl = FALSE, fixed = TRUE, useBytes = FALSE)
variables <- gsub("angle.", "Angle-", variables, ignore.case = TRUE, perl = FALSE, fixed = TRUE, useBytes = FALSE)
variables <- gsub(".std", "Std", variables, ignore.case = TRUE, perl = FALSE, fixed = TRUE, useBytes = FALSE)
variables <- gsub(".gravityMean.", "GravityMean", variables, ignore.case = FALSE, perl = FALSE, fixed = TRUE, useBytes = FALSE)
variables <- gsub(".gravity.", "Gravity", variables, ignore.case = FALSE, perl = FALSE, fixed = TRUE, useBytes = FALSE)

# Update variable names in the data frame
names(meanstd) <- variables

# Calculate average for each  subject and each activity
group <- group_by(meanstd, subject, activity, add=T)
average_data <- summarise_each(group, funs(mean))
write.table(average_data, file="dataset.txt", row.name=FALSE)