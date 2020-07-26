library(dplyr)

# downloading the data if needed
fileDest <- "Getting and Cleaning Data/Assignment/hum_act.zip"
if (!file.exists(fileDest)){
  fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
  download.file(fileUrl,fileDest)
  print("done")
} else {
  print("zip file exists")
}
# unzipping if needed
if (!file.exists("Getting and cleaning Data/Assignment/UCI HAR Dataset")){
  unzip(fileDest, exdir = "Getting and Cleaning Data")
  print("done")
} else {
  print("files have been already unzipped")
}

# reading files and preparing
setwd("Getting and Cleaning Data/Assignment/UCI HAR Dataset")
test <- read.table("test/X_test.txt", sep = "")
labTest <- read.table("test/y_test.txt", sep = "", col.names = "Activity")
train <- read.table("train/X_train.txt", sep = "")
labTrain <- read.table("train/y_train.txt", sep = "", col.names = "Activity")
features <- read.table("features.txt")
features <- features[,2]
activity_labels <- read.table("activity_labels.txt")
activity_labels <- activity_labels[,2]
subjectTrain <- read.table("train/subject_train.txt", col.names = "Subject")
subjectTest <- read.table("test/subject_test.txt", col.names = "Subject")
names(test) <- features
names(train) <- features
test <- cbind(test, subjectTest, labTest)
train <- cbind(train, subjectTrain, labTrain)

# combining
whole <- rbind(train, test)

# Changing acitivities index into the full title
whole$Activity <- sapply(whole$Activity, function(x){x <- activity_labels[x]})

# Selecting measurements on the mean and sd of the each measurement
meanSd <- select(whole,grep("mean", names(whole)), grep("sd", names(whole)), Activity, Subject)

# Getting average of each variable for each activity and each subject

avg <- meanSd %>%
  group_by(Activity, Subject) %>%
  summarise_all(mean)

# tidy data export
write.table(avg, "../tidy_data.txt", row.names = F)
