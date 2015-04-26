Script run_analysis.R
=====================

The script tries to follow the requirements of the coursera course **Getting and Cleaning Data* by the Johns Hopkins Bloomberg School of Public Health.

Anyway the steps are commented in the sript file.

## Step 0. Download the raw data.

Even is not requested I've added the code for downloading the raw data. Due to the exceed of size I wouldn't wanted to upload to github so the script will download it only if there is not in the local directory.

After downloading the file is uncompresed in the current directory.

## Step 1. Merge the training and the test sets to create one data set.

1. I've extracted the following tables from the dataset:
    - *features.txt*: It contains the labels of each column on the X_*.txt files.
    - *X_train/test.txt *: It contains all the features.
    - *Y_train/test.txt*: It contains the activity type. Each row of this file maps to each row of the X_*.txt file
    - *subject_train/test.txt*: It contains the identification of each subject for each row of X_*.txt dataframe
2. I merged the dataframes Y, subject &  of each set. I've labeled each column
3. I've merged the tow data sets (training & test) into one called `data`

## Step.2. Extracts only the measurements on the mean and standard deviation for each measurement.

1. Using the name of each column I've extracted the ones which have the pattern `mean()` or `std()`.
2. I've redefined the `data` dataframe removing all columns doesn't match to the pattern (keeping "subject" & "activity" variables).

# Step 3. Uses descriptive activity names to name the activities in the data set.

1. The activity variable is now a integer and I'm converting to factors.
2. The label of each factor has been redefined using the file `activity_labels.txt`

# Step 4. Appropriately labels the data set with descriptive variable names. 

1. The features were labelled on the step 1.

# Step 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

1. For this purpose I had to use the library reshape2.
2. First I melt the data using the variables "subject" & "activity"
3. Then I gengerated a new table with means of the rest of columns.