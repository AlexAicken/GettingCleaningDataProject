# Getting and Cleaning Data - Course Project

## Overview  
The code summarises and tidies human activity data from smartphones 
It produces summarised tidy data, split by subject and activity  

## Data
### Data Input
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip  
### More information
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones  

## Overview of Code  
(see comments in code for more information)  
1. The code in the github repo run_analysis.R : 
2. Pulls all data needed in (note - the data linked to above should be unzipped in working directory)  
3. Merges the training and the test sets to create one data set, adds names  
4. Extracts only the measurements on the mean and standard deviation for each measurement  
5. Uses descriptive activity names to name the activities in the data set  
6. Creates a second, independent tidy data set (tidySummary.txt) with the average of each variable for each activity and each subject  
7. Outputs this data set to a text file  

## How to run
1. Extract the __data input__ file above into your working directory
2. Run the script __run_analysis.R__ 
