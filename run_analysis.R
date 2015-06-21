
#assumes yser has down loaded the zip file and unzipped it in the working directroy


#Load Test Data
testRaw <- read.table("./UCI HAR Dataset/test/X_test.txt")
testRawLabels <- read.table("./UCI HAR Dataset/test/y_test.txt")
testRawSubject <- read.table("./UCI HAR Dataset/test/subject_test.txt")

#Load Training Data
trainingRaw <- read.table("./UCI HAR Dataset/train/X_train.txt")
trainingRawLabels <- read.table("./UCI HAR Dataset/train/y_train.txt")
trainingRawSubject <- read.table("./UCI HAR Dataset/train/subject_train.txt")

featuresRaw <- read.table("./UCI HAR Dataset/features.txt")


#Merges the training and the test sets to create one data set. (STEP 1)
trainingSubjLabels <-cbind(trainingRaw,trainingRawLabels,trainingRawSubject)
testSubjLabels <-cbind(testRaw,testRawLabels,testRawSubject)
mergedTestTraining <- rbind(trainingSubjLabels,testSubjLabels)

#Change the features so the names are legal and descriptive (STEP 4)
cleanFeatures <- gsub(")","",featuresRaw$V2)
cleanFeatures <- gsub("\\(","",cleanFeatures)
cleanFeatures <- gsub("\\,","",cleanFeatures)
cleanFeatures <- gsub("-","_",cleanFeatures)

#Add Features (STEP 1)
names(mergedTestTraining) <-cleanFeatures
colnames(mergedTestTraining)[562] <-"labels"
colnames(mergedTestTraining)[563] <-"subject"

# Uses descriptive activity names to name the activities in the data set (STEP 3)
mergedTestTraining[mergedTestTraining$labels==1,562] <-"Walking"
mergedTestTraining[mergedTestTraining$labels==2,562] <-"Walking_Upstairs"
mergedTestTraining[mergedTestTraining$labels==3,562] <-"Walking_Downstairs"
mergedTestTraining[mergedTestTraining$labels==4,562] <-"Sitting"
mergedTestTraining[mergedTestTraining$labels==5,562] <-"Standing"
mergedTestTraining[mergedTestTraining$labels==6,562] <-"Laying"

#Extracts only the measurements on the mean and standard deviation for each measurement (STEP 2).
#Use grep to match strings "mean" or "std"
meanStdOfTestTraining <- mergedTestTraining[,grep("mean|std|labels|subject",names(mergedTestTraining))]

#independent tidy data set with the average of each variable for each activity and each (STEP 5)
tidySet <- aggregate(meanStdOfTestTraining, by = list(meanStdOfTestTraining$subject,meanStdOfTestTraining$labels), FUN=mean)

#Write the file out
#write.table(tidySet,file="./tidy_HAR_DataSet.txt", row.names=FALSE)

#Read file back in
# test <- read.table(file="./tidy_HAR_DataSet.txt", header=TRUE)
