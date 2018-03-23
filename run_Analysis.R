## Downloading & unzipping the source file
fileurl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileurl, "UCI-HAR-dataset.zip")
unzip("UCI-HAR-dataset.zip")

## Reading the data files into R
# Features data
feat <- read.csv('./UCI HAR Dataset/features.txt', header = FALSE, sep = ' ')
feat <- as.character(feat[,2])

# X, Y, and Subject Training Data
trainx <- read.table('./UCI HAR Dataset/train/X_train.txt')
trainy <- read.csv('./UCI HAR Dataset/train/y_train.txt', header = FALSE, sep = ' ')
trainsubj <- read.csv('./UCI HAR Dataset/train/subject_train.txt',header = FALSE, sep = ' ')
traindata <-  data.frame(trainsubj, trainy, trainx)
names(traindata) <- c(c('subject', 'activity'), feat)

# X, Y, and Subject Test Data
testx <- read.table('./UCI HAR Dataset/test/X_test.txt')
testy <- read.csv('./UCI HAR Dataset/test/y_test.txt', header = FALSE, sep = ' ')
testsubj <- read.csv('./UCI HAR Dataset/test/subject_test.txt', header = FALSE, sep = ' ')
testdata <-  data.frame(testsubj, testy, testx)
names(testdata) <- c(c('subject', 'activity'), feat)



### 1. Merging all Training & Test Data
dataall <- rbind(traindata, testdata)


### 2. Extracts only the measurements on the mean and standard deviation for each measurement.
meansd <- grep('mean|std', feat)
meansd_data <- dataall[,c(1,2,meansd)]


### 3. Uses descriptive activity names to name the activities in the data set
activitylabels <- read.table('./UCI HAR Dataset/activity_labels.txt', header = FALSE)
activitylabels <- as.character(activitylabels[,2])
meansd_data$activity <- activitylabels[meansd_data$activity]


### 4. Appropriately labels the data set with descriptive variable names.
newname <- names(meansd_data)
newname <- gsub("[(][)]", "", newname)
newname <- gsub("^t", "TimeDomain_", newname)
newname <- gsub("^f", "FrequencyDomain_", newname)
newname <- gsub("Acc", "Accelerometer", newname)
newname <- gsub("Gyro", "Gyroscope", newname)
newname <- gsub("Mag", "Magnitude", newname)
newname <- gsub("-mean-", "_Mean_", newname)
newname <- gsub("-std-", "_StandardDeviation_", newname)
newname <- gsub("-", "_", newname)
names(meansd_data) <- newname


### 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
tidydata <- aggregate(meansd_data[,3:81], by = list(activity = meansd_data$activity, subject = meansd_data$subject),FUN = mean)
write.table(x = tidydata, file = "data_tidy.txt", row.names = FALSE)
