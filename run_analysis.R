#Get the url of the files
urlTrainingData <- "./UCI HAR Dataset/train/"
urlTestData <- "./UCI HAR Dataset/test/"
url <- "./UCI HAR Dataset/"

#Read de features file and filter
features<- read.csv(paste(url, "features.txt", sep=""), sep="", header=FALSE)
colSelected <- grep("*-mean\\(\\)-*|*-std\\(\\)-*", features[,2])

#Read the X_train data
trainingX <- read.csv(paste(urlTrainingData, "X_train.txt", sep=""), sep="", header=FALSE)

#Rename the columns with the name of features
names(trainingX) <- features[,2]

#Select only the columns with mean() and std()
trainingX <- trainingX[, colSelected]

#Read the y_train data
trainingY <- read.csv(paste(urlTrainingData, "y_train.txt", sep=""), sep="", header=FALSE)

#Rename the column
names(trainingY) <- "id_activity"

#Read the subject_train data
trainingSubject <- read.csv(paste(urlTrainingData, "subject_train.txt", sep=""), sep="", header=FALSE)

#Rename de column
names(trainingSubject) <- "subject"

#Merge the all training data
trainingDataset <- data.frame(c(trainingX, trainingY, trainingSubject))


#The same for the test data
testX <- read.csv(paste(urlTestData, "X_test.txt", sep=""), sep="", header=FALSE)
names(testX) <- features[,2]
testX <- testX[, colSelected]
testY <- read.csv(paste(urlTestData, "Y_test.txt", sep=""), sep="", header=FALSE)
names(testY) <- "id_activity"
testSubject <- read.csv(paste(urlTestData, "subject_test.txt", sep=""), sep="", header=FALSE)
names(testSubject) <- "subject"
testDataset <- data.frame(c(testX, testY, testSubject))

Dataset <- rbind(trainingDataset, testDataset)

#Read the activity_labels data
Activities <- read.csv(paste(url, "activity_labels.txt", sep=""), sep="", header=FALSE)
#Rename the columns
names(Activities) <- c("id_activity", "activity")

#Join the DataSet with Activities by "id_activity"
Dataset <- merge(Dataset, Activities, by = "id_activity")
#Delete the column "id_activity" because it is not necesary
dropColumn <- "id_activity"
Dataset <- Dataset[, !(names(Dataset) %in% dropColumn)]

#Convert the columns $activity and $subject to factor
Dataset$activity <- as.factor(Dataset$activity)
Dataset$subject <- as.factor(Dataset$subject)

#Get the mean grouped by activity and subject
tidyDataset <- aggregate(Dataset, list(activity = Dataset$activity, subject = Dataset$subject), mean)
tidyDataset <- tidyDataset[, 1:68]

#Write the result dataset to a file
write.table(tidyDataset, "tidyDataset.txt", sep=" ", row.names = FALSE)
