This codebook has 2 parts: data preparation and data analysis

## data preparation
1. download the data and unzip
2. read files into R

Including:
* test data
* train data
* subjects
* features
* activities

3. set features into the test and train column names
4. merge subjects and activities in to the test and train datasets
5. combine test and train datasets
6. change activities indexes into desctiption names

## Data analysis

This part include functions from Dplyr package

1. select columns that have info about either mean or sd measurements only
2. group by activity and subject
3. get average of each variable for each activity and each subject
4. export the resulting data