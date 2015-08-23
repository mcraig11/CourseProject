#Getting and cleaning data class project
# merge training and test sets to create one data set
# extract only the measurements on the mean and std for each measurement
# use descriptive activity names to name the activities in the data set
# label the data set with descriptive variable names
# create a second, independent tiny data set with average of each variable for each activity and subject

library(plyr)
library(dplyr)
library(tidyr)
#read in datasets

test <- read.table("C:/Users/mcrai_000/Documents/R/CourseProject/UCI HAR Dataset/test/X_test.txt")
test_sub <- read.table("C:/Users/mcrai_000/Documents/R/CourseProject/UCI HAR Dataset/test/subject_test.txt")
test_act <- read.table("C:/Users/mcrai_000/Documents/R/CourseProject/UCI HAR Dataset/test/y_test.txt")

train <- read.table("C:/Users/mcrai_000/Documents/R/CourseProject/UCI HAR Dataset/train/X_train.txt")
train_sub <- read.table("C:/Users/mcrai_000/Documents/R/CourseProject/UCI HAR Dataset/train/subject_train.txt")
train_act <- read.table("C:/Users/mcrai_000/Documents/R/CourseProject/UCI HAR Dataset/train/y_train.txt")

#rename V1 as subject in subject train_sub and test_sub datasets
names(test_sub) <- "Subject"
names(train_sub) <- "Subject"

#rename v1 as activity in train_act and test_act sets
names(test_act) <- "Activity"
names(train_act) <- "Activity"

#read in features and activity lable data sets
features <- read.table("C:/Users/mcrai_000/Documents/R/CourseProject/UCI HAR Dataset/features.txt")
act_lab <- read.table("C:/Users/mcrai_000/Documents/R/CourseProject/UCI HAR Dataset/activity_labels.txt")

#goal is to isolate only variables that are mean and std
#store as a data table
feat_tbl <- tbl_df(features)

#first lable the two datasets using the features file
#subset the features table to create a list of variable names
thing2 <- as.character(features$V2)
#rename the variables for each dataset using the variable names from features
names(test) <- thing2
names(train) <- thing2

#now identify the meanand std variables
#separate features$v2 into readable parts
feat <- separate(feat_tbl, V2, into = c("move", "measure", "axis"), sep = "-", extra = "drop")

#filter feat to keep only mean and std variables
feat_1 <- filter(feat, measure == "mean()" | measure == "std()")

#the values in V1 correspond to the column numbers in the test and train data sets of the
#variables we wish to examine.

#subset feat_1$v1 and store as vector
keep <- as.vector(select(feat_1, V1))
keep1 <- as.vector(keep$V1)

#use keep to subset the test and train datasets
test1 <- subset(test, select = keep1)
train1 <- subset(train, select = keep1)



#now merge the two data sets. merging is done with the smaller data sets for memory allocation reasons
all <- rbind(test1, train1)

#the all data.frame has 10,299 observations of 66 variables

#now add the subject identifier and activity number data sets to their respectice measurement sets
test2 <- cbind(test_sub, test_act)
train2 <- cbind(train_sub, train_act)
sub_act <- rbind(test2, train2)

#now bind sub_act to the complete training data set "all"
happy <- cbind(sub_act, all)

#replace numeric activity values with descriptive names
actlist <- c("walking", "walking up", "walking down", "sitting", "standing", "laying")
tidy_data <- within(happy, Activity <- factor(Activity, labels = actlist))
tidy_data1 <- group_by(tidy_data, Subject, Activity)
tidy_data2 <- summarise_each(tidy_data1,funs(mean))

#write final data set to txt file
write.table(tidy_data2, "C:/Users/mcrai_000/Documents/R/UCI HAR Dataset/CourseProject.txt", row.name=FALSE)