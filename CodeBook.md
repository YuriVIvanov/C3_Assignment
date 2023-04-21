---
title: "CodeBook"
author: "YUI"
date: "2023-04-21"
framework: Assigmnet for course 3
output: html_document
---
## Create a list of files to be used
```r
> str(getwd)
function ()
```

```r
> str(paste)
function (..., sep = " ", collapse = NULL, recycle0 = FALSE)
```
- `...` list of strings to be combined
- `sep` is a separator, empty space is used 

```r
>fileNameTest <- paste(getwd(), "/Input_data/test/X_test.txt", sep="")
>fileNameLabelTest <- paste(getwd(), "/Input_data/test/y_test.txt", sep="")
>fileNameSubjectTest <- paste(getwd(), "/Input_data/test/subject_test.txt", sep="")
>fileNameActivityLabel <- paste(getwd(), "/Input_data/activity_labels.txt", sep="")
>fileNameTrain <- paste(getwd(), "/Input_data/train/X_train.txt", sep="")
>fileNameTrainLabel <- paste(getwd(), "/Input_data/train/y_train.txt", sep="")
>fileNameSubjectTrain <- paste(getwd(), "/Input_data/train/subject_train.txt", sep="")
>fileNameFeaturesLabel <- paste(getwd(), "/Input_data/features.txt", sep="")
```
---


## Upload the data in R
```r
> str(read.csv)
function (file, header = TRUE, sep = ",", quote = "\"", dec = ".", fill = TRUE, comment.char = "", ...)
```
- `file` is a filename
- `sep` is a separator, empty space is used 
- `header` is a header, the data are without header used

```r
>dataTest <- read.csv(fileNameTest, sep="", header = FALSE)
>dataTestLabel <- read.csv(fileNameLabelTest, sep="", header = FALSE)
>dataTestSubject <- read.csv(fileNameSubjectTest, sep="", header = FALSE)
>ActivityLabel <- read.csv(fileNameActivityLabel, sep="", header = FALSE)
>dataTrain <- read.csv(fileNameTrain, sep="", header = FALSE)
>dataTrainLabel <- read.csv(fileNameTrainLabel, sep="", header = FALSE)
>dataTrainSubject <- read.csv(fileNameSubjectTrain, sep="", header = FALSE)
>featuresLabel <- read.csv(fileNameFeaturesLabel, sep="", header = FALSE)
```
---

## Combine the data
```r
> str(cbind)
function (..., deparse.level = 1) 
```
- `...` is a list of objects (vector or matrix) to be combined

```r
> str(rbind)
function (..., deparse.level = 1) 
```
- `...` is a list of objects (vector or matrix) to be combined

```r
>str(append)
function (x, values)
```
- `x` is an origin element
- `values` is a element to be added

```r
>str(merge)
function (x, y, ...) 
```
- `x` is a first element
- `y` is a second element

```r
Map label to descriptive activities (test data)
>dataLabelDescriptive <- merge(ActivityLabel, dataTestLabel)

Add label and rename corresponding column for merge with train data
>dataTestiLabel <- cbind(dataLabelDescriptive[,c(2)], dataTest)
>colnames(dataTestiLabel)[colnames(dataTestiLabel) == "dataLabelDescriptive[, c(2)]"] <- "Activity"

Add subject and rename corresponding column for merge with train data
>dataTestiLabeliSubject <- cbind(dataTestSubject, dataTestiLabel)
>colnames(dataTestiLabeliSubject)[1] <- "Subject"

*Map label to descriptive activities (train data)*
>dataLabelTrainDescriptive <- merge(ActivityLabel, dataTrainLabel)
>dataTrainiLabel <- cbind(dataLabelTrainDescriptive[,c(2)], dataTrain)

Add label and rename corresponding column for merge with test data
>colnames(dataTrainiLabel)[colnames(dataTrainiLabel) == "dataLabelTrainDescriptive[, c(2)]"] <- "Activity"

Add subject and rename corresponding column for merge with test data
>dataTrainiLabeliSubject <- cbind(dataTrainSubject, dataTrainiLabel)
>colnames(dataTrainiLabeliSubject)[1] <- "Subject"

Merge test and train data
>dataAll <- rbind(dataTestiLabeliSubject, dataTrainiLabeliSubject)
```
----

## Add descriptive features to data (dataAll)
```r
>colFeatures <- append("Subject", append("Activity", featuresLabel[, c(2)]))
>colnames(dataAll) <- colFeatures
```
---

## Extract the mean and std columns
```r
>columnsToExtract <- append(colFeatures[grep("-mean(", colFeatures,fixed = TRUE)], colFeatures[grep("-std(", colFeatures,fixed = TRUE)])
>columnsToExtract <- append("Subject", append("Activity", columnsToExtract))
>dataExtract <- dataAll[, columnsToExtract]
```
---

## Split extracted dat on pivot columns (activity and subject)
```r
>str(split)
function (x, f, drop = FALSE, ...)  
```
- `x` is a object to split
- `f` is a way to split

```r
>splitDataByActivity <- split(dataExtract, dataExtract[, c("Subject","Activity")])
```
---

##Perform analysis and replace errors
```r
>str(sapply)
function (X, FUN, ..., simplify = TRUE, USE.NAMES = TRUE)  
```
- `X` is a vector
- `FUN` is a function to be applied
- ... contains other arguments to be passed `FUN`
- `simplify`, should we simplify the result?

```r
>result <- sapply(splitDataByActivity, function(x) {colMeans(x[,c(3:length(columnsToExtract))], na.rm=TRUE)})
>result <- ifelse(is.na(result), "No data", result)
```

---
