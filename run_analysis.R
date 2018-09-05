#.1. Merges the training and the test sets to create one data set.
### down load filed
download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip",destfile = "dataset")
### unzip file
unzip("dataset")
###reading the directory
dirpath <-"C:/Users/User/Documents/GitHub/Getting-and-Cleaning-Data-Course-Project/UCI HAR Dataset"
dirpath_test <-"C:/Users/User/Documents/GitHub/Getting-and-Cleaning-Data-Course-Project/UCI HAR Dataset/test"
dirpath_train <-"C:/Users/User/Documents/GitHub/Getting-and-Cleaning-Data-Course-Project/UCI HAR Dataset/train"


###locating files
## Locating files
filesdirpath<-list.files(dirpath,full.names = TRUE) 
filesdirtest<-list.files(dirpath_test,full.names = TRUE) 
filesdirtrain<-list.files(dirpath_train,full.names = TRUE) 

## Loading files 
## Activity Labels
activity_labels<-read.table(filesdirpath[1])
## features 
features<-read.table(filesdirpath[2])
##subject
subject<-rbind(read.table(filesdirtrain[2]),read.table(filesdirtest[2]))
## Values 
x<-rbind(read.table(filesdirtrain[3]),read.table(filesdirtest[3]))
y<-rbind(read.table(filesdirtrain[4]),read.table(filesdirtest[4]))
#names data 
names(activity_labels)<-c('ida','activity')
names(subject)<-c('ids')
names(y)<-c('ida')
names(x)<-features[,2]
#1. Merges the training and the test sets to create one data set.
data = cbind(y, subject)
data <-merge(data,activity_labels,by="ida", all.y=T)
tidy_data <-data.frame(data,x)
#2. Extracts only the measurements on the mean and standard deviation for each measurement.
library(dplyr)
#select(tidy_data,contains("mean")|contains("std"))
