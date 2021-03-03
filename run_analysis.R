
if(!file.exists('./coursera/final')){dir.create('./coursera/final')}
setwd('./coursera/final')
library(reshape2)
library(dplyr)
library(tidyr)

# Download data
filename <- "getdata_dataset.zip"
fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip "
if (!file.exists(filename)){
    download.file(fileURL, filename, method="curl")
}  
if (!file.exists("UCI HAR Dataset")) {unzip(filename)}

# 1. Merge test and train data into one data set, assign colnames
feature <- read.table('./UCI HAR Dataset/features.txt')
x_test <- read.table('./UCI HAR Dataset/test/X_test.txt')
y_test <- read.table('./UCI HAR Dataset/test/y_test.txt')
sub_test <- read.table('./UCI HAR Dataset/test/subject_test.txt')
test <- cbind(sub_test,y_test,x_test)
colnames(test) <- c('Subject','Activity',feature[,2])

x_train <- read.table('./UCI HAR Dataset/train/X_train.txt')
y_train <- read.table('./UCI HAR Dataset/train/y_train.txt')
sub_train <-read.table('./UCI HAR Dataset/train/subject_train.txt')
train <- cbind(sub_test,y_test,x_test)
colnames(train) <- c('Subject','Activity',feature[,2])

# 2. Extracts only the measurements on means and stds. 
dat <- rbind(test,train)
keep <- grep('mean\\()$|std\\()$',names(dat))
findat <- dat[,c(1,2,keep)]

# 3. Name "Activity" with descriptively
actlab <- read.table('./UCI HAR Dataset/activity_labels.txt')
findat$Activity <- factor(findat$Activity, levels = actlab[,1], 
                          labels = actlab[,2])

# 4. Rename variables appropriately
oldname <- names(findat)
oldname <- gsub('-mean\\()','_Mean',oldname)
oldname <- gsub('-std\\()','_Std',oldname)
oldname <- gsub('^t','Time_',oldname)
oldname <- gsub('^f','Freq_',oldname)
colnames(findat) <- oldname

# 5. Based on 4, create a new data set with the average of each variable for 
# each activity and each subject.

grmean <- findat %>%
    group_by(Subject, Activity) %>%
    summarise_each(funs(mean))
write.table(grmean, file = 'meandata.txt',row.name=FALSE)



