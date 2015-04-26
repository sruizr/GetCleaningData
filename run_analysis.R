# 0. Extracting data from source (if there is not yet)

if (!file.exists("./dataset.zip")){
     download.file(
          "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip",
          destfile = "dataset.zip", method ='curl')
     unzip("./dataset")
}

# 1. Merges the training and the test sets to create one data set.

# 1.1. Loading feature labels
features <- read.table("./UCI HAR Dataset/features.txt")

# 1.2. Loading Train datasets
xTrain <- read.table("./UCI HAR Dataset/train/X_train.txt") # Values
yTrain <- read.table("./UCI HAR Dataset/train/y_train.txt") # Activity type
subjectTrain <- read.table("./UCI HAR Dataset/train/subject_train.txt") #Subjects
names(yTrain)  <- "activity"
names(subjectTrain)  <- "subject"
names(xTrain)  <- features[,2]
Train <- cbind(subjectTrain, yTrain, xTrain)


# 1.3 Loading Test datasets
xTest <- read.table("./UCI HAR Dataset/test/X_test.txt") # Values
yTest <- read.table("./UCI HAR Dataset/test/y_test.txt") # Activity type
subjectTest <- read.table("./UCI HAR Dataset/test/subject_test.txt") #Subjects
names(yTest)  <- "activity"
names(subjectTest)  <- "subject"
names(xTest)  <- features[,2]
Test <- cbind(subjectTest, yTest, xTest)

# 1.4. Merging data
data <- rbind(Train, Test)

# 1.5. Let's remove temporary variables
rm(xTrain, xTest, yTrain, yTest, subjectTrain, subjectTest)

# 2. Extracts only the measurements on the mean and standard deviation for each measurement. 

filter <- grepl("mean\\(\\)|std\\(\\)", features[,2])
filter  <- c(TRUE, TRUE, filter) #adding activity & subject variables
data  <-  data[,filter]

# 3. Uses descriptive activity names to name the activities in the data set


activityLabels  <-  read.table("./UCI HAR Dataset/activity_labels.txt")
data$activity  <- as.factor(data$activity)
levels(data$activity)  <- activityLabels[,2]

# 4. Appropriately labels the data set with descriptive variable names 
# (Done on point 1. Line 22 & 32)

# 5. From the data set in step 4, creates a second, independent tidy data set with 
# the average of each variable for each activity and each subject.

# create the tidy data set
library(reshape2)
melted <- melt(data, id=c("subject","activity"))
tidy <- dcast(melted, subject + activity ~ variable, mean)

# write the tidy data set to a file
write.table(tidy, "./tidy.txt", row.names=FALSE)
