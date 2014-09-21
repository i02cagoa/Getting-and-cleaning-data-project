urlTrainingData <- "./UCI HAR Dataset/train/"
urlTestData <- "./UCI HAR Dataset/test/"
url <- "./UCI HAR Dataset/"

features<- read.csv(paste(url, "features.txt", sep=""), sep="", header=FALSE)
colSelected <- grep("*-mean\\(\\)-*|*-std\\(\\)-*", features[,2])

trainingX <- read.csv(paste(urlTrainingData, "X_train.txt", sep=""), sep="", header=FALSE)
names(trainingX) <- features[,2]
trainingX <- trainingX[, colSelected]
trainingY <- read.csv(paste(urlTrainingData, "y_train.txt", sep=""), sep="", header=FALSE)
names(trainingY) <- "id_activity"
trainingSubject <- read.csv(paste(urlTrainingData, "subject_train.txt", sep=""), sep="", header=FALSE)
names(trainingSubject) <- "subject"
trainingDataset <- data.frame(c(trainingX, trainingY, trainingSubject))

testX <- read.csv(paste(urlTestData, "X_test.txt", sep=""), sep="", header=FALSE)
names(testX) <- features[,2]
testX <- testX[, colSelected]
testY <- read.csv(paste(urlTestData, "Y_test.txt", sep=""), sep="", header=FALSE)
names(testY) <- "id_activity"
testSubject <- read.csv(paste(urlTestData, "subject_test.txt", sep=""), sep="", header=FALSE)
names(testSubject) <- "subject"
testDataset <- data.frame(c(testX, testY, testSubject))

Dataset <- rbind(trainingDataset, testDataset)


Activities <- read.csv(paste(url, "activity_labels.txt", sep=""), sep="", header=FALSE)
names(Activities) <- c("id_activity", "activity")

Dataset <- merge(Dataset, Activities, by = "id_activity")
dropColumn <- "id_activity"

Dataset <- Dataset[, !(names(Dataset) %in% dropColumn)]

Dataset$activity <- as.factor(Dataset$activity)
Dataset$subject <- as.factor(Dataset$subject)

tidyDataset <- aggregate(Dataset, list(activity = Dataset$activity, subject = Dataset$subject), mean)
tidyDataset <- tidyDataset[, 1:68]

write.table(tidyDataset, "tidyDataset.txt", sep=" ", row.names = FALSE)
