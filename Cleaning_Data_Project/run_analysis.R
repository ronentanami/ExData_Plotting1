## This program takes data of Human Activity Recognition Using Smartphones Dataset and prepare a tidy Data Frame
## containing a "clean" version  reducing the 561 variables to only the ones that contain Mean and STD of data.
## In addition the program enrich the data with the Activity Name and the person ID.
## Finally the program calculates the average of all parameter as function of the Subject ID and the Activity Name


library(reshape2)
library(plyr)

setwd("~/Data Science/Getting and Cleaning Data/Work/UCI HAR Dataset/Results")

## Reading Feature List
feature_List <- read.table("~/Data Science/Getting and Cleaning Data/Work/UCI HAR Dataset/features.txt", sep = "", 
                           header=FALSE, stringsAsFactors=FALSE)  ## reading the Features list to set coloumn names

## Reading Activity Labales
activity_Labels <- read.table("~/Data Science/Getting and Cleaning Data/Work/UCI HAR Dataset/activity_labels.txt", sep = "", 
                           header=FALSE, stringsAsFactors=FALSE)
names(activity_Labels)[1] <- "activity_Id"
names(activity_Labels)[2] <- "activity_Name"


## Reading All Test Data
## *****************************************************************************************************

test_Data = read.table("~/Data Science/Getting and Cleaning Data/Work/UCI HAR Dataset/test/X_test.txt", sep = "")
for (i in 1:length(feature_List[,2])) {
        column_Name <- feature_List["V2"][i,1]
        names(test_Data)[i] <- column_Name   ## Seting the name of columns in test_Data DF (Names ara taken from Feature List)
}

test_Subject <- read.table("~/Data Science/Getting and Cleaning Data/Work/UCI HAR Dataset/test/subject_test.txt", sep = "", 
                header=FALSE, stringsAsFactors=FALSE)
names(test_Subject)[1] <- "subject_Id"

test_Activity <- read.table("~/Data Science/Getting and Cleaning Data/Work/UCI HAR Dataset/test/Y_test.txt", sep = "", 
                             header=FALSE, stringsAsFactors=FALSE)
names(test_Activity)[1] <- "activity_Id"



## Reading All Train Data
## *****************************************************************************************************

train_Data = read.table("~/Data Science/Getting and Cleaning Data/Work/UCI HAR Dataset/train/X_train.txt", sep = "")
for (i in 1:length(feature_List[,2])) {
        column_Name <- feature_List["V2"][i,1]
        names(train_Data)[i] <- column_Name   ## Seting the name of columns in test_Data DF
}

train_Subject <- read.table("~/Data Science/Getting and Cleaning Data/Work/UCI HAR Dataset/train/subject_train.txt", sep = "", 
                           header=FALSE, stringsAsFactors=FALSE)
names(train_Subject)[1] <- "subject_Id"

train_Activity <- read.table("~/Data Science/Getting and Cleaning Data/Work/UCI HAR Dataset/train/Y_train.txt", sep = "", 
                            header=FALSE, stringsAsFactors=FALSE)
names(train_Activity)[1] <- "activity_Id"



## Merging Test and Training Data Frames
## *****************************************************************************************************

comb_DF = rbind(test_Data,train_Data)  # Combined DF

comb_Subject = rbind(test_Subject,train_Subject) 
comb_Activity = rbind(test_Activity, train_Activity)



## Enriching main DF with Subject and Activity columns
## *****************************************************************************************************

comb_Activity = join(comb_Activity, activity_Labels, by="activity_Id")
comb_DF$subject_Id = comb_Subject$subject_Id
comb_DF$activity_Id = comb_Activity$activity_Id
comb_DF$activity_Name = comb_Activity$activity_Name


## Reducing main DF to only fields containing "mean()" and "std()"
## *****************************************************************************************************

column_Vector = names(comb_DF)
mean_Vec = grep("mean()" , column_Vector, fixed = TRUE)
std_Vec = grep("std()" , column_Vector, fixed = TRUE)
sub_Vec = grep("subject_Id" , column_Vector, fixed = TRUE)
act_Vec = grep("activity_Name" , column_Vector, fixed = TRUE)
mean_std_Vec = c(mean_Vec,std_Vec,sub_Vec,act_Vec)
mean_std_Vec = sort(mean_std_Vec)

Tidy_DF = comb_DF[mean_std_Vec]  ## This is a Tidy DF that includes subject, activityname and all varibales with mean or STD



## Calculating Average
## *****************************************************************************************************
melted_Tidy = melt(Tidy_DF,id=c("subject_Id","activity_Name"))

average_Tidy = dcast(melted_Tidy ,subject_Id + activity_Name ~ variable, mean)

write.csv(average_Tidy, file = "Tidy_Average.CSV", row.names = FALSE)
write.csv(average_Tidy, file = "Tidy_Average.TXT", row.names = FALSE, eol = "\n")

write.csv(Tidy_DF, file = "Tidy_data.CSV", row.names = FALSE)

## End


       