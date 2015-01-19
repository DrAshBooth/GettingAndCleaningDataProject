# 
# The data for this project can be found at:
# https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
#

# Merge training and the test sets to create one data set.
tempTable1 <- read.table("UCI HAR Dataset/train/X_train.txt")
tempTable2 <- read.table("UCI HAR Dataset/test/X_test.txt")
xData <- rbind(tempTable1, tempTable2)

tempTable3 <- read.table("UCI HAR Dataset/train/subject_train.txt")
tempTable4 <- read.table("UCI HAR Dataset/test/subject_test.txt")
sData <- rbind(tempTable3, tempTable4)

tempTable5 <- read.table("UCI HAR Dataset/train/y_train.txt")
tempTable6 <- read.table("UCI HAR Dataset/test/y_test.txt")
yData <- rbind(tempTable5, tempTable6)

# Clean up
remove(tempTable1,tempTable2,tempTable3,tempTable4,tempTable5,tempTable6)

# Extract the measurements on the mean and standard deviation for each measurement.
feature_names <- read.table("UCI HAR Dataset/features.txt")
means_and_sds <- grep("-mean\\(\\)|-std\\(\\)", feature_names[, 2])
xData <- xData[, means_and_sds]
names(xData) <- feature_names[means_and_sds, 2]
names(xData) <- gsub("\\(|\\)", "", names(xData))
names(xData) <- tolower(names(xData))

# Use descriptive activity names to name the activities in the data set.
aLabels <- read.table("UCI HAR Dataset/activity_labels.txt")
aLabels[, 2] = tolower(as.character(aLabels[, 2]))
yData[,1] = aLabels[yData[,1], 2]
names(yData) <- "activity"

# Label the data set with descriptive variable names.
names(sData) <- "subject"
tidied <- cbind(sData, yData, xData)
#write.table(tidied, "merged_tidy_data.txt")

# Create an independent tidy dataset with the average of each variable for each activity and each subject.
uniqueSubjects = unique(sData)[,1]
numSubjects = length(unique(sData)[,1])
numActivities = length(aLabels[,1])
numCols = dim(tidied)[2]
res = tidied[1:(numSubjects*numActivities), ]

row = 1
for (s in 1:numSubjects) {
  for (a in 1:numActivities) {
    res[row, 1] = uniqueSubjects[s]
    res[row, 2] = aLabels[a, 2]
    tmp <- tidied[tidied$subject==s & tidied$activity==aLabels[a, 2], ]
    res[row, 3:numCols] <- colMeans(tmp[, 3:numCols])
    row = row+1
  }
}
write.table(res, "averages_data.txt", row.name=FALSE)
