# Getting-and-Cleaning-Data-Assignment

## About this repository
The folder has been created to finish the last week assignment of the Getting and Cleaning Data course of Data Science Specialization on Coursera

## Data description
The data belongs to [UCI Machine Learning Repository: Human Activity Recognition Using Smartphones Data Set](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones)

The variables in the data X are sensor signals measured with waist-mounted smartphone from 30 subjects. The variable in the data Y indicates activity type the subjects performed during recording. 

## Code explaination
The code is following the assignment instruction:

1. Merges the training and the test sets to create one data set. Use command rbind to combine training and test set
2. Extracts only the measurements on the mean and standard deviation for each measurement. Use grep command to get column indexes for variable name contains "mean()" or "std()"
3. Uses descriptive activity names to name the activities in the data set Convert activity labels to characters and add a new column as factor
4. Appropriately labels the data set with descriptive variable names. Give the selected descriptive names to variable columns
5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject. Use pipeline command to create a new tidy dataset with command group_by and summarize_each in dplyr package

## tidy_data dataset

Contains the results of the 5th step of the assignment instruction