# CODE BOOK


Summary of the resulting data fields created in `tidydata.txt`

## DATA

The data was acquired from the data link provided:  https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip



## Download data

...

if (!file.exists(filename)){   
fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip " 
download.file(fileURL, filename, method="curl")
}
if (!file.exists(filename)){
fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip "
download.file(fileURL, filename, method="curl")
}

...

## Getting Activities & Labes wanted

...

* activityLabels <- read.table("UCI HAR Dataset/activity_labels.txt")
* activityLabels[,2] <- as.character(activityLabels[,2])
* features <- read.table("UCI HAR Dataset/features.txt")
* features[,2] <- as.character(features[,2])
* featuresWanted <- grep(".*mean.*|.*std.*", features[,2])
* featuresWanted.names <- features[featuresWanted,2]
* featuresWanted.names = gsub('-mean', 'Mean', featuresWanted.names)
* featuresWanted.names = gsub('-std', 'Std', featuresWanted.names)
* featuresWanted.names <- gsub('[-()]', '', featuresWanted.names)

...

## Create resampling of data

...

* train <- read.table("UCI HAR Dataset/train/X_train.txt")[featuresWanted]
* trainActivities <- read.table("UCI HAR Dataset/train/Y_train.txt")
* trainSubjects <- read.table("UCI HAR Dataset/train/subject_train.txt")
* train <- cbind(trainSubjects, trainActivities, train)
* test <- read.table("UCI HAR Dataset/test/X_test.txt")[featuresWanted]
* testActivities <- read.table("UCI HAR Dataset/test/Y_test.txt")
* testSubjects <- read.table("UCI HAR Dataset/test/subject_test.txt")
* test <- cbind(testSubjects, testActivities, test)
* allData <- rbind(train, test)
* colnames(allData) <- c("subject", "activity", featuresWanted.names)

...

## Build the tidydata set & write the required tidydata set

...

* allData$activity <- factor(allData$activity, levels = activityLabels[,1], labels = activityLabels[,2])
* allData$subject <- as.factor(allData$subject)
* allData.melted <- melt(allData, id = c("subject", "activity"))
* allData.mean <- dcast(allData.melted, subject + activity ~ variable, mean)
* write.table(allData.mean, "tidydata.txt", row.names = FALSE, quote = FALSE)

...

## Quantities reported in tidydata.txt

### Activity Types
  *WALKING
  *WALKING_UPSTAIRS
  *WALKING_DOWNSTAIRS
  *SITTING
  *STANDING
  *LAYING
 
 ### Subject ID 
  *factor Values 1-30
  
  ### Quantities for Mean & std dev 
  1. `tBodyAccMeanX` Average Body Acc x-axis
  2. `tBodyAccMeanY` Average Body Acc y-axis
  3. `tBodyAccMeanZ` Average Body Acc z-axis
  4. `tBodyAccStdX` Ave Std Dev Body x-axis
  5. `tBodyAccStdY` Ave Std Dev Body y-axis
  6. `tBodyAccStdZ` Ave Std Dev Body z -axis
  
  
  
