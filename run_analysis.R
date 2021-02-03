# Retrieving raw files (can be skipped if they're already in your working dir)
if(!file.exists("/Data")) dir.create("Data")
download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip", "Data/samsung.zip")
download_date<-Sys.Date()

#Parsing relevant files
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

df_test<-select(df_test,all_of(var_to_extract)) %>%
    mutate(group="test",volunteer=as.factor(subject_test$V1),activity=as.factor(activity_test$V1)) %>%
    select(80,81,82,1:79)
names(df_test)[4:82]<-var_names
levels(df_test$activity)<-activity$V2


df_train<-select(df_train,all_of(var_to_extract)) %>%
    mutate(group="train",volunteer=as.factor(subject_train$V1),activity=as.factor(activity_train$V1)) %>%
    select(80,81,82,1:79)
names(df_train)[4:82]<-var_names
levels(df_train$activity)<-activity$V2

#Merging the 2 dataframes and saving the tidy dataset
tidy_df<-bind_rows(df_test,df_train) %>%
    mutate(tidy_df, id=seq_along(group)) %>% select(83,1:82)
write.table(tidy_df,"tidy_dataset.txt", row.names = F)

#Creating the summarized dataset
grouped<-group_by(tidy_df,volunteer,activity)
summarized_df<-summarise_all(grouped[c(-1,-2)],mean)
column<-names(grouped)[5:length(names(grouped))]
column<-paste("Average of",column)
names(summarized_df)[3:81]<-column

write.table(summarized_df,"SummarizedDataset.txt",row.names = F)






