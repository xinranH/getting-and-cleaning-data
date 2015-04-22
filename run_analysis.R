##Download the data
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileUrl, destfile = "Dataset.zip")
unzip("Dataset.zip")
file.rename("UCI HAR Dataset","dataset")

##Packages may be used
library("dplyr")
library("tidyr")

##Input data
train<-read.table("./dataset/train/X_train.txt")
test<-read.table("./dataset/test/X_test.txt")
train_subject<-read.table("./dataset/train/subject_train.txt")
test_subject<-read.table("./dataset/test/subject_test.txt")
train_label<-read.table("./dataset/train/y_train.txt")
test_label<-read.table("./dataset/test/y_test.txt")
info<-read.table("./dataset/features.txt")

##Merge the train and test data,name the column
data<-merge(train,test,all=T)
colnames(data)<-t(info[,2])

##Remove the dulicated data, extract the mean and std from the data
label<-rbind(train_label,test_label)
subject<-rbind(train_subject,test_subject)
colnames(label)<-"label"
colnames(subject)<-"subject"
data<-data[-which(duplicated(info[,2]))]
mean_and_std<-cbind(select(data,matches("mean")),select(data,matches("std")),subject,label)
 

##Uses descriptive activity names to name the activities in the data set
label_matrix<-as.matrix(mean_and_std$label)
label_matrix[label_matrix %in% c("1")]<-c("WALKING")
label_matrix[label_matrix %in% c("2")]<-c("WALKING_UPSTAIRS")
label_matrix[label_matrix %in% c("3")]<-c("WALKING_DOWNSTAIRS")
label_matrix[label_matrix %in% c("4")]<-c("SITTING")
label_matrix[label_matrix %in% c("5")]<-c("STANDING")
label_matrix[label_matrix %in% c("6")]<-c("LAYING")
mean_and_std$activity<-label_matrix
 mean_and_std<-select(mean_and_std,-label)

##Label the data set with descriptive variable names is finished above
 

##Extract the average of signal,change the format and create the second data set
data2<-select(mean_and_std,matches("mean"))
data2<-cbind(data2,subject,label_matrix)
data_update<-gather(data2,subject,label_matrix)
col_combine<-paste(data_update[,1],data_update[,2],data_update[,3])
data_temp<-data.frame(project=col_combine,score=data_update[,4])
mean<-data.frame(tapply(data_temp[,2],data_temp[,1],mean))
col_split<-data_update[-which(duplicated(data_update[,1:3])),1:3]
mean<-data.frame(col_split[,1:3],mutate(mean,as.character(names(mean[,1]))))
mean<-mean[c(1,2,3,4)]
colnames(mean)<-c("subject","activity","signal","average score")
write.table(mean,file="cleandata",row.name=FALSE)




