#Read data, labels and subjects from test
fileNameTest <- paste(getwd(), "/Input_data/test/X_test.txt", sep="")
dataTest <- read.csv(fileNameTest, sep="", header = FALSE)
fileNameLabelTest <- paste(getwd(), "/Input_data/test/y_test.txt", sep="")
dataTestLabel <- read.csv(fileNameLabelTest, sep="", header = FALSE)
fileNameSubjectTest <- paste(getwd(), "/Input_data/test/subject_test.txt", sep="")
dataTestSubject <- read.csv(fileNameSubjectTest, sep="", header = FALSE)

#Read label description, map to test data and enchance them
fileNameActivityLabel <- paste(getwd(), "/Input_data/activity_labels.txt", sep="")
ActivityLabel <- read.csv(fileNameActivityLabel, sep="", header = FALSE)
dataLabelDescriptive <- merge(ActivityLabel, dataTestLabel)
dataTestiLabel <- cbind(dataLabelDescriptive[,c(2)], dataTest)
#Rename column for merge
colnames(dataTestiLabel)[colnames(dataTestiLabel) == "dataLabelDescriptive[, c(2)]"] <- "Activity"
#Add subject and rename corresponding column
dataTestiLabeliSubject <- cbind(dataTestSubject, dataTestiLabel)
colnames(dataTestiLabeliSubject)[1] <- "Subject"


# Read data, labels and subject from train
fileNameTrain <- paste(getwd(), "/Input_data/train/X_train.txt", sep="")
dataTrain <- read.csv(fileNameTrain, sep="", header = FALSE)
fileNameTrainLabel <- paste(getwd(), "/Input_data/train/y_train.txt", sep="")
dataTrainLabel <- read.csv(fileNameTrainLabel, sep="", header = FALSE)
fileNameSubjectTrain <- paste(getwd(), "/Input_data/train/subject_train.txt", sep="")
dataTrainSubject <- read.csv(fileNameSubjectTrain, sep="", header = FALSE)
dataLabelTrainDescriptive <- merge(ActivityLabel, dataTrainLabel)
dataTrainiLabel <- cbind(dataLabelTrainDescriptive[,c(2)], dataTrain)
#Rename column for merge
colnames(dataTrainiLabel)[colnames(dataTrainiLabel) == "dataLabelTrainDescriptive[, c(2)]"] <- "Activity"
#Add subject and rename corresponding column
dataTrainiLabeliSubject <- cbind(dataTrainSubject, dataTrainiLabel)
colnames(dataTrainiLabeliSubject)[1] <- "Subject"

# merge both test and train
dataAll <- rbind(dataTestiLabeliSubject, dataTrainiLabeliSubject)

#Read features and change the column names in final data set
fileNameFeaturesLabel <- paste(getwd(), "/Input_data/features.txt", sep="")
featuresLabel <- read.csv(fileNameFeaturesLabel, sep="", header = FALSE)
colFeatures <- featuresLabel[, c(2)]
colFeatures <- append("Subject", append("Activity", colFeatures))
colnames(dataAll) <- colFeatures

#Select columns with mean and std
columnsToExtract <- append(colFeatures[grep("-mean(", colFeatures,fixed = TRUE)], colFeatures[grep("-std(", colFeatures,fixed = TRUE)])
columnsToExtract <- append("Subject", append("Activity", columnsToExtract))
dataExtract <- dataAll[, columnsToExtract]

#Split by activity and calculate average for each columns
#splitDataByActivity <- split(dataExtract, dataExtract$Activity)
splitDataByActivity <- split(dataExtract, dataExtract[, c("Subject","Activity")])
result <- sapply(splitDataByActivity, function(x) {colMeans(x[,c(3:length(columnsToExtract))], na.rm=TRUE)})
#replace NA data due to missing observation with "No data" message
result<- ifelse(is.na(result), "No data", result)

#Results are in result matrix
head(result)
