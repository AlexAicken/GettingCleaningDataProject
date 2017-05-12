#this script produces statistical summary for data from wearable devices
#see readme and codebook for more information in github repository

#define read directories where data is stored
trainDirectory <- "train"
testDirectory <- "test"

#read in all data needed - training data, test data, feature data, subject data, activity data
trainData <- read.table(file=file.path(trainDirectory, "X_train.txt"), header=FALSE)
subjectTrainData <- read.table(file=file.path(trainDirectory, "subject_train.txt"), header=FALSE)
trainActivityNames <- read.table(file=file.path(trainDirectory, "Y_train.txt"), header=FALSE)
testData <- read.table(file=file.path(testDirectory, "X_test.txt"), header=FALSE)
subjectTestData <- read.table(file=file.path(testDirectory, "subject_test.txt"), header=FALSE)
testActivityNames <- read.table(file=file.path(testDirectory, "Y_test.txt"), header=FALSE)
featureNames <- read.table("features.txt", sep=" ")
activityLabels <- read.table("activity_labels.txt", header=FALSE, sep=" ")

#union data for training and test data and rename
dataSet <- rbind(trainData, testData)
colnames(dataSet) <- featureNames[,2]

subjectNames <- rbind(subjectTrainData, subjectTestData)
colnames(subjectNames) <- c("SubjectID")

#Lookup Activity Name and union data, rename
trainActivityNames$ID  <- 1:nrow(trainActivityNames)
trainSetActivityNames <- merge(trainActivityNames, activityLabels, by="V1", all=TRUE)
trainSetActivityNames <- trainSetActivityNames[order(trainSetActivityNames$ID),]

testActivityNames$ID  <- 1:nrow(testActivityNames)
testSetActivityNames <- merge(testActivityNames, activityLabels, by="V1", all=TRUE)
testSetActivityNames <- testSetActivityNames[order(testSetActivityNames$ID),]

activityNames <- rbind(trainSetActivityNames, testSetActivityNames)
colnames(activityNames) <- c("Counter", "ActivityID", "ActivityName")

#filter main data set - only bring mean and standard deviation through
selectDataSet <- subset(dataSet, select = grep("mean\\(\\)|std\\(\\)", names(dataSet)))

#Rename so variables selected are named more clearly
selectNames <- colnames(selectDataSet)
selectNames <- gsub("-","_",selectNames)
selectNames <- gsub("\\(\\)","",selectNames)
colnames(selectDataSet) <- selectNames

#combine all data into one data set
namedSelectDataSet<- cbind(ActivityName = activityNames$ActivityName, selectDataSet)
namedSelectDataSet<-cbind(SubjectID = subjectNames, namedSelectDataSet)
namedSelectDataSet$SubjectID = as.factor(namedSelectDataSet$SubjectID)

#produce summary of means, split by subject and activity
tidySummary <- aggregate(namedSelectDataSet[,3:68], list(SubjectID=namedSelectDataSet$SubjectID, ActivityName=namedSelectDataSet$ActivityName), mean)

#produce summary text file
tidySummary <- tidySummary[order(tidySummary$SubjectID),]
write.table(namedSelectDataSet, file="tidySummary.txt", row.name=FALSE)