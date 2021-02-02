# Retrieving raw files and parsing the relevant ones
if(!file.exists("/Data")) dir.create("Data")
download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip", "Data/samsung.zip")
unzip("Data/samsung.zip")

df_test<-read.table("UCI HAR Dataset/test/X_test.txt")
activity_test<-read.table("UCI HAR Dataset/test/y_test.txt")
subject_test<-read.table("UCI HAR Dataset/test/subject_test.txt")
df_train<-read.table("UCI HAR Dataset/train/X_train.txt")
activity_train<-read.table("UCI HAR Dataset/train/y_train.txt")
subject_train<-read.table("UCI HAR Dataset/train/subject_train.txt")
activity<-read.table("UCI HAR Dataset/activity_labels.txt")
features<-read.table("UCI HAR Dataset/features.txt")


# Extracting required variables from each dataframe and adding columns with informations about subject and activity
library(dplyr)
var_to_extract<-grep("(mean|std)",features$V2)
var_names<-grep("(mean|std)",features$V2,value=T)

df_test<-select(df_test,all_of(var_to_extract))
names(df_test)<-var_names
df_test<-mutate(df_test,group="test",volunteer=as.factor(subject_test$V1),activity=as.factor(activity_test$V1))
df_test<-select(df_test,c(80,81,82,1:79))
levels(df_test$activity)<-activity$V2

df_train<-select(df_train,all_of(var_to_extract))
names(df_train)<-var_names
df_train<-mutate(df_train,group="train",volunteer=as.factor(subject_train$V1),activity=as.factor(activity_train$V1))
df_train<-select(df_train,c(80,81,82,1:79))
levels(df_train$activity)<-activity$V2





