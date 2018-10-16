# CODE BOOK


Summary of the resulting data fields created in `tidydata.txt`

## DATA

The data was acquired from the data link provided:  https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip



## Download data

...
if (!file.exists(filename)){   
+     fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip " 
+     download.file(fileURL, filename, method="curl")
+ }
...



