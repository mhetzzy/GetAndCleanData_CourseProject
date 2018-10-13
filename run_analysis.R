##Downloand & unzip data
> if(!file.exists("./data")){dir.create("./data")}
> fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
> unzip(zipfile="./data/Dataset.zip",exdir="./data")
> filename <- "getdata_dataset.zip"
> if (!file.exists(filename)){
+     
+     fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip "
+     
+     download.file(fileURL, filename, method="curl")
+ }
 if (!file.exists("UCI HAR Dataset")) { 
+     
+     unzip(filename) 
}
##Load activity labels and features
> activityLabels <- read.table("UCI HAR Dataset/activity_labels.txt")
> activityLabels[,2] <- as.character(activityLabels[,2])
> features <- read.table("UCI HAR Dataset/features.txt")
> features[,2] <- as.character(features[,2])
## Get data on mean & std deviation
> featuresWanted <- grep(".*mean.*|.*std.*", features[,2])
> featuresWanted.names <- features[featuresWanted,2]
> featuresWanted.names = gsub('-mean', 'Mean', featuresWanted.names)
> featuresWanted.names = gsub('-std', 'Std', featuresWanted.names)
> featuresWanted.names <- gsub('[-()]', '', featuresWanted.names)
##Load datasets
> train <- read.table("UCI HAR Dataset/train/X_train.txt")[featuresWanted]
> trainActivities <- read.table("UCI HAR Dataset/train/Y_train.txt")
> trainSubjects <- read.table("UCI HAR Dataset/train/subject_train.txt")
> train <- cbind(trainSubjects, trainActivities, train)
test <- read.table("UCI HAR Dataset/test/X_test.txt")[featuresWanted]
##Merge datasets & add lables
> allData <- rbind(train, test)
> colnames(allData) <- c("subject", "activity", featuresWanted.names)
##activities & subjects into factors
> allData$activity <- factor(allData$activity, levels = activityLabels[,1], labels = activityLabels[,2])
> allData$subject <- as.factor(allData$subject)
> allData.melted <- melt(allData, id = c("subject", "activity"))
> allData.mean <- dcast(allData.melted, subject + activity ~ variable, mean)
## Write TidyData set
> write.table(allData.mean, "tidydata.txt", row.names = FALSE, quote = FALSE)
