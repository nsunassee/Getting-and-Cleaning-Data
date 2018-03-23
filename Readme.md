### Created an R script called run_analysis.R that does the following:

1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement.
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive variable names.
5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.


### run_Analysis.R

1. Firstly, we download and unzip the source file
2. Then we read the data files into R:
	2.1 Features data
	2.2  X, Y, and Subject Training Data
	2.3 X, Y, and Subject Test Data
3. We then merge all Training & Test Data using the rbind function
4. We then extract only the measurements on the mean and standard deviation for each measurement by searching through using the grp function
5. We rename the activities in the data set with descriptive names from the  labels in the activity_labels.txt file
6. We label the data set with descriptive variable names.
7. Finally, we output a second, independent tidy data set with the average of each variable for each activity and each subject.
