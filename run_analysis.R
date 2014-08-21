#
# load the required packages and identify the file path for the UCI HAR Dataset
#
library(data.table)
library(reshape2)
wd <- getwd()
DataSetDir <- paste(wd,"/UCI HAR Dataset/",sep="")
rm(wd)

#
# read the common descriptor tables into memory for:
#     - features.txt - this contains all the variable names for the data
#     - activity_labels.txt - this contains labels for each activity type
#
filepath <- paste(DataSetDir,"features.txt",sep="")
features <- read.table(filepath, quote="\"", stringsAsFactors=FALSE)
features <- as.vector(features$V2)
filepath <- paste(DataSetDir,"activity_labels.txt",sep="")
activity_labels <- read.table(filepath, quote="\"", 
                              col.names=c("Activity_No","Activity"),
                              stringsAsFactors=FALSE)

#
# read the train dataset into memory. It has 3 components:
#     - X_train.txt - this contains all the variable data for the training data
#     - subject_train.txt - this contains the subject for each observation in X_train
#     - y_train.txt - this contains the activity ID for each observation in X_train
#     - all 3 components are combined into one dataset called train.
#
filepath <- paste(DataSetDir,"train/X_train.txt",sep="")
train <- read.table(filepath, quote="\"", col.names=features)
filepath <- paste(DataSetDir,"train/subject_train.txt",sep="")
subject <- read.table(filepath, quote="\"", col.names=c("Subject"))
filepath <- paste(DataSetDir,"train/y_train.txt",sep="")
activity <- read.table(filepath, quote="\"", col.names=c("Activity_No"))
activity <- merge(activity,activity_labels)
train <- cbind(subject,activity,train)

#
# read the test dataset into memory. It has 3 components:
#     - X_test.txt - this contains all the variable data for the training data
#     - subject_test.txt - this contains the subject for each observation in X_test
#     - y_test.txt - this contains the activity ID for each observation in X_test
#     - all 3 components are combined into one dataset called test.
#
filepath <- paste(DataSetDir,"test/X_test.txt",sep="")
test <- read.table(filepath, quote="\"", col.names=features)
filepath <- paste(DataSetDir,"test/subject_test.txt",sep="")
subject <- read.table(filepath, quote="\"", col.names=c("Subject"))
filepath <- paste(DataSetDir,"test/y_test.txt",sep="")
activity <- read.table(filepath, quote="\"", col.names=c("Activity_No"))
activity <- merge(activity,activity_labels)
test <- cbind(subject,activity,test)
rm(subject,activity,activity_labels,DataSetDir,features,filepath)

#
# Combine the train and test datasets into one large dataset called data_all
#
data_all <- rbind(train,test)
rm(train,test)

#
# Create a new dataset (data_mean_std) with only the Subject, Activity columns
# and any column that is related to mean or standard deviation
# Note: 'mean' and 'std' in the column name indicate they are related to
# mean and standard deviation respectively.
#
cols_mean_std <- grep(("^Subject$|^Activity$|mean|std"),colnames(data_all))
data_mean_std <- data_all[,cols_mean_std]
rm(cols_mean_std, data_all)

#
# Create an independent tidy dataset (Activity_Subject_means) that identifies 
# the average of each variable by Subject and Activity
#
data_mean_std <- data.table(data_mean_std)
col_vars <- grep("mean|std",colnames(data_mean_std))
m <- melt(data_mean_std, id=c("Subject","Activity"), measure.vars=col_vars)
Activity_Subject_means <- dcast(m,Activity+Subject ~ variable,mean)
rm(m,col_vars)

write.table(Activity_Subject_means, 
            file="~/Activity_Subject_means.txt", 
            row.name=FALSE)
