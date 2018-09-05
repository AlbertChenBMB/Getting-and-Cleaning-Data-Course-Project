#.1. Merges the training and the test sets to create one data set.
### down load filed
download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip",destfile = "dataset")
### unzip file
unzip("dataset")
###reading the directory
dirpath <-"C:/Users/glab/Documents/GitHub/Getting-and-Cleaning-Data-Course-Project/UCI HAR Dataset"
dirpath_test <-"C:/Users/glab/Documents/GitHub/Getting-and-Cleaning-Data-Course-Project/UCI HAR Dataset/test"
dirpath_train <-"C:/Users/glab/Documents/GitHub/Getting-and-Cleaning-Data-Course-Project/UCI HAR Dataset/train"


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
#Process to tydy data 
names(activity_labels)<-c('ida','activity')
names(subject)<-c('ids')
names(y)<-c('ida')
names(x)<-features[,2]
