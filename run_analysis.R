#Download and unzip data
if(!file.exists("./data")){dir.create("./data")}
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileUrl,destfile="./data/Dataset.zip")

unzip(zipfile="./data/Dataset.zip",exdir="./data")

#Load activity and features
act <- read.table("./data/UCI HAR Dataset/activity_labels.txt")
colnames(act) <- c('activityId', 'activityType')
feat <- read.table("./data/UCI HAR Dataset/features.txt")

#Load and colname training datasets
x_train <- read.table("./data/UCI HAR Dataset/train/X_train.txt")
colnames(x_train) <- feat[ ,2]
y_train <- read.table("./data/UCI HAR Dataset/train/y_train.txt")
colnames(y_train) <- "activityId"
sub_train <- read.table("./data/UCI HAR Dataset/train/y_train.txt")
colnames(sub_train) <- "subjectId"

#Load and colname test datasets
x_test <- read.table("./data/UCI HAR Dataset/test/X_test.txt")
colnames(x_test) <- feat[ ,2]
y_test <- read.table("./data/UCI HAR Dataset/test/y_test.txt")
colnames(y_test) <- "activityId"
sub_test <- read.table("./data/UCI HAR Dataset/test/subject_test.txt")
colnames(sub_test) <- "subjectId"

#Bind and merge train and test datasets
train <- cbind(sub_train, y_train, x_train)
test <- cbind(sub_test, y_test, x_test)
har <- rbind(train, test)

#Extract column names
names <- colnames(har)

#Get representative logical vector
gnames <- (grepl("mean..", names) | grepl("std..",names) | grepl("activityId", names) | grepl("subjectId", names))

#Subset har to only contain mean and std columns
har1 <- har[, gnames==TRUE]
har1 <- merge(har1,act,by='activityId',all.x=TRUE)

#Create and write 2nd tidy dataset of averages
har2 <- aggregate(.~subjectId, har1, mean)
har2 <- har2[order(har2$subjectId, har2$activityId), ]
write.table(har2, file="C:/Users/ryan.maxfield/Desktop/tidydata.txt", row.name=FALSE)
