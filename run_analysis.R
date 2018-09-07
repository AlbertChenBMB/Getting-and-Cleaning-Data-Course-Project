library(dplyr)
library(tidyr)
# down load filed
download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip",destfile = "dataset")
# unzip file
unzip("dataset")
#reading the directory
dirpath <-"C:/Users/User/Documents/GitHub/Getting-and-Cleaning-Data-Course-Project/UCI HAR Dataset"
dirpath_test <-"C:/Users/User/Documents/GitHub/Getting-and-Cleaning-Data-Course-Project/UCI HAR Dataset/test"
dirpath_train <-"C:/Users/User/Documents/GitHub/Getting-and-Cleaning-Data-Course-Project/UCI HAR Dataset/train"
#locating files
filesdirpath<-list.files(dirpath,full.names = TRUE) 
filesdirtest<-list.files(dirpath_test,full.names = TRUE) 
filesdirtrain<-list.files(dirpath_train,full.names = TRUE) 
# Read  all files 
## Activity Labels
activity_labels<-read.table(filesdirpath[1])
## Features 
features<-read.table(filesdirpath[2])
##subject
subject<-rbind(read.table(filesdirtrain[2]),read.table(filesdirtest[2]))
## Values 
x_train<-read.table(filesdirtrain[3])
x_test<-read.table(filesdirtest[3])
y_train<-read.table(filesdirtrain[4])
y_test<-read.table(filesdirtest[4])
##names data 
names(activity_labels)<-c('label','activity')
names(subject)<-c('ids')


#1. Merges the training and the test sets to create one data set.
x<-rbind(x_train,x_test)
y<-rbind(y_train,y_test)
names(y)<-c('label')
names(x)<-features[,2]
rm(x_train,x_test,y_train,y_test)
label = cbind(y, subject)
data <-merge(label,activity_labels,by="label", all.y=T)
tidy_data <-data.frame(data,x)
# output to file "tidy_data.txt"
write.table(tidy_data, "tidy_data.txt", row.names = FALSE, 
            quote = FALSE)
#2. Extracts only the measurements on the mean and standard deviation for each measurement.
mean_std <- grepl("ids|activity|mean|std", colnames(tidy_data))
tidy_data <- tidy_data[, mean_std]
#3. Uses descriptive activity names to name the activities in the data set
tidy_data$activity<- factor(tidy_data$activity,
                  levels = activity_labels[, 2], 
                  labels = activity_labels[, 1])
#4. Appropriately labels the data set with descriptive variable names.
## get column names
Colname <- colnames(tidy_data)
## expand abbreviations and clean up names
Colname <- gsub("^f", "frequencyDomain", Colname)
Colname <- gsub("^t", "timeDomain", Colname)
Colname <- gsub("Acc", "Accelerometer", Colname)
Colname <- gsub("Gyro", "Gyroscope", Colname)
Colname <- gsub("Mag", "Magnitude", Colname)
Colname <- gsub("Freq", "Frequency", Colname)
Colname <- gsub("mean", "Mean", Colname)
Colname <- gsub("std", "StandardDeviation", Colname)
Colname <- gsub("BodyBody", "Body", Colname)
##replace colnames
colnames(tidy_data)<-Colname
#5. From the data set in step 4, creates a second, 
#  independent tidy data set with the average of each
#  variable for each activity and each subject.
## group by subject and activity and summarise using mean
tidy_dataMeans<- group_by(tidy_data,ids, activity) 
tidy_dataMeans<- summarise_each(tidy_dataMeans,funs(mean))

# output to file "tidy_data2.txt"
write.table(tidy_dataMeans, "tidy_data_2.txt", row.names = FALSE, 
            quote = FALSE)
