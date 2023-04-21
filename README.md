# C3_Assignment
Coursera Assignment : Getting and Cleaning Data Course Project

The purpose of this project is to demonstrate your ability to collect, work with, and clean a data set. The goal is to prepare tidy data that can be used for later analysis.

There are following tasks:
1. Read the common data such activity, read the test and train data, their labels and subjects
2. Merges the training and the test sets to create one data set.
3. Extracts only the measurements on the mean and standard deviation for each measurement. 
4. Uses descriptive activity names to name the activities in the data set
5. Appropriately labels the data set with descriptive variable names. 
6. From the data set in step 5, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

The key functions used are:
append: to add values to vector
cbind: merge of vectors and matrix
getwd(): get current directory
ifelse: to replace the values in matrix
is.na: to check na values
merge: combine the matrix on index
paste: merge two strings
read.csv: to upload the data
rbind: merge two matrices with common columns
sapply: to perform pivot statistics
split: to prepare the data for pivot statistics

