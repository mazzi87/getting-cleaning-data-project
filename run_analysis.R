### setting the working directory
### setwd("~/Coursera/getting and cleaning data/assignment/UCI HAR Dataset")

### read in the data files
subject_train <- read.table("C:/Users/Andrea/Documents/Coursera/getting and cleaning data/assignment/UCI HAR Dataset/train/subject_train.txt")
X_train <- read.table("C:/Users/Andrea/Documents/Coursera/getting and cleaning data/assignment/UCI HAR Dataset/train/X_train.txt")
Y_train <- read.table("C:/Users/Andrea/Documents/Coursera/getting and cleaning data/assignment/UCI HAR Dataset/train/y_train.txt")
subject_test <- read.table("C:/Users/Andrea/Documents/Coursera/getting and cleaning data/assignment/UCI HAR Dataset/test/subject_test.txt")
X_test <- read.table("C:/Users/Andrea/Documents/Coursera/getting and cleaning data/assignment/UCI HAR Dataset/test/X_test.txt")
Y_test <- read.table("C:/Users/Andrea/Documents/Coursera/getting and cleaning data/assignment/UCI HAR Dataset/test/y_test.txt")

### combining the train and test datasets separately
data_train <- cbind(subject_train, Y_train, X_train)
data_test <- cbind(subject_test, Y_test, X_test)

### combine both datasets together
dataset <- rbind(data_train, data_test)

### attach col names
col <- read.table("C:/Users/Andrea/Documents/Coursera/getting and cleaning data/assignment/UCI HAR Dataset/features.txt")
col <- col[,2]
colnames(dataset) <- c("Subject", "Activity", as.character(col))

### extract subset with colnames including the "mean()" and "std()" expressions
data_small <- dataset[,c(1:2, grep("(mean|std)\\(\\)", colnames(dataset)))]

### replace the activity numbers with their corresponding names
library(plyr)
activity <- read.table("C:/Users/Andrea/Documents/Coursera/getting and cleaning data/assignment/UCI HAR Dataset/activity_labels.txt")
colnames(activity) <- c("Activity", "Activity Name")
dataset_act <- join(data_small, activity, by = "Activity")
dataset_act <- dataset_act[,-2]
dataset_act <- dataset_act[,c(1,ncol(dataset_act),2:(ncol(dataset_act)-1))]

### rename the column names with descriptive variables
names(dataset_act)<-gsub("^t", "Time", names(dataset_act))
names(dataset_act)<-gsub("^f", "Frequency", names(dataset_act))
names(dataset_act)<-gsub("Acc", "Accelerometer", names(dataset_act))
names(dataset_act)<-gsub("Gyro", "Gyroscope", names(dataset_act))
names(dataset_act)<-gsub("Mag", "Magnitude", names(dataset_act))
names(dataset_act)<-gsub("BodyBody", "Body", names(dataset_act))

### extract final dataset and save it as "tidydata.txt"
attach(dataset_act)
data <- aggregate(. ~Subject + `Activity Name`, dataset_act, mean)
data <- data[order(data$Subject, data$'Activity Name'),]
write.table(data, file = "tidydata.txt", row.name=FALSE)
detach(dataset_act)