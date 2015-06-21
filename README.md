# getdata_Jun2015Project
This project was to clean data from an activity monitor data set and summarize a subset of it. 

The R script here assumes you have downloaded and unzipped the data to your working directory from: 
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

The script does the following. 
1.Merges the training and the test sets to create one data set:
  First the script clips together the test and training data as two subsets.
  For each of the two subsets the measurement data, activity labels and subject identifiers are clipped together using         cbind().
  The training and test subsets are then combined using rbind() to create the base dataset.
  
2.Extracts only the measurements on the mean and standard deviation for each measurement:
  A new subset of data using only mean and standard deviations was created by using grep for "mean" or "std" in the            descriptive text variable names. This ensured the most inclusive set columns that matched grep text strings.
  
3.Uses descriptive activity names to name the activities in the data set:
  The raw base data set had numbers to identify the specific actvities. The script uses the descriptive text names in the      actvity_labels.txt to replace the numbers.

4.Appropriately labels the data set with descriptive variable names: 
  The descriptive names for the variables were added from the features.txt after removing parenthesis and hyphens to make       them legal R variable names.  The columns for actvities and subjects were renamed accordingly.

5.From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject:
  The script uses the aggregate function to apply the mean function to all the subjects and their activities for each mean and standard deviation measurement.
