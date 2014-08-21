Human Activity Recognition Tidy Data Set
=============

This repo contains an analysis script and a tidy data set based on the UCI 
Human Activity Recognition data collected from the accelerometers of Samsung
Galaxy S smartphones.

Original Data
-------------
One of the most exciting areas in all of data science right now is wearable computing. Many companies are investing significantly to develop wearable computing products with advanced algorithms that attract new users. The data used in this analysis represents data collected from the accelerometers in the Samsung Galaxy S smartphone. A full description is available at the site where the data was obtained:

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

Here is the data used in this analysis:

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

The original data consists of 3 dimensional accelerometer and gyroscope readings that were recorded for 30 different subjects in the experiment. One of 6 different activity types is recorded to identify the activity that took place at the time the data was recorded.


Derived Data
-------------
Multiple significant manipulations were performed on the original 3 axis data that include:
- the original signal data was filtered to seperate the signals into gravity and body movement components.
- the body movement signals were then used to derive body jerk signals.
- some of these signals were further interpreted using a fast fourier transform (FFT) that generated 6 more 3 dimentional signals.
- the resulting original and derived data was divided into 2 datsets. One is called train and the other is called test.


Analysis Methodology
-------------
The analysis script run_analysis.R does the following. 

- Merges the training and the test sets to create one data set.
- Extracts only the measurements on the mean and standard deviation for each measurement. 
- Uses descriptive activity names to name the activities in the data set
- Appropriately labels the data set with descriptive variable names. 
- Creates a second, independent tidy data set with the average of each variable for each activity and each subject. 


Resulting Datasets
-------------
The first dataset is a result of the first 4 steps in the analysis methodology. It contains a row for each observation and columns that identify the subject and activity description of each observation. All mean and standard deviation variables that occur in the original datasets are included for each observation.

The second dataset results from the 5th step in the data analysis script and provides a row for each subject and activity combination that occurs in the original datasets. Under each variable is the mean of that variable for the subject and activity combination of that row.
